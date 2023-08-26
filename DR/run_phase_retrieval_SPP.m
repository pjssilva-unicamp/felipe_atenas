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
    [a,b,x_ref,gamma,kmax] = gen_data(N,d);
end

%lambdas = linspace(0.05,1.95,100);
gammas = linspace(1e-4,1,100);%0.99*((2-lambdas)/2);
it_max = length(gammas);
jt_max = 15;
%x_SPP = zeros(it_max,d); 
kmax=100;
%x0 = z0;%rand_pick_sphere(1,d);%randn(1,d);%z0*ones(1,d);%randn(1,d);
for it = 1:it_max
for jt = 1:jt_max
% starting point
x0 = z0(jt,:);%rand_pick_sphere(1,d); 

[x,Vx,fopt] = phase_retrieval_SPP(x0,N,gammas(it),kmax,a,x_ref);%phase_retrieval_SPP(x0,N,gammas(it),kmax,a,x_ref);
[valx_z(it,jt), ix_z(it,jt)] = min(fopt);
Vx_min(it,jt) = Vx(ix_z(it,jt));
end
end
%save('results_SPP_N30_d10_1.mat','valx_z','ix_z','Vx_min')
%save('results_SPP_N150_d30_1.mat','valx_z','ix_z','Vx_min')
save('results_SPP_N300_d100_1.mat','valx_z','ix_z','Vx_min')

% figure;
% plot(1:kmax,Vx,'b--',LineWidth=2)
% title('$$|x^{k}-x^{*}|$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;
% 
% figure;
% plot(1:kmax,abs(fopt),'b--',LineWidth=2)
% title('$$|f^{k}-f^{*}|$$','Interpreter','latex','FontSize',24)
% xlabel('iteraciones')
% ax = gca;
% ax.FontSize = 16;