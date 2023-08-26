function y = f_SPP(a,b,gamma,x,z)
% phase retrieval (whole) problem objective function
% input data is NOT scenario dependent
% x : candidate
% z : center (previous iterate)
[N,~] = size(a);
y = 0;
for i = 1:N
    y = y + abs(dot(a(i,:),x)^2-b(i));
end
y = (1.0/N)*y + 0.5*(1.0/gamma)*dot(x-z,x-z); 
end
