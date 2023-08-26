function y = f_phase_retrieval(a,b,x)
N = length(b);
y = 0.0;
for i = 1:N
    y = y + (1.0/N)*abs(dot(a(i,:),x) - b(i));
end
end