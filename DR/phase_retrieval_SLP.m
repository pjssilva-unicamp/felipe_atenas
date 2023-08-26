function [x,Vx,fopt,k_err] = phase_retrieval_SLP(x,N,gamma,kmax,a,b,x_ref)
% N: number of scenarios
%d = length(a);
err = 1e-6;
k_err = kmax;
for i = 1:N
    r(i) = gamma*(dot(a(i,:),x)^2-b(i));
    g(i,:) = 2.0*gamma*dot(a(i,:),x)*a(i,:);
end

Vx = zeros(1,kmax); 

for k = 1:kmax
    % loop over the number of scenarios
    for i = 1:N
        delta(i,:) = delta_SPL(r(i),g(i,:));
        F(i) = f_SLP(r,g,delta(i,:)); % (overall) fun value at Delta_i
    end
    [fopt(k),inde(k)] = min(F); % pick the i-candidate with lowest overall objective function value
    x = x + delta(inde(k),:); 
    if fopt(k) <= err %&& k_out
        k_err = k;
        %k_out = false;
        %fprintf('Salí de la iteración para k = %d \n',k)
        return;
    end
    for i = 1:N
        r(i) = gamma*(dot(a(i,:),x)^2-b(i));
        g(i,:) = 2.0*gamma*dot(a(i,:),x)*a(i,:);
    end
    Vx(k) = norm(x-x_ref)^2;
end
end