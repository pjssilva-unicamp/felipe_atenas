function [p,th_max] = PerfProfCS(A,name,th_max,ColorSet)
%PERFPROF  Performance profile.
%          TH_MAX = PERFPROF(A,TH_MAX) produces a
%          performance profile for the data in the M-by-N matrix A,
%          where A(i,j) > 0 measures the performance of the j'th solver
%          on the i'th problem, with smaller values of A(i,j) denoting
%          "better".  For each solver theta is plotted against the
%          probability that the solver is within a factor theta of
%          the best solver over all problems, for theta on the interval
%          [1, TH_MAX].
%          Set A(i,j) = NaN if solver j failed to solve problem i.
%          TH_MAX defaults to the smallest value of theta for which
%          all probabilities are 1 (modulo any NaN entries of A).



minA = min(A,[],2);
if nargin < 3||isempty(th_max), th_max = max( max(A,[],2)./minA ); end
tol = eps;sqrt(eps);  % Tolerance.
[m,n] = size(A);  % m problems, n solvers.
if m*n>1500;lin=1;else lin=2;end
if nargin <2
    name = cell(n,1);
    for i=1:n
        name(i) = {strcat(' ',num2str(i))};
    end
end
if(nargin~=4)
    title = '';
end

max_ratio=0;xx=[];yy=[];
ref=-eps;
c=0;leg=cell(1,1);
for j = 1:n                  % Loop over solvers.

    col = A(:,j)./minA;      % Performance ratios.
    col = col(~isnan(col));  % Remove NaNs.
    col = col(~isinf(col));  % Remove NaNs.
    max_ratio=min(th_max,max([max_ratio,max(max(col))]));
    if ~isempty(col)&&length(col)>1,
        theta = unique(col)';    % Unique elements, in increasing order.
        r = length(theta);
        if sum(isinf(theta));keyboard;end
        prob = sum( col(:,ones(r,1)) <= theta(ones(length(col),1),:) ) / m;
        % Assemble data points for stairstep plot.
        k = [1:r; 1:r]; k = k(:)';
        x = theta(k(2:end)); y = prob(k(1:end-1));
        %         Ensure endpoints plotted correctly.
        if x(1) > ref + tol, x = [0 x]; y = [0 y]; end
        if x(end) < th_max - tol, x = [x th_max]; y = [y y(end)]; end
        p(j,1)=y(1);
        xx=x; yy=y;
        nx(j)=size(xx,2);
    end
    alx{j}=xx; aly{j}=yy; %not the same length j=1 and j=2
end
[nn,jj]=max(nx);
for j=1:n;if j~=jj&&nx(j)<nn;alx{j}(nx(j)+1:nn)=alx{j}(nx(j));end;end
for j=1:n;if j~=jj&&nx(j)<nn;aly{j}(nx(j)+1:nn)=aly{j}(nx(j));end;end
for j=1:n;xplot(j,:)=alx{j}(:);yplot(j,:)=aly{j}(:);end;
for j=1:n;if nx(j)<nn;aly{j}(nx(j)+1:nn)=aly{j}(nx(j));end;end;
xplot=cell2mat(alx')';
yplot=cell2mat(aly')';
plotb(xplot,yplot,ColorSet,lin);

%%not for octave: legend(name,'Location','Best');

axis([ 0 1.01*th_max 0 1.05 ]);
%axis([ 0 1.01*min(th_max,max_ratio) 0 1.05 ]);
xlabel('\theta');%,'fontsize',13)
ylabel('\phi(\theta)');%,'fontsize',13)
%set(gca,'fontsize',13)
%title(title);%,'fontsize',16)
grid on;%AX.XMinorGrid = 'on';
return

function plotb(x,y,Cc,lin)
GraphSpecs={'-','-','--',':','--',':','--',':','--',':'};
MarkSpecs={'x','o','.','+','.','.','x','.','*','.'};
for c=1:size(x,2);
    if c<=3;mylin=4;else mylin=lin;end
    h=plot(x(:,c),y(:,c),strcat(GraphSpecs{c},MarkSpecs{c}),'linewidth',mylin,'MarkerSize',4);
    hold on
    set(h,'color',Cc(:,c));
end
return
