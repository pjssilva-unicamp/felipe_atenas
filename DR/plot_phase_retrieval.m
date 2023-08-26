clear all; close all;
% methods: DR = 1, ePH = 2, SLP = 3
cant = 50;
porc = 0.5;
x_exp = [linspace(1e-0,1e-3,porc*cant),linspace(1e-3,1e-6,(1-porc)*cant)]; %linspace(1e-3,1e-6,cant);
k_len = 100;
k_stair = linspace(1,500,k_len);

for method = 1:4
if method == 1
%load('results_DR_N30_d10_1_kmax_100.mat');
load('results_DR_N30_d10_kmax_5000.mat')
funval = valx_z(:);
k_opt = k_out(:);
% load('results_DR_N150_d50_1_kmax_100.mat');
load('results_DR_N150_d50_kmax_5000.mat')
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];
load('results_DR_N300_d100_kmax_5000.mat');
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];

for i = 1:cant
    frac_prob_DR(i) = length(find(funval < x_exp(i)))/length(funval);
end
for i = 1:k_len
    frac_prob_DR_k(i) = length(find(k_opt < k_stair(i)))/length(k_opt);
end

elseif method==2
load('results_ePH_N30_d10_kmax_5000.mat')
funval = valx_z(:);
k_opt = k_out(:);
% load('results_DR_N150_d50_1_kmax_100.mat');
load('results_ePH_N150_d50_kmax_5000.mat')
funval = [funval;valx_z(:)];
k_ot = [k_opt;k_out(:)];
load('results_ePH_N300_d100_kmax_5000.mat');
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];

for i = 1:cant
    frac_prob_ePH(i) = length(find(funval < x_exp(i)))/length(funval);
end
for i = 1:k_len
    frac_prob_ePH_k(i) = length(find(k_opt < k_stair(i)))/length(k_opt);
end

elseif method==3
%load('results_SLP_N30_d10_1.mat');
load('results_SLP_N30_d10_kmax_5000.mat')
funval = valx_z(:);
k_opt = k_out(:);
load('results_SLP_N150_d50_1.mat');
funval = [funval;valx_z(:)];
load('results_SLP_N300_d100_1.mat');
funval = [funval;valx_z(:)];
%cant = 50;
%x_exp = [linspace(1e-0,1e-3,0.2*cant),linspace(1e-3,1e-6,0.8*cant)]; %linspace(1e-3,1e-6,cant); %linspace(min(valx_z),max(valx_z),cant);
for i = 1:cant
    frac_prob_SLP(i) = length(find(funval < x_exp(i)))/length(funval);
end
for i = 1:k_len
    frac_prob_SLP_k(i) = length(find(k_opt < k_stair(i)))/length(k_opt);
end

load('results_DR_N30_d10_1_err_1e-6_gamma_lambda.mat');
funval = valx_z(:);
k_opt = k_out(:);
% load('results_DR_N150_d50_1_kmax_100.mat');
load('results_DR_N150_d50_1_err_1e-6_gamma_lambda.mat');
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];
load('results_DR_N300_d100_1_err_1e-6_gamma_lambda.mat');
funval = [funval;valx_z(:)];
k_opt = [k_opt;k_out(:)];

for i = 1:cant
    frac_prob_DR_gen(i) = length(find(funval < x_exp(i)))/length(funval);
end



% elseif method==4
% load('results_SS_N30_d10_1.mat');
% funval = valx_z(:);
% load('results_SS_N150_d50_1.mat');
% funval = [funval;valx_z(:)];
% load('results_SS_N30_d10_1.mat');
% funval = [funval;valx_z(:)];
% %cant = 50;
% %x_exp = [linspace(1e-0,1e-3,0.2*cant),linspace(1e-3,1e-6,0.8*cant)]; %linspace(1e-3,1e-6,cant); %linspace(min(valx_z),max(valx_z),cant);
% for i = 1:cant
%     frac_prob_SS(i) = length(find(funval < x_exp(i)))/length(funval);
% end





end
end
%end
n_lw = 1;
n_ms = 15;
h = figure;
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')

%fun values
stairs(flip(x_exp),100.0*flip(frac_prob_DR_gen),'k.-',MarkerSize=n_ms,LineWidth=n_lw);
set(gca,'XScale','log');
hold on
%stairs(flip(x_exp),100.0*flip(frac_prob_DR),'b.-',MarkerSize=n_ms,LineWidth=n_lw);
%set(gca,'XScale','log');
stairs(flip(x_exp),100.0*flip(frac_prob_ePH),'g.-',MarkerSize=n_ms,LineWidth=n_lw)
set(gca,'XScale','log');
stairs(flip(x_exp),100.0*flip(frac_prob_SLP),'r.-',MarkerSize=n_ms,LineWidth=n_lw);
set(gca,'XScale','log');
% % stairs(flip(x_exp),flip(100.0*frac_prob_SS),'k.-',MarkerSize=n_ms,LineWidth=n_lw)
% % set(gca,'XScale','log');


n_sz = 13;
xlabel({'accuracy of solution functional value'},'Interpreter','latex','FontSize',n_sz)
ylabel({'percentage of problems solved'},'Interpreter','latex','FontSize',n_sz)
grid on;
%title('Percentage of problems that achieve certain accuracy')
%title('$$|f(x^{k}) + d_{\mathcal{N}}^2(z^k)-f^{*}|$$','Interpreter','latex','FontSize',24)
ax = gca;
ax.FontSize = n_sz;
%legend({'PH','SPP','SPL','SS'},'Interpreter','latex','Location','best');   
legend({'DR','e-PD','SPL'},'Interpreter','latex','Location','south');   
set(0,'defaulttextinterpreter','latex')

set(h,'PaperSize',[7 5]); %set the paper size to what you want  
print(h,'comp_overall','-dpdf')