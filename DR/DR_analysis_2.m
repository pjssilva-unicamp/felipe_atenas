clear all; clc; close all;
% input data
% N = 30; % number of scenarios
% d = 10; % dimension

reuse_data = true;
if reuse_data
    load('data_DR_N30_d10_1.mat');
    %load('data_DR_N150_d50_1.mat');
    %load('data_DR_N300_d100_1.mat')
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

%lambdas = linspace(0.05,1.95,20);
lambda_49 = 0.49; %or 0.45
gamma_49 = 0.999*((2-lambda_49)/2);
%esc_gammas = [0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.99];
%lambdas = linspace(0.05,1.95,20); 
%esc_gammas = [0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95];

% it_max = length(lambdas);
[jt_max,~] = size(z02);
k_max = 5000;

tStart = tic;
for jt = 1:jt_max
% starting point
x0 = z02(jt,:);%z0(jt,:);
%gammas(it) = esc_gammas(jt)*lambdas(it);
tic;
[z,d_z,w,x,f_x,s,k_err] = phase_retrieval(beta,x0,N,gamma_49,lambda_49,k_max,a,b,x_ref,err);
T_toc(jt)= toc;
%fprintf('Number of iterations to achieve desired accuracy for function values and feasbility : %d\n',k_err);
%[val_d_z(it), ind_d_z(it)] = min(d_z);
%[valx, ix] = min(f_x);
k_out(jt) = k_err;
[valx_z(jt), ix_z(jt)] = min(f_x+0.5*beta*d_z); 
f_x_min(jt) = f_x(ix_z(jt)); 
%d_x_min(it,jt) = d_x(ix_z(it)); Vx_min(it,jt) = Vx(ix_z(it));
d_z_min(jt) = d_z(ix_z(jt)); %Vz_min(it,jt) = Vz(ix_z(it));
% fprintf('Min value of d_z^2 %d and index %d \n',val,i);
% fprintf('Min value of f %d and index %d \n',valx,ix);
% fprintf('Min value of suma %d and index %d \n',valx_z,ix_z);
end
fprintf('mean number of itetarions is %d',mean(k_out))
%save('results_DR_N30_d10_lambda_049_gamma_0999.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')