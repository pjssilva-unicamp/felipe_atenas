function y = f_s(a,b,gamma,x,z,w)
% phase retrieval s-subproblem objective function
% input data is scenario dependent
y = abs(dot(a,x)^2-b) + dot(w,x) + (0.5/gamma)*dot(x-z,x-z);
end

