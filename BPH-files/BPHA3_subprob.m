function xyzmin = BPHA3_subprob(t,P,ws,barxs,s)
  % F1, F2, xi_s, bxs: 1 dim
  % XY_init: 2 dim
%q = [F1+ws-r*bxs;F2];
%H = r*[1 0;0 0]+diag([0 eps/r]);
%lb = [0;0];%%OJO IT WAS [0;-Inf]!!
%ub = [M;Inf];
%A_lb =xi_s;%%OJO IT WAS -Inf!!
%A_in = [1 1];
%[xsol, obj, info, lambda] = qp (XY_init, H, q, [], [], lb, ub, A_lb, A_in,[]);
%if info.info == 6, error('error solving PHA2_subprob');end

     P.all = 3; P.nx = 1;%simple case: xs, ys, zs \in R
     lb=zeros(P.all,1);ub=Inf+lb;ub(P.ind_x,1)=P.xub;
     P.xyz_init=min(ub,max(lb,[P.h_s(s)*ones(P.nx,1);ones(P.all-P.nx,1)]));
     [xyzmin, fmin, status, iter, nf, lambda] = mysqp (P.xyz_init,
     {@(xyz)f_os (xyz,P,t,barxs,ws,s), @(xyz)g_os (xyz,P,t,barxs,ws,s), @(xyz)h_os (xyz,P,t,s)},
     {@(xyz)f_ecs (xyz,P,s), @(xyz)g_ecs (xyz,P,s)}, %no Hessian for constraints
     [],% no inequality constraints
     lb,ub,500,1d-6); %OJO had to change MaxIter and TolX for qp to run in Octave
     %if status !=101
end
