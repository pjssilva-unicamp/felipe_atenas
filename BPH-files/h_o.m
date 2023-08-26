   function h=h_o(xyz,P)
%linear    f=         feval(P.oF1,xyz(P.ind_x,1),P)   +mean((feval(P.oF2s,xyz(P.ind_y,1),P)))
%quadratic %f=0.5*norm(feval(P.oF1,xyz(P.ind_x,1),P))^2+mean(0.5*norm(feval(P.oF2s,xyz(P.ind_y,1),P))
      switch P.family
         case {"lin"}
            h= zeros(P.all);
         otherwise %"quad" or anything else
            h= zeros(P.all);
            for i=1:length(P.ind_x);h(P.ind_x(i),P.ind_x(i))=P.F1^2/P.N;end
            for i=1:length(P.ind_y);h(P.ind_y(i),P.ind_y(i))=P.F2s(i)^2/P.N;end
      end
      %for i=1:length(P.ind_z);h(P.ind_z(i),P.ind_z(i))= P.eps;end %to handle slacks
   return
