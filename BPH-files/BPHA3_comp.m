clear all; clc;
families= {"lin";"quad"};
%for fam=1:length(families)
%   repeat=false;
for N=4:4;
   family="quad"; %families{fam};
   %fprintf('gPrimalSol \n');
   P=gPrimalSol(N,family);
   %Q.varr=true;
   Q.max_it=ceil(500*log(1+N));
   Q.tol=1.d-5;Q.t=1.d+5/N;
   Q.factor = 0.9;
   Q.tmin = 1.d-3;
   Q.tmax = 1.d3;
   Q.m = 0.5;
   %%%% test BPHA3_subprob0
   %fprintf('subprob0 \n');
   %[XYZ_0,fmin_aux] = BPHA3_subprob0(N,P);
   %%%% test BPHA3_subprob
   %s=1;
   %t = 0.5/s;
   %Xbar = s*0.1;
   %W = zeros(N,1)+0.1*s;
   %XYZs = BPHA3_subprob(t,P,W(s),Xbar,s);
   %%%%
   [Xbar,Ybar,Wbar,g,ser]=BPHA3(P,Q);
   %[Xbar,Ybar,Zbar,Wbar,g,k]=PHA3(P,Q);
   fprintf('family=%s, N=%i,Xbar-P.primalx=%d, maxit=%i\n',family,N,Xbar-P.primalx,Q.max_it)
  %end
end
