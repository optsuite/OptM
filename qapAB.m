function [f, g] = qapAB(X,A,B)
% f = trace(A'*X*B*X')
AXB = (A'*X*B);
g = AXB + A*X*B';
% f = sum(dot(X,AXB));
% f = trace(X*AXB);
f = sum(sum(X.*AXB));

