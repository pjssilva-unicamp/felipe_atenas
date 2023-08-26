function w = w_update_e(x,z,w,r,e)
[N,~]=size(z);
% x is N x d
% z is N x d, N copies of same vector in R^d
for i =1:N
    w(i,:)=w(i,:)+(r-e)*(x(i,:)-z(i,:));
end
end