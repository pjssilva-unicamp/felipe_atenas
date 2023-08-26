function P=gGenInstance(P)
%CS, 22/08/22
% generates instances of 2-stage problems of the form
% min oF1(x)+E(oF2s(y_s))
% s.t. x,y_s geq 0
%      x leq P.xub
%      P.Tmat x + P.Wmat y_s geq P.h_s\in R for s=1:N, the number of scenarios
% convex first-stage objective, gradient and Hessian: oF1,gF1,hF1
% convex second-stage objective, gradient and Hessian: oF2s,gF2s,hF2s
% family in {"lin","quad"} generates linear or quadatic objective functions

    %INPUT: 2-stage LP data
    %       with randomness in right hand side and 2nd stage costs

       %P.seed=rand("state");

       P.nx=1; P.ind_x=[1:P.nx]; P.ind_y=[P.nx+1:P.nx+P.N];
%  in the implementation we add slacks to ensure relatively complete recourse (feasibility)
       P.z_slack=zeros(P.N,1); P.all=P.ind_y(end)+length(P.z_slack);;
       P.ind_z=[P.ind_y(end)+1:P.all];P.eps=1d0*sqrt(eps);
%  linear costs
       P.F1(P.ind_x,1)=8.0d0*P.N*ones(P.nx,1);
       numbers=rand(P.all,1);
       P.F2s(1:P.N,1)=1.0d+1*P.F1(1)*(numbers(P.ind_y,1)+.1);
%  affine constraints
       P.h_s(1:P.N,1)=1.d+0*(numbers(P.ind_z(1:P.N),1)+0.5);
       P.Tmat=eye(P.nx);P.Wmat=ones(P.nx,1);
       BigW=[];for i=1:P.N;BigW=blkdiag(BigW,P.Wmat);end;
%2 slacks       P.A_eqxyz=[repmat(P.Tmat,[P.N,1]) BigW eye(P.N) -eye(P.N)];
       P.A_eqxyz=[repmat(P.Tmat,[P.N,1]) BigW -eye(P.N)];
%  bounds
       P.xub(1:P.nx,1)=(ceil(max(abs(P.h_s)))+P.N)*ones(P.nx,1);
%  function file names
       P.oF1='oF1';P.oF2s='oF2s';P.gF1='gF1';P.gF2s='gF2s';P.hF1='hF1';P.hF2s='hF2s';
       P.oec='oec';P.gec='gec';P.hec='hec';
return
end
