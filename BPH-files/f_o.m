   function f=f_o(xyz,P)
%linear    f=         feval(P.oF1,xyz(P.ind_x,1),P)   +mean((feval(P.oF2s,xyz(P.ind_y,1),P)))
%quadratic %f=0.5*norm(feval(P.oF1,xyz(P.ind_x,1),P))^2+mean(0.5*norm(feval(P.oF2s,xyz(P.ind_y,1),P))
      switch P.family
         case "lin"
	    f =  mean(feval(P.oF1,xyz(P.ind_x,1),P)) + mean(feval(P.oF2s,xyz(P.ind_y,1),P));
         otherwise %"quad" or anything else
      % in this case, nargin == 2, so oF1 is P.F1*x1

	    f =norm(feval(P.oF1,xyz(P.ind_x,1),P))^2 + mean(norm(feval(P.oF2s,xyz(P.ind_y,1),P))^2);
	    f = 0.5*f;
      end
      f=  f+P.eps*sum(xyz(P.ind_z,1)); %to handle slacks
   return
