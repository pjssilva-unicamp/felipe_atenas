function y = f_DR(a,b,gamma,x,z,w)
% phase retrieval s-subproblem objective function
% input data is NOT scenario dependent
% w : multipliers, in R^{N x d}
% z : center, in R^{N x d}
% x : candidate, in R^d
N = length(b);
y = 0.0;
for i=1:N
    y = y + (1.0/N)*(abs(dot(a(i,:),x)^2-b(i)) + dot(w(i,:),x) + 0.5*(1.0/gamma)*dot(x-z(i,:),x-z(i,:)));
end
end
