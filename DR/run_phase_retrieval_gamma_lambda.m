clear all; clc; close all;

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

% lambda = 0.1;%1.7; %0.3; 
% gamma = 0.99*((2-lambda)/2); %max([(2-lambda)/(2-1e-10),0.01]); %0.05;

% kmax = 5000;
err = 1e-6;
beta = 0.5*sqrt(N);%1.0/(2*N);

lambdas = linspace(0.05,1.95,21);
%gammas = 0.99*((2-lambdas)/2);

it_max = length(lambdas);
jt_max = 15; %length(esc_gammas); %15;
k_max = 5000;
n_gamma = 5;
tStart = tic;
x0 = z0(1,:);

T_toc = zeros(it_max,n_gamma); k_out = zeros(it_max,n_gamma);
valx_z = ones(it_max,n_gamma); ix_z = zeros(it_max,n_gamma);
d_z_min = zeros(it_max,n_gamma);

for it = 1:it_max
gammas = linspace(0.01,0.99*((2-lambdas(it))/2),n_gamma);
for jt = 1:n_gamma
tic;
[z,d_z,w,x,f_x,s,k_err] = phase_retrieval(beta,x0,N,gammas(jt),lambdas(it),k_max,a,b,x_ref,err);
T_toc(it,jt)= toc;
k_out(it,jt) = k_err;
[valx_z(it,jt), ix_z(it,jt)] = min(f_x+0.5*beta*d_z); 
%f_x_min(it,jt) = f_x(ix_z(it)); 

d_z_min(it,jt) = d_z(ix_z(it,jt)); %Vz_min(it,jt) = Vz(ix_z(it));

end
end

%varying gamma and lambda
%save('results_DR_N30_d10_1_err_1e-6_gamma_lambda.mat','valx_z','ix_z','d_z_min','T_toc','k_out')
%save('results_DR_N150_d50_1_err_1e-6_gamma_lambda.mat','valx_z','ix_z','d_z_min','T_toc','k_out')
save('results_DR_N300_d100_1_err_1e-6_gamma_lambda.mat','valx_z','ix_z','d_z_min','T_toc','k_out')


%save('results_DR_N150_d50_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')
%save('results_DR_N300_d100_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')