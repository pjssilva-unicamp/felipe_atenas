clear all; clc; close all;
% input data
% N = 30; % number of scenarios
% d = 10; % dimension

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

%lambdas = linspace(0.05,1.95,20);
lambdas = 0.49;%;[0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45];
gammas = linspace(1e-4,1,100);
gammas = gammas(1:75); %linspace(1e-4,0.999*((2-lambdas)/2),100);%0.999*((2-lambdas)/2);
%esc_gammas = [0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.99];
%lambdas = linspace(0.05,1.95,20); 
%esc_gammas = [0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95];

it_max = length(lambdas);
jt_max = 15; %length(esc_gammas); %15;
k_max = 5000;

lambda = 0.26;
gamma = 0.99*((2-lambda)/2); %linspace(1e-4,0.99*((2-lambda(it))/2),5);

tStart = tic;
for it = 1:1 %it_max

for jt = 1:jt_max
% starting point
x0 = z0(jt,:);%z0(jt,:);
%gammas(it) = esc_gammas(jt)*lambdas(it);
tic;
%[z,d_z,w,x,f_x,s,k_err] = phase_retrieval(beta,x0,N,gammas(it),lambdas,k_max,a,b,x_ref,err);
[z,d_z,w,x,f_x,s,k_err] = phase_retrieval(beta,x0,N,gamma,lambda,k_max,a,b,x_ref,err);
T_toc(it,jt)= toc;
%fprintf('Number of iterations to achieve desired accuracy for function values and feasbility : %d\n',k_err);
%[val_d_z(it), ind_d_z(it)] = min(d_z);
%[valx, ix] = min(f_x);
k_out(it,jt) = k_err;
[valx_z(it,jt), ix_z(it,jt)] = min(f_x+0.5*beta*d_z); 
f_x_min(it,jt) = f_x(ix_z(it,jt)); 
%d_x_min(it,jt) = d_x(ix_z(it)); Vx_min(it,jt) = Vx(ix_z(it));
d_z_min(it,jt) = d_z(ix_z(it,jt)); %Vz_min(it,jt) = Vz(ix_z(it));
% fprintf('Min value of d_z^2 %d and index %d \n',val,i);
% fprintf('Min value of f %d and index %d \n',valx,ix);
% fprintf('Min value of suma %d and index %d \n',valx_z,ix_z);
fprintf('(it gamma, it init point) = (%d,%d)\n', it, jt)
end
end
%tMul = sum(T)

%save('results_DR_N30_d10_lambda_026_gamma_099.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')
%save('results_DR_N150_d50_lambda_026_gamma_099.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')
save('results_DR_N300_d100_lambda_026_gamma_099.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N30_d10_lambda_049_gamma_75_values.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N30_d10_lambda_049_gamma_75_values.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N30_d10_1_kmax_100.mat','valx_z','ix_z','d_x_min','d_z_min','Vx_min','Vz_min','f_x_min')

% save('results_DR_N30_d10_lambda_195_gamma_099.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N150_d50_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N150_d50_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')
%save('results_DR_N300_d100_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N30_d10_kmax_5000.mat','valx_z','ix_z','f_x_min','d_z_min','k_out')

%save('results_DR_N150_d50_1_kmax_100.mat','valx_z','ix_z','d_x_min','d_z_min','Vx_min','Vz_min','f_x_min')
% save('results_DR_N150_d50_1_kmax_100.mat','valx_z','ix_z','d_z_min','f_x_min')
%save('results_DR_N300_d100_1_kmax_100.mat','valx_z','ix_z','d_z_min','f_x_min')
% the following results were obtained with :
% lambdas = linspace(0.05,1.95,20); esc_gammas = [0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.99];
% save('results_DR_N30_d10_2_kmax_100.mat','valx_z','ix_z','d_z_min','f_x_min','lambdas','esc_gammas')

%save('results_DR_N30_d10_3_kmax_100.mat','valx_z','ix_z','d_z_min','f_x_min','lambdas','esc_gammas')





% figure;
% plot(log(Vx(1:ix_z(end)))/log(10),'b--',LineWidth=2)
% %title('$$|x^{k}-P_N[x^k]|^2$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% grid on;
% legend({'$h(x)$','$H^{'+string(barx)+'}(x)$', '$H^{'+string(barx)+'}(x)-\varepsilon$'},'Interpreter','latex','FontSize',24,'Location','best');                 
% figure;
% plot(1:kmax,d_x(1:kmax),'b--',LineWidth=2)
% title('$$|x^{k}-P_N[x^k]|^2$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% 
% figure;
% plot(1:kmax,0.5*d_z,'b--',LineWidth=2)
% title('$$|z^{k}-P_N[z^k]|^2$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% 
% figure;
% plot(1:kmax,Vs,'b--',LineWidth=2)
% title('$$|s^{k}-P_N[s^k]|$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% 
% figure;
% plot(1:kmax,d_xz,'b--',LineWidth=2)
% title('$$|x^k - z^k|$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% 
% 
% figure;
% plot(1:kmax,f_x,'b--',LineWidth=2)
% title('$$|f(x^{k})-f^{*}|$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% 
% figure;
% plot(1:kmax,f_x+d_z,'b--',LineWidth=2)
% title('$$|f(x^{k}) + d_{\mathcal{N}}^2(z^k)-f^{*}|$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
