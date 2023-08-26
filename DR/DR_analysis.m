clear all; close all; clc;

% methods: DR = 1, ePH = 2, SLP = 3

x_exp = -1:-1:-6;
n_exp = length(x_exp);

load('results_DR_N30_d10_1_err_1e-6_gamma_lambda.mat');
funval = valx_z(:);
funval_best = valx_z(:,5);
k_opt = k_out(:);
k_opt_best = k_out(:,5);
load('results_DR_N150_d50_1_err_1e-6_gamma_lambda.mat');
funval = [funval;valx_z(:)];
funval_best = [funval_best;valx_z(:,5)];
k_opt = [k_opt;k_out(:)];
k_opt_best = [k_opt_best;k_out(:,5)];
load('results_DR_N300_d100_1_err_1e-6_gamma_lambda.mat');
funval = [funval;valx_z(:)];
funval_best = [funval_best;valx_z(:,5)];
k_opt = [k_opt;k_out(:)];
k_opt_best = [k_opt_best;k_out(:,5)];

k_opt_sort = sort(k_opt);
k_opt_best_sort = sort(k_opt_best);

%percentage of problems solved in k iterations, for best combination of
%parameters
frac_DR_k_best(1) = round(100*length(find(k_opt_best_sort == 1))/length(k_opt_best),3);
frac_DR_k_best(2) = round(100*length(find(k_opt_best_sort == 5000))/length(k_opt_best),3);
frac_DR_k_best(3) = 100 - sum(frac_DR_k_best);

%overall
frac_DR_k(1) = round(100*length(find(k_opt_sort == 1))/length(k_opt),3);
frac_DR_k(2) = round(100*length(find(k_opt_sort == 5000))/length(k_opt),3);
frac_DR_k(3) = 100 - sum(frac_DR_k);

for i=1:n_exp
    frac_DR(i) = round(100*length(find(funval < 10^x_exp(i) ))/length(funval),3);
end

for i=1:n_exp
    frac_DR_best(i) = round(100*length(find(funval_best < 10^x_exp(i) ))/length(funval_best),3);
end


