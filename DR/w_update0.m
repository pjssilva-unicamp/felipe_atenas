function w = w_update0(z,mean_z,beta)
[N,~]=size(z);
%mean_z = mean(z); 
for i =1:N
    w(i,:)=beta*(z(i,:)-mean_z);
end
end