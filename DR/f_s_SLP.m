function y = f_s_SLP(r,g,delta)
% phase retrieval subproblem objective function for SLP
% input data is scenario dependent
y = abs(r+dot(g,delta)) + 0.5*dot(delta,delta);
end