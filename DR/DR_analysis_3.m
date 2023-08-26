clear all; close all;
x_exp = -1:-1:-6;
n_exp = length(x_exp);

%load('results_DR_N30_d10_1_kmax_100.mat');
load('results_DR_N30_d10_lambda_026_gamma_099.mat')
funval = valx_z(:);
k_opt = k_out(:);
% load('results_DR_N150_d50_1_kmax_100.mat');
load('results_DR_N150_d50_lambda_026_gamma_099.mat')
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];
load('results_DR_N300_d100_lambda_026_gamma_099.mat');
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];

for i=1:n_exp
    frac_DR(i) = round(100*length(find(funval < 10^x_exp(i) ))/length(funval),3);
end

1+1