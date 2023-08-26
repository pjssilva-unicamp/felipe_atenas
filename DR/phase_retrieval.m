function [z,d_z,w,x,f_x,s,k_err] = phase_retrieval(beta,z0,N,gamma,lambda,kmax,a,b,x_ref,err)
%function [z,d_z,Vz,w,x,f_x,f_xN,d_x,Vx,d_xz,s,Vs,k_err] = phase_retrieval(beta,z0,N,gamma,lambda,kmax,a,b,x_ref,err)

% nonconvex PH from DR
% N: number of scenarios

k_out = true;

k_err = 5000;

for i=1:N
    z(i,:) = z0;
end
s=z;
d_z = zeros(1,kmax); %d_x = zeros(1,kmax); d_xz = zeros(1,kmax); 
f_x = zeros(1,kmax); %f_xN = zeros(1,kmax);

%z = z_update(s,gamma,beta);
w = w_update0(z,mean(z),beta);

for k = 1:kmax
    % loop over the number of scenarios
    for i = 1:N
        % update the center
        %mean_s = mean(s(i,:));
        %z(i,:) = z_update(s(i,:),mean_s,gamma); % in R^d
        % update the multiplier for scenario i
        %w(i,:) = w_update(z(i,:),gamma); %w_update(s(i,:),mean_s,gamma);
        % there are four possible solutions for the i-subproblem
        for j=1:4
            X(j,:) = xOP(j,a(i,:),b(i),gamma,z(i,:),w(i,:));
            F(j) = f_s(a(i,:),b(i),gamma,X(j,:),z(i,:),w(i,:)); 
        end
        % candidate is the one with the lowest i-function value
        [fval(i),ind(i)] = min(F); x(i,:) = X(ind(i),:); %best i-candidate: x_i
        
        %here do not need to take the best out of the N x_i
        % dual update
        s(i,:) = s(i,:) + lambda*(x(i,:)-z(i,:));
    end
    
    z_N = mean(z); %x_N = mean(x); s_N = mean(x);
    %w = w_update(x,x_N,w,lambda);
    for i = 1:N
        d_z(k) = d_z(k) + (1.0/N)*dot(z(i,:)-z_N,z(i,:)-z_N);
        %d_x(k) = d_x(k) + (1.0/N)*dot(x(i,:)-x_N,x(i,:)-x_N);
        f_x(k) = f_x(k) + (1.0/N)*abs(dot(a(i,:),x(i,:))^2-b(i));
        %f_xN(k) = f_xN(k) + (1.0/N)*abs(dot(a(i,:),x_N)^2-b(i));
        %d_xz(k) = d_xz(k) + (1.0/N)*dot(x(i,:)-z(i,:),x(i,:)-z(i,:));
        %Vx(k) = Vx(k) + (1.0/N)*norm(x(i,:)-x_ref)^2;
        %Vz(k) = Vz(k) + (1.0/N)*norm(z(i,:)-x_ref)^2;
        %Vs(k) = Vs(k) + (1.0/N)*norm(s(i,:)-s_N)^2;
    end
    if f_x(k) + 0.5*beta*d_z(k) <= err && k_out
        k_err = k;
        %k_out = false;
        %fprintf('Salí de la iteración para k = %d \n',k)
        return;
    end
    z = z_update(s,gamma,beta);
    w = w_update0(z,z_N,beta);
    %Vx = sqrt(Vx); Vz = sqrt(Vz); 
    %
    %Vs(k) = Vs(k) + (1/N)*norm(mean(s)-x_ref)^2;
    %Vf_x(k) = f_phase_retrieval(a,b,x_N); %f_DR(a,b,gamma,x_N,z_N,w);
end
end