  function f=f_os(xyz,P,r,barxs,ws,s)
% simple case: xyz \in R^3
% defines the objective function of the subproblem for scenario s
%linear    f=         feval(P.oF1,xyz(P.ind_x,1),P)   +feval(P.oF2s,xyz(P.ind_y,1),P)
%quadratic %f=0.5*norm(feval(P.oF1,xyz(P.ind_x,1),P))^2+0.5*norm(feval(P.oF2s,xyz(P.ind_y,1),P))

      switch P.family
         case "lin"
      %for s = 1:P.N
         fx = feval(P.oF1,xyz(P.ind_x,1),P,r,barxs,ws);
         fy = feval(P.oF2s,xyz(P.ind_x+1,1),P,s);
	       f= fx + fy;
      %end
         otherwise %"quad" or anything else
         fx = 0.5*(P.F1^2+r)*xyz(1,1)^2 + (ws-r*barxs)*xyz(1,1);
         fy = 0.5*P.F2s(s)^2*xyz(2,1);
      %xaux = (ws-r*barxs)*xyz(P.ind_x,1) + r*xyz(P.ind_x,1)^2
	       f = fx + fy; %norm(fx-xaux)^2 + fx + norm(fy)^2;
	    %f = 0.5*f;
      end
      %f=  f+P.eps*(xyz(P.ind_z(1),1)); %to handle slacks
      f=  f+P.eps*(xyz(3,1)); %to handle slacks
   return
