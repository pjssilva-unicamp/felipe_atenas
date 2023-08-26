function z = z_update(s,gamma,beta)
% s \in R^{N x d}
% mean_s \in \R^d 
mean_s = mean(s); % \in \R^d
[N,~]=size(s);
tau = gamma*beta;
for i = 1:N
    z(i,:) = (s(i,:) + tau*mean_s)/(1+tau);%(1/(1+tau))*s(i,:) + (tau/(1+tau))*mean_s;
end
end