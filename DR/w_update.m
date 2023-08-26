function w = w_update(x,x_N,w,lambda)
% run outside loop for i
[N,~]=size(x);
for i=1:N
    w(i,:) = (1-lamda)*w(i,:) + lambda*(x(i,:) - x_N);
end

end