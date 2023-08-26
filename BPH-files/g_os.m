   function g=g_os(xyz,P,r,barxs,ws,s)
     %xyz is already the vector with s-components (simple case \in R^3)
% defines the gradienr of the objective function of the subproblem for scenario s
%linear    f=         feval(P.oF1,xyz(P.ind_x,1),P)   +feval(P.oF2s,xyz(P.ind_y,1),P)
%quadratic %f=0.5*norm(feval(P.oF1,xyz(P.ind_x,1),P))^2+0.5*norm(feval(P.oF2s,xyz(P.ind_y,1),P))
      g=0*xyz;
      switch P.family
         case "lin"
            g(P.ind_x,1)=P.F1+ws-r*barxs + r*xyz(1);
            g(P.ind_x+1,1)=P.F2s(s)/P.N; %simple case: ys \in R
         otherwise %"quad" or anything else
            g(P.ind_x,1)=ws-r*barxs + (P.F1^2+r)*xyz(P.ind_x,1);
            g(P.ind_x+1,1)=P.F2s(s)^2*xyz(2);
      end
      g(P.ind_x+2,1)=P.eps; %to handle slacks, simple case: zs \in R
   return
