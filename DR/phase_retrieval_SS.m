function [x,Vx,fopt] = phase_retrieval_SS(x,gamma,kmax,a,b,x_ref)
% N: number of scenarios
%d = length(a);

Vx = zeros(1,kmax); 

for k = 1:kmax
    % loop over the number of scenarios
    x = x - gamma*subgrad_SS(a,b,x);
    fopt(k) = f_phase_retrieval(a,b,x);
    Vx(k) = norm(x-x_ref);
end
end