function [a,b,x_ref,gamma,kmax] = gen_data(N,d)

a = randn(N,d);

%load('DRS01.mat');

gamma = 0.01;
kmax = 100;

%reference point 
x_ref = rand_pick_sphere(1,d); 

% create the right-hand side vector using the reference point, target in R^d
for i=1:N
    b(i) = dot(a(i,:),x_ref)^2; % in R
end
end