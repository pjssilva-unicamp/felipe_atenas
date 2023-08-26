function x =xO3(a,b,gamma,z,w)
% input data is scenario dependent
x_aux = (-gamma*dot(w,a) + dot(z,a) + sqrt(b))/(dot(a,a));
x = z - gamma*w - a*x_aux;
end