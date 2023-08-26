function X = rand_pick_sphere(N,d)
X = rand(N,d); % A normal dist is symmetrical
X = X./sqrt(sum(X.^2,2)); % project to the surface of the Ndim-sphere
% radial scale factor
R = nthroot(rand(N,1),d);
% Combine
X = X.*R;
end