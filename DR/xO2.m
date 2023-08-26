function x =xO2(a,gamma,z,w)
% input data is scenario dependent
x_aux = (gamma*dot(w,a) - dot(z,a))/(2*gamma*dot(a,a)-1);
x = z - gamma*(w - 2*a*x_aux);
end