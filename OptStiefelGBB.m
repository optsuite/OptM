function [X, out]= OptStiefelGBB(X, fun, opts, varargin)
%-------------------------------------------------------------------------
% curvilinear search algorithm for optimization on Stiefel manifold
%
%   min F(X), S.t., X'*X = I_k, where X \in R^{n,k}
%
%   H = [G, X]*[X -G]'
%   U = 0.5*tau*[G, X];    V = [X -G]
%   X(tau) = X - 2*U * inv( I + V'*U ) * V'*X
%
%   -------------------------------------
%   U = -[G,X];  V = [X -G];  VU = V'*U;
%   X(tau) = X - tau*U * inv( I + 0.5*tau*VU ) * V'*X
%
%
% Input:
%           X --- n by k matrix such that X'*X = I
%         fun --- objective function and its gradient:
%                 [F, G] = fun(X,  data1, data2)
%                 F, G are the objective function value and gradient, repectively
%                 data1, data2 are addtional data, and can be more
%                 Calling syntax:
%                   [X, out]= OptStiefelGBB(X0, @fun, opts, data1, data2);
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
%           X --- solution
%         Out --- output information
%
% -------------------------------------
% For example, consider the eigenvalue problem F(X) = -0.5*Tr(X'*A*X);
%
% function demo
% 
% function [F, G] = fun(X,  A)
%   G = -(A*X);
%   F = 0.5*sum(dot(G,X,1));
% end
% 
% n = 1000; k = 6;
% A = randn(n); A = A'*A;
% opts.record = 0; %
% opts.mxitr  = 1000;
% opts.xtol = 1e-5;
% opts.gtol = 1e-5;
% opts.ftol = 1e-8;
% 
% X0 = randn(n,k);    X0 = orth(X0);
% tic; [X, out]= OptStiefelGBB(X0, @fun, opts, A); tsolve = toc;
% out.fval = -2*out.fval; % convert the function value to the sum of eigenvalues
% fprintf('\nOptM: obj: %7.6e, itr: %d, nfe: %d, cpu: %f, norm(XT*X-I): %3.2e \n', ...
%             out.fval, out.itr, out.nfe, tsolve, norm(X'*X - eye(k), 'fro') );
% 
% end
% -------------------------------------
%
% Reference: 
%  Z. Wen and W. Yin
%  A feasible method for optimization with orthogonality constraints
%
% Author: Zaiwen Wen, Wotao Yin
%   Version 0.1 .... 2010/10
%   Version 0.5 .... 2013/10
%-------------------------------------------------------------------------


%% Size information
if isempty(X)
    error('input X is an empty matrix');
else
    [n, k] = size(X);
end

if nargin < 2; error('[X, out]= OptStiefelGBB(X0, @fun, opts)'); end
if nargin < 3; opts = [];   end

if ~isfield(opts, 'X0');        opts.X0 = [];  end
if ~isfield(opts, 'xtol');      opts.xtol = 1e-6; end
if ~isfield(opts, 'gtol');      opts.gtol = 1e-6; end
if ~isfield(opts, 'ftol');      opts.ftol = 1e-12; end

% parameters for control the linear approximation in line search,
if ~isfield(opts, 'tau');       opts.tau  = 1e-3; end
if ~isfield(opts, 'rhols');     opts.rhols  = 1e-4; end
if ~isfield(opts, 'eta');       opts.eta  = 0.1; end
if ~isfield(opts, 'retr');      opts.retr = 0; end
if ~isfield(opts, 'gamma');     opts.gamma  = 0.85; end
if ~isfield(opts, 'STPEPS');    opts.STPEPS  = 1e-10; end
if ~isfield(opts, 'nt');        opts.nt  = 5; end
if ~isfield(opts, 'mxitr');     opts.mxitr  = 1000; end
if ~isfield(opts, 'record');    opts.record = 0; end
if ~isfield(opts, 'tiny');      opts.tiny = 1e-13; end

%-------------------------------------------------------------------------------
% copy parameters
xtol    = opts.xtol;
gtol    = opts.gtol;
ftol    = opts.ftol;
rhols   = opts.rhols;
STPEPS  = opts.STPEPS;
eta     = opts.eta;
gamma   = opts.gamma;
retr    = opts.retr;
record  = opts.record;
nt      = opts.nt;  
crit    = ones(nt, 3);
tiny    = opts.tiny;
%-------------------------------------------------------------------------------

%% Initial function value and gradient
% prepare for iterations
[F,  G] = feval(fun, X , varargin{:});  out.nfe = 1;  
GX = G'*X;

if retr == 1
    invH = true; if k < n/2; invH = false;  eye2k = eye(2*k); end
    if invH
        GXT = G*X';  H = 0.5*(GXT - GXT');  RX = H*X;
    else
        U =  [G, X];    V = [X, -G];       VU = V'*U;
        %U =  [G, X];    VU = [GX', X'*X; -(G'*G), -GX];
        %VX = VU(:,k+1:end); %VX = V'*X;
        VX = V'*X;
    end
end
dtX = G - X*GX;     nrmG  = norm(dtX, 'fro');
  
Q = 1; Cval = F;  tau = opts.tau;

%% Print iteration header if debug == 1
if (opts.record == 1)
    fid = 1;
    fprintf(fid, '----------- Gradient Method with Line search ----------- \n');
    fprintf(fid, '%4s %8s %8s %10s %10s\n', 'Iter', 'tau', 'F(X)', 'nrmG', 'XDiff');
    %fprintf(fid, '%4d \t %3.2e \t %3.2e \t %5d \t %5d	\t %6d	\n', 0, 0, F, 0, 0, 0);
end

%% main iteration
for itr = 1 : opts.mxitr
    XP = X;     FP = F;   GP = G;   dtXP = dtX;
     % scale step size

    nls = 1; deriv = rhols*nrmG^2; %deriv
    while 1
        % calculate G, F,        
        if retr == 1
            if invH
                [X, infX] = linsolve(eye(n) + tau*H, XP - tau*RX);
            else
                [aa, infR] = linsolve(eye2k + (0.5*tau)*VU, VX);
                X = XP - U*(tau*aa);
            end
        else
            [X, RR] = myQR(XP - tau*dtX, k);
        end
        
        if norm(X'*X - eye(k),'fro') > tiny; X = myQR(X,k); end
        
        [F,G] = feval(fun, X, varargin{:});
        out.nfe = out.nfe + 1;
        
        if F <= Cval - tau*deriv || nls >= 5
            break;
        end
        tau = eta*tau;          nls = nls+1;
    end  
    
    GX = G'*X;
    if retr == 1
        if invH
            GXT = G*X';  H = 0.5*(GXT - GXT');  RX = H*X;
        else
            U =  [G, X];    V = [X, -G];       VU = V'*U;
            %U =  [G, X];    VU = [GX', X'*X; -(G'*G), -GX];
            %VX = VU(:,k+1:end); % VX = V'*X;
            VX = V'*X;
        end
    end
    dtX = G - X*GX;     nrmG  = norm(dtX, 'fro');    
    S = X - XP;         XDiff = norm(S,'fro')/sqrt(n);
    tau = opts.tau;     FDiff = abs(FP-F)/(abs(FP)+1);
    
    %Y = G - GP;     SY = abs(iprod(S,Y));
    Y = dtX - dtXP;     SY = abs(iprod(S,Y));
    if mod(itr,2)==0; tau = (norm(S,'fro')^2)/SY;
    else tau  = SY/(norm(Y,'fro')^2); end
    tau = max(min(tau, 1e20), 1e-20);
    
    if (record >= 1)
        fprintf('%4d  %3.2e  %4.3e  %3.2e  %3.2e  %3.2e  %2d\n', ...
            itr, tau, F, nrmG, XDiff, FDiff, nls);
        %fprintf('%4d  %3.2e  %4.3e  %3.2e  %3.2e (%3.2e, %3.2e)\n', ...
        %    itr, tau, F, nrmG, XDiff, alpha1, alpha2);
    end
    
    crit(itr,:) = [nrmG, XDiff, FDiff];
    mcrit = mean(crit(itr-min(nt,itr)+1:itr, :),1);
    %if (XDiff < xtol && nrmG < gtol ) || FDiff < ftol
    %if (XDiff < xtol || nrmG < gtol ) || FDiff < ftol
    %if ( XDiff < xtol && FDiff < ftol ) || nrmG < gtol
    %if ( XDiff < xtol || FDiff < ftol ) || nrmG < gtol
    %if any(mcrit < [gtol, xtol, ftol])
    if ( XDiff < xtol && FDiff < ftol ) || nrmG < gtol || all(mcrit(2:3) < 10*[xtol, ftol])
        out.msg = 'converge';
        break;
    end
    
    Qp = Q; Q = gamma*Qp + 1; Cval = (gamma*Qp*Cval + F)/Q;
 end

if itr >= opts.mxitr
    out.msg = 'exceed max iteration';
end

out.feasi = norm(X'*X-eye(k),'fro');
if  out.feasi > 1e-13
    %X = MGramSchmidt(X);
    X = myQR(X,k);
    [F,G] = feval(fun, X, varargin{:});
    out.nfe = out.nfe + 1;
    out.feasi = norm(X'*X-eye(k),'fro');
end

out.nrmG = nrmG;
out.fval = F;
out.itr = itr;
end

function a = iprod(x,y)
%a = real(sum(sum(x.*y)));
a = real(sum(sum(conj(x).*y)));
end



function [Q, RR] = myQR(XX,k)
[Q, RR] = qr(XX, 0);
diagRR = sign(diag(RR)); ndr = diagRR < 0;
if nnz(ndr) > 0
    Q = Q*spdiags(diagRR,0,k,k);
    %Q(:,ndr) = Q(:,ndr)*(-1);
end
end

