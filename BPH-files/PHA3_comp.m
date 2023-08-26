Q.varr=false;
N=3;
Q.max_it=50;%500*log(1+N);
Q.tol=1.d-6;Q.r=1.d+4/N;
%P=gGenInstance(N);
P=gPrimalSol(N,"lin");
[Xbar,Ybar,Wbar,g,k]=PHA3(P,Q);
