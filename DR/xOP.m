function x = xOP(j,a,b,gamma,z,w)
% data are scenario dependent, therefore x \in R
if j == 1
    x = xO1(a,gamma,z,w);
elseif j == 2
    x = xO2(a,gamma,z,w);
elseif j == 3
    x = xO3(a,b,gamma,z,w);
else
    x = xO4(a,b,gamma,z,w);
end
end