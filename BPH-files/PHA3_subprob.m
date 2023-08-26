function xyzmin = PHA3_subprob(t,P,ws,barxs,s)
  % F1, F2, xi_s, bxs: 1 dim
  % XY_init: 2 dim
P.all = 3; P.nx = 1;%simple case: xs, ys, zs \in R
P.ind_x = 1:P.nx; P.ind_y=[2:2]; P.ind_z=[3:P.all];
     lb=zeros(P.all,1);ub=Inf+lb;ub(P.ind_x,1)=P.xub;
     P.xyz_init=min(ub,max(lb,[P.h_s(s)*ones(P.nx,1);ones(P.all-P.nx,1)]));
     [xyzmin, fmin, status, iter, nf, lambda] = mysqp (P.xyz_init,
     {@(xyz)f_os (xyz,P,t,barxs,ws,s), @(xyz)g_os (xyz,P,t,barxs,ws,s), @(xyz)h_os (xyz,P,t,s)},
     {@(xyz)f_ecs (xyz,P,s), @(xyz)g_ecs (xyz,P,s)}, %no Hessian for constraints
     [],% no inequality constraints
     lb,ub,500,1d-6);
%if info.info == 6, error('error solving PHA2_subprob');end
end
