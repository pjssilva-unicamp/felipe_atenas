   function g=g_o(xyz,P)
%linear    f=         feval(P.oF1,xyz(P.ind_x,1),P)   +mean((feval(P.oF2s,xyz(P.ind_y,1),P)))
%quadratic %f=0.5*norm(feval(P.oF1,xyz(P.ind_x,1),P))^2+mean(0.5*norm(feval(P.oF2s,xyz(P.ind_y,1),P))
      g=0*xyz;
      switch P.family
         case "lin"
            g(P.ind_x,1)=P.F1*ones(P.nx,1)/P.N;
            g(P.ind_y,1)=P.F2s/P.N;
         otherwise %"quad" or anything else
            g(P.ind_x,1)=P.F1*feval(P.oF1,xyz(P.ind_x,1),P)/P.N;
            g(P.ind_y,1)=P.F2s/P.N.*feval(P.oF2s,xyz(P.ind_y,1),P);
      end
      g(P.ind_z,1)=P.eps; %to handle slacks
   return
