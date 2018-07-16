function [x, g, out]= OptManiMulitBallGBB(x, fun, opts, varargin)
%-------------------------------------------------------------------------
% Line search algorithm for optimization on manifold:
%
% Model 1:
%   min f(X), s.t., ||X_i||_2 = radius, where X \in R^{n,p}
%       g(X) = grad f(X)
%   X = [X_1, X_2, ..., X_p]
%
%    each column of X lies on a unit sphere
%
% Model 2:
%   min f(X), s.t., ||X||_F = radius, where X \in R^{n,p}
%   X is lies on a single sphere
%
%
% Input:
%           X --- ||X_i||_2 = radius, each column of X lies on a unit sphere
%         fun --- objective function and its gradient:
%                 [F, G] = fun(X,  data1, data2)
%                 F, G are the objective function value and gradient, repectively
%                 data1, data2 are addtional data, and can be more
%                 Calling syntax:
%                   [X, out]= OptManiMulitBallGBB(X0, @fun, opts, data1, data2);
%
%        opts --- option structure with fields:
%                 record = 0, no print out
%                 mxitr       max number of iterations
%                 xtol        stop control for ||X_k - X_{k-1}||
%                 gtol        stop control for the projected gradient
%                 ftol        stop control for |F_k - F_{k-1}|/(1+|F_{k-1}|)
%                             usually, max{xtol, gtol} > ftol
%   
% Output:
%           x --- solution
%           g --- gradient of x
%         Out --- output information
%
% -------------------------------------
% For example, consider the maxcut SDP: 
% X is n by n matrix
% max Tr(C*X), s.t., X_ii = 1, X psd
%
% low rank model is:
% X = V'*V, V = [V_1, ..., V_n], V is a p by n matrix
% max Tr(C*V'*V), s.t., ||V_i|| = 1,
%
% function [f, g] = maxcut_quad(V, C)
% g = 2*(V*C);
% f = sum(dot(g,V))/2;
% end
%
% [x, g, out]= OptManiMulitBallGBB(x0, @maxcut_quad, opts, C); 
%
% -------------------------------------
%
% Reference: 
%  Z. Wen and W. Yin
%  A feasible method for optimization with orthogonality constraints
%
% Author: Zaiwen Wen
%   Version 0.1 .... 2010/10
%   Version 0.5 .... 2013/10
%-------------------------------------------------------------------------

% termination rule
if ~isfield(opts, 'gtol');      opts.gtol = 1e-5;  end % 1e-5
if ~isfield(opts, 'xtol');      opts.xtol = 1e-6;  end % 1e-6
if ~isfield(opts, 'ftol');      opts.ftol = 1e-13; end % 1e-13

% parameters for control the linear approximation in line search,
if ~isfield(opts, 'tau');       opts.tau  = 1e-3;     end
if ~isfield(opts, 'rhols');     opts.rhols  = 1e-4;   end
if ~isfield(opts, 'eta');       opts.eta  = 0.1;      end
if ~isfield(opts, 'gamma');     opts.gamma  = 0.85;   end
if ~isfield(opts, 'STPEPS');    opts.STPEPS  = 1e-10; end
if ~isfield(opts, 'nt');        opts.nt  = 3;         end % 3
if ~isfield(opts, 'maxit');     opts.maxit  = 1000;   end
if ~isfield(opts, 'eps');       opts.eps = 1e-14;     end
if ~isfield(opts, 'record');    opts.record = 0;      end
if ~isfield(opts, 'model');     opts.model = 1;       end
if ~isfield(opts, 'radius');    opts.radius = 1;      end

fid = 1;
if isfield(opts, 'recordFile')
    fid = fopen(opts.recordFile,'a+');
end

%-------------------------------------------------------------------------------
% copy parameters
gtol = opts.gtol;
xtol = opts.xtol;
ftol = opts.ftol;
maxit = opts.maxit;
rhols = opts.rhols;
eta   = opts.eta;
eps   = opts.eps;
gamma = opts.gamma;
record = opts.record;
model  = opts.model;
radius = opts.radius;
nt = opts.nt;
crit = ones(nt,1);

% normalize x so that ||x||_2 = 1
if model == 1
    nrmx = dot(x,x,1);
    if norm(nrmx - radius,'fro')> eps; 
        x = radius*bsxfun(@rdivide, x, sqrt(nrmx)); end;
else
    nrmx = norm(x,'fro'); 
    if abs(nrmx - radius)> eps; x = x*(radius/nrmx); end;
end

%% Initial function value and gradient
% prepare for iterations
[f,g] = feval(fun, x, varargin{:});    out.nfe = 1;  out.fval0 = f;

if model == 1
    xtg = dot(x,g,1);   gg = dot(g,g,1);
    xx = dot(x,x,1);    xxgg = xx.*gg;
    dtX = bsxfun(@times, xtg, x) - g; %bsxfun(@times, xx, g);    
    nrmG = norm(dtX, 'fro');
else
    xtg = iprod(x,g);   gg = norm(g,'fro')^2;
    xx = norm(x,'fro')^2;    xxgg = xx.*gg;
    dtX = xtg*x - xx*g;    nrmG = norm(dtX, 'fro');
end

Q = 1; Cval = f; tau = opts.tau;

%% Print iteration header if debug == 1
if (record >= 1)
    fprintf('----------- OptM For Spherical Constraints ----------- \n');
    fprintf(fid,'%4s \t %10s \t %10s \t  %10s \t %10s \t %10s \t %10s \t %10s\n', ...
        'Iter', 'tau', 'f(X)', 'nrmG', 'XDiff', 'FDiff', 'nls', 'feasi');
end

if record == 10; out.fvec = f; end
out.msg = 'exceed max iteration';

%% main iteration
for iter = 1 : maxit
    xp = x;     fp = f;     gp = g;   dtXP =  dtX;

    nls = 1; deriv = rhols*nrmG^2;
    while 1
        % calculate f, g
        tau2 = tau/2;     beta = (1+(tau2)^2*(-xtg.^2+xxgg));
        a1 = ((1+tau2*xtg).^2 -(tau2)^2*xxgg)./beta;
        a2 = -tau*xx./beta;
        x = bsxfun(@times, a1, xp) + bsxfun(@times, a2, gp);

        [f,g] = feval(fun, x, varargin{:});   out.nfe = out.nfe + 1;
        if f <= Cval - tau*deriv || nls >= 5
            break
        end
        tau = eta*tau;
        nls = nls+1;
    end  
    
%     % ---- enforce orthogonality ----
    feasi = compute_feasi();
    if feasi > eps
        if model == 1; x = radius*bsxfun(@rdivide, x, nrmx);
        else x = x*(radius/nrmx); end
        
        [f,g] = feval(fun, x, varargin{:});   out.nfe = out.nfe + 1;
    end    
    
    if record == 10; out.fvec = [out.fvec; f]; end

    if model == 1
        xtg = dot(x,g,1);   gg = dot(g,g,1);
        xx = dot(x,x,1);    xxgg = xx.*gg;
        dtX = bsxfun(@times, xtg, x) - g; %bsxfun(@times, xx, g);    
        nrmG = norm(dtX, 'fro');
    else
        xtg = iprod(x,g);   gg = norm(g,'fro')^2;
        xx = norm(x,'fro')^2;    xxgg = xx.*gg;
        dtX = xtg*x - xx*g;    nrmG = norm(dtX, 'fro');
    end
    
    s = x - xp;
    XDiff = norm(s,'fro'); % (relative Xdiff) ~ g    
    FDiff = abs(f-fp)/(abs(fp)+1);

    % ---- record ----
    if (record >= 1)
        fprintf(fid,'%4d \t %3.2e \t %14.13e \t %3.2e \t %3.2e \t %3.2e \t %2d \t feasi: %2.1e\n', ...
            iter, tau, f, nrmG, XDiff, FDiff, nls, feasi);
    end

%     crit(iter,:) = [nrmG, XDiff, FDiff];
%     mcrit = mean(crit(iter-min(nt,iter)+1:iter, :),1);
%     if ( XDiff < xtol && FDiff < ftol ) || nrmG < gtol ...
% %             || all(mcrit(2:3) < 10*[xtol, ftol])

    crit(iter) = FDiff;
    mcrit = mean(crit(iter-min(nt,iter)+1:iter)); 

    % ---- termination ----
%     if nrmG < gtol || XDiff < xtol || FDiff < ftol
    if nrmG < gtol || XDiff < xtol || mcrit < ftol
        out.msg = 'converge';
        if nrmG  < gtol, out.msg = strcat(out.msg,'_g'); end
        if XDiff < xtol, out.msg = strcat(out.msg,'_x'); end
%         if FDiff < ftol, out.msg = strcat(out.msg,'_f'); end
        if mcrit < ftol, out.msg = strcat(out.msg,'_mf'); end
        break;
    end
    
    % y = g - gp;      
    y = dtX - dtXP;
    sy = abs(iprod(s,y));    tau = opts.tau;
    if sy > 0; 
        if mod(iter,2)==0; tau = (norm(s(:),'fro')^2)/sy;
        else tau = sy/(norm(y(:),'fro')^2); end
%         % safeguarding on tau
%         tau1 = (norm(s(:),'fro')^2)/sy;
%         tau2 = sy/(norm(y(:),'fro')^2); 
%         if tau2 < 0.1*tau1; tau = tau2; 
%         else tau = tau1; end
        tau = max(min(tau, 1e20), 1e-20);
    end

%     y = dtX - dtXP;
%     sy = abs(iprod(s,y));    tau = opts.tau;
%     dsnrm = norm(s(:),'fro');
%     dynrm = norm(y(:),'fro');
%     if sy > 1e-8*dsnrm*dynrm
%          tau = sy/dynrm^2;
%     else
%          tau = 0.1*dsnrm/dynrm;
%     end
%     tau = max(min(tau, 1e20), 1e-20);
    
    Qp = Q; Q = gamma*Qp + 1; Cval = (gamma*Qp*Cval + f)/Q;
end

if feasi > eps
    if model == 1; x = radius*bsxfun(@rdivide, x, nrmx); 
    else x = x*(radius/nrmx); end
    [f,g] = feval(fun, x, varargin{:});   out.nfe = out.nfe + 1;
    if model == 1; xtg = dot(x,g,1); else xtg = iprod(x,g); end
    
    if model == 1; nrmx = sqrt(dot(x,x,1)); out.feasi = norm(nrmx-radius);
    else nrmx = norm(x,'fro'); out.feasi = abs(nrmx-radius); end
end

out.feasi = feasi; 

xtg = xtg/radius^2;

out.xtg = xtg; % Lagrangian multipliers of the constraints (=2\mu)
out.XDiff = XDiff;
out.FDiff = FDiff;
out.mcrit = mcrit;
out.nrmG = nrmG;
out.fval = f;
out.iter = iter;

    function feasi = compute_feasi()
        nrmx = sqrt(xx);
        if model == 1; feasi = norm(nrmx -radius);
        else feasi = abs(nrmx-radius); end
    end

end

function a = iprod(x,y)
    a = real(sum(sum(conj(x).*y)));
end
