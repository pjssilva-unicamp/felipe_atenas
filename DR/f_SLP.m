function y = f_SLP(r,g,delta_i)
% phase retrieval subproblem objective function for SLP
% input data is scenario dependent
N = length(r); 
y = 0.0;
for i = 1:N
    y = y + abs(r(i)+dot(g(i,:),delta_i));
end
y = (1.0/N)*y + 0.5*dot(delta_i,delta_i);
end