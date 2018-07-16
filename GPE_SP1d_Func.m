function [f, g, mu, rms] = GPE_SP1d_Func(X, data)

% problem with a single sphere:  
% min F(x), s.t. ||X||_F = 1
%  
% Example from BEC:
% [X, ~, out] = OptManiMulitBallGBB(X0, @GPE_SP1d_Func, opts, data);
%
% Reference: 
%   Xinming Wu, Zaiwen Wen, and Weizhu Bao. A regularized Newton method
%   for computing ground states of Bose–Einstein condensates. Journal of
%   Scientific Computing (2017): 303-329.
%
%
% Author: Xinming Wu, Zaiwen Wen
%   Version 0.5 .... 2016/10

beta = data.beta;
h = data.dx;
V = data.V;

% Energy Function and Gradient in 1d
% f = E(Phi)
%   = (Phi,-Lap/2*Phi) + (Phi,V*Phi) + (|Phi|^4,1)*beta/2
% 
% Let Phi = X/sqrt(h), then
% f = E(X)
%   = <X,-Lap/2*X> + <X,V*X> + <|X|^4,1>*beta/2/h
%   = <Xs,mu2*Xs>*(N+1)/2 + <X,V*X> + <|X|^4,1>*beta/2/h
% g = grad E(X)
%   = dst(mu2*Xs) + V*X + |X|^2*X*beta/h
% 
Nx = data.Nx-2;
Lx = data.xmax-data.xmin;

mu2 = ((1:Nx).').^2*(pi/Lx)^2/2;
Xs = idst(X);

mu2Xs = mu2.*Xs;
VX = V.*X;

f = Xs'*mu2Xs*(Nx+1)/2 + X'*VX + sum(abs(X).^4)*beta/2/h;
g = 2*(dst(mu2Xs) + VX + abs(X).^2.*X*beta/h);

if nargout<3, return; end

% Chemical Potential
% mu = f + (|Phi|^4,1)*beta/2
%    = f + <|X|^4,1>*beta/2/h
mu = f + sum(abs(X).^4)*beta/2/h;

% Root Mean Square
% rms = sqrt(x^2*|Phi|^2,1)
%     = sqrt<x^2*|X|^2,1>
x = data.x(2:end-1);
rms = sqrt(sum(x.^2.*abs(X).^2));
