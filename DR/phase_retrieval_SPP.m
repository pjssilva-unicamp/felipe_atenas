function [x,Vx,fopt] = phase_retrieval_SPP(x,N,gamma,kmax,a,x_ref)
% Ns: number of scenarios
%d = length(a);

Vx = zeros(1,kmax); 

% create the right-hand side vector using the reference point, target in R^d
for i=1:N
    b(i) = dot(a(i,:),x_ref)^2; % in R
end

w = zeros(size(x));
for k = 1:kmax
    % loop over the number of scenarios
    for i = 1:N
        % there are four possible solutions for the i-subproblem
        for j=1:4
            X(j,:) = xOP(j,a(i,:),b(i),gamma,x,w);
            F(j) = f_s(a(i,:),b(i),gamma,X(j,:),x,w); %f_SPP(a,b,gamma,X(j,:),x); 
        end
        % candidate is the one with the lowest (overall) function value
        [fval(i),ind(i)] = min(F); x_cand(i,:) = X(ind(i),:); %best i-candidate: x_i
        f_overall(i) = f_SPP(a,b,gamma,x_cand(i,:),x); % evaluate x_i in overall obj fun
    end
    % among the N candidates, we choose the one big the lowest overall fun
    % value
    [fopt(k),inde(k)] = min(f_overall); % pick the i-candidate with lowest overall objective function value
    x = x_cand(inde(k),:); %new iterate and center
    Vx(k) = norm(x-x_ref)^2;
end
end