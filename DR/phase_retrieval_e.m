function [x,z,w,f_x,k_err] = phase_retrieval_e(z0,r0,e,kmax,a,b,erro)
[N,d] = size(a);
% nonconvex PH from elicited progressive decoupling 
k_err = 5000;
w = zeros(N,d);
for i=1:N
    
    z(i,:) = z0;%*ones(1,d);
    %w(i,:) = zeros(1,d);%z0 - mean(z0);%*ones(1,d);;
end

f_x = zeros(1,kmax); %f_xN = zeros(1,kmax);

r_inv = 1.0/r0;
for k = 1:kmax
    % loop over the number of scenarios
    for i = 1:N
        % there are four possible solutions for the i-subproblem
        for j=1:4
            X(j,:) = xOP(j,a(i,:),b(i),r_inv,z(i,:),w(i,:));
            F(j) = f_s(a(i,:),b(i),r_inv,X(j,:),z(i,:),w(i,:)); 
        end
        % candidate is the one with the lowest i-function value
        [fval(i),ind(i)] = min(F); x(i,:) = X(ind(i),:); %best i-candidate: x_i
        
        %here do not need to take the best out of the N x_i
        % primal projection
    end
    
    for i = 1:N
        f_x(k) = f_x(k) + (1.0/N)*abs(dot(a(i,:),x(i,:))^2-b(i));
        z(i,:) = mean(x);
    end
    if f_x(k) <= erro
        k_err = k;
        return;
    end
     %z_update(s,gamma,beta);
    w = w_update_e(x,z,w,r0,e);
end
end