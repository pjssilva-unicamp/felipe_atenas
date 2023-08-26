function [xyzmin,fmin] = BPHA3_subprob0(N,P)
 %resuelve el problema para encontrar el punto inicial
 % este problema es el original sin la restricción de no anticipatividad

% *** update dimensions
P.nx=P.N; P.ind_x=[1:P.nx]; P.ind_y=[P.nx+1:P.nx+P.N];
P.all=P.ind_y(end)+length(P.z_slack);;
P.ind_z=[P.ind_y(end)+1:P.all];

%status = 103;
%it = 1;
%

% *** update data
P.xub(1:P.nx,1)=(ceil(max(abs(P.h_s)))+P.N)*ones(P.nx,1);
P.A_eqxyz(:,1)=[]; %delete first column of 1s and replace with identity (no nonanticip. ct)
P.A_eqxyz = [eye(P.N) P.A_eqxyz];
lb=zeros(P.all,1);ub=Inf+lb;ub(P.ind_x,1)=P.xub;
P.xyz_init=min(ub,max(lb,[mean(P.h_s)*ones(P.nx,1);ones(P.all-P.nx,1)]));

% *** solve
     [xyzmin, fmin, status, iter, nf, lambda] = mysqp (P.xyz_init,
     {@(xyz)f_o (xyz,P), @(xyz)g_o (xyz,P), @(xyz)h_o (xyz,P)},
     {@(xyz)f_ec (xyz,P), @(xyz)g_ec (xyz,P)}, %no Hessian for constraints
     [],% no inequality constraints
     lb,ub,500,1d-6); %OJO had to change MaxIter and TolX for qp to run in Octave

     %numbers=rand(P.all,1);
     %while ((status !=101)&&(it <21))

     %it = it +1;
     %endwhile
     %P.F2s = P.F2s +1; %(1:P.N,1)=1.0d+1*P.F1(1)*(numbers(P.ind_y,1)+.1);
     %P.h_s = P.h_s +1; %(1:P.N,1)=1.d+0*(numbers(P.ind_z(1:P.N),1)+0.5);


     %status
%if status ~= 101, error('error solving LP in BPHA3_subprob0');end
end
