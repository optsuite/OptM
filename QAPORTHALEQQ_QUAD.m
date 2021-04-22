function [X, out] = QAPORTHALEQQ_QUAD(X, A, B, mu, opts)

%% ------------------------------------------------------------------------
% Quadratic Assignment problem:
%  min Tr(XAXB), s.t., X'*X = I, X >= 0
%                      <E,X> = n

%% ------------------------------------------------------------------------


if isfield(opts, 'objX')
    if opts.objX < 0 || opts.objX > 10
        opts.objX = 1;
    end
else
    opts.objX = 1;
end
objX = opts.objX;


%Initialize
tol     = opts.tol;     tolsub  = opts.tolsub;
optsub  = opts;


%compute f and g
[m,n] = size(A); lmb = zeros(n,n); Axlmb = []; 
lmb1 = zeros(n,1);  Xen = zeros(n,1);  
lmb2 = zeros(n,1);  Xtn = zeros(n,1);
lmb3 = zeros(1,1);  Xsn = zeros(1,1);

f = inf;    fQAP = inf;     
out.itrsub = 0; out.nfe = 0;
for itr = 1:opts.omxitr
    fp = f;
    [X, outs]= OptStiefelGBB(X, @ObjQAPALEQ_QUAD, optsub); 
    out.itrsub = out.itrsub + outs.itr;
    out.nfe = out.nfe + outs.nfe;
    f = outs.fval;  fdiff = abs(f-fp)/(abs(fp)+1);
    feasi = norm(min(X,0),1);
    if opts.record
        fprintf('itr: %3d, mu: %3.2e, fdiff: %3.2e, feasi: %3.2e\n\n', ...
            itr, mu, fdiff, feasi);
    end
    
    if feasi <= tol
        break;
    end
    
    lmb  = max(lmb-mu*X,0);
%     lmb1 = lmb1 - mu*Xen;
%     lmb2 = lmb2 - mu*Xtn;
%     lmb3 = lmb3 - mu*Xsn;
    if feasi > max(tol,tolsub); 
        mu = mu*1.2; 
%     else
%       mu = mu*0.8;
    end
end
out.itr = itr;
out.fval = fQAP;

% AXB = (A'*X*B);
% g = AXB + A*X*B';
% % f = sum(dot(X,AXB));
% % f = trace(X*AXB);
% f = sum(sum(X.*AXB));

    function [f, g] = ObjQAPALEQ_QUAD(X)
        if objX == 1
            AXB = (A'*X*B);     %fQAP = sum(dot(X,AXB));
            fQAP = sum(sum(X.*AXB));
            g = AXB + A*X*B';
        elseif objX == 2
            X2 = X.^2;
            AXB = (A'*X2*B);     %fQAP = sum(dot(X2,AXB));
            fQAP = sum(sum(X2.*AXB));
            g = 2*(AXB + (A*X2*B')).*(X);
        else
            X1 = X.^(objX-1);  X2 = X.*X1;
            AXB = (A'*X2*B);     %fQAP = sum(dot(X2,AXB));
            fQAP = sum(sum(X2.*AXB));
            g = (objX*(AXB + (A*X2*B'))).*(X1);
        end
        
        %Xen = sum(X,2) - n; Xtn = sum(X,1)' - n;    %Xsn = sum(sum(X))-n;
        Axlmb = X-lmb/mu;   Idx = (Axlmb<=0);  Axlmb(~Idx) = 0;
        
        f = fQAP + sum(-lmb(Idx).*X(Idx)+0.5*mu*X(Idx).^2) ...
            - 0.5/mu*sum(lmb(~Idx).^2); ...
%             - lmb1'*Xen + 0.5*mu*dot(Xen,Xen)...
%             - lmb2'*Xtn + 0.5*mu*dot(Xtn,Xtn); ...
%             - lmb3*Xsn  + 0.5*mu*Xsn^2;
        g = g  + mu*Axlmb; ...
%             -repmat(lmb1,1,n)  + mu*repmat(Xen,1,n) ...
%             -repmat(lmb2',n,1) + mu*repmat(Xtn',n,1); ...
%             -lmb3 + mu*Xsn;
    end


end


