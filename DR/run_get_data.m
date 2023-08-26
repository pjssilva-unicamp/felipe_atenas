N = 300;
d = 100;

[a,b,x_ref,gamma,kmax] = gen_data(N,d);
z0 = rand_pick_sphere(15,d);

kmax = 100;

% save('data_DR_N150_d50_1.mat','a','b','N','d','kmax','gamma','x_ref','z0')
save('data_DR_N300_d100_1.mat','a','b','N','d','kmax','gamma','x_ref','z0')