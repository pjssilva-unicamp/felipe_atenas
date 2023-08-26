clear all; clc; close all;
% input data
reuse_data = true;
if reuse_data
    %load('data_DR_N30_d10_1.mat');
    %load('data_DR_N150_d50_1.mat');
    load('data_DR_N300_d100_1.mat')
    %s0 = s;
else
    s0 = rand_pick_sphere(N,d); 
    [a,b,x_ref,gamma,kmax] = gen_data(N,d);
end

err = 1e-6;
% elicitation parameter 
e = 0.01;
% r = linspace(1.0,1000.0,20) + e;

%lambdas = linspace(0.05,1.95,20);
gammas = linspace(1,10000,20);%0.99*((2-lambdas)/2);

it_max = length(gammas);
jt_max = 15; 
k_max = 5000; %5000;
%w0 = z0-mean(z0);%w_update0(z0,mean(z0),0.5*sqrt(N));
%size(z0)
tStart = tic;
for it = 1:it_max
for jt = 1:jt_max
% starting point
x0 = z0(jt,:); 
tic;
[x,z,w,f_x,k_err] = phase_retrieval_e(x0,gammas(it),e,k_max,a,b,err);
T_toc(it,jt)= toc;
%fprintf('Number of iterations to achieve desired accuracy for function values and feasbility : %d\n',k_err);
%[val_d_z(it), ind_d_z(it)] = min(d_z);
%[valx, ix] = min(f_x);
k_out(it,jt) = k_err;
[valx_z(it,jt), ix_z(it,jt)] = min(f_x); 

end
end
%tMul = sum(T_toc)

%save('results_ePH_N30_d10_kmax_5000.mat','valx_z','ix_z','k_out')
%save('results_ePH_N150_d50_kmax_5000.mat','valx_z','ix_z','k_out')
save('results_ePH_N300_d100_kmax_5000.mat','valx_z','ix_z','k_out')

%save('results_DR_N30_d10_1_kmax_100.mat','valx_z','ix_z','d_x_min','d_z_min','Vx_min','Vz_min','f_x_min')

%save('results_DR_N150_d50_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')
%save('results_DR_N300_d100_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N30_d10_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N150_d50_1_kmax_100.mat','valx_z','ix_z','d_x_min','d_z_min','Vx_min','Vz_min','f_x_min')
% save('results_DR_N150_d50_1_kmax_100.mat','valx_z','ix_z','d_z_min','f_x_min')
%save('results_DR_N300_d100_1_kmax_100.mat','valx_z','ix_z','d_z_min','f_x_min')
% the following results were obtained with :
