function g = subgrad_SS(a,b,x)
[N,d] = size(a);
g = zeros(1,d);
for i = 1:N
    val = dot(a(i,:),x)^2-b(i);
    if ~(val==0)
        g_i = sign(val);
    else
        g_i = -1.0 + 2.0*rand(1);
    end
    g = g + (2.0/N)*dot(a(i,:),x)*a(i,:)*g_i;
end
end