   function h=h_os(xyz,P,r,s)
%linear    f=         feval(P.oF1,xyz(P.ind_x,1),P)   +mean((feval(P.oF2s,xyz(P.ind_y,1),P)))
%quadratic %f=0.5*norm(feval(P.oF1,xyz(P.ind_x,1),P))^2+mean(0.5*norm(feval(P.oF2s,xyz(P.ind_y,1),P))
      switch P.family
         case {"lin"}
            h= zeros(3); %simple case: xs, ys, zs \in R
         otherwise %"quad" or anything else
            h= zeros(3); %simple case: xs, ys, zs \in R
            h(1,1)=P.F1^2+r; h(2,2) = P.F2s(s)^2;
            %for i=1:length(P.ind_x);h(P.ind_x(i),P.ind_x(i))=P.F1(i)^2;end
            %for i=1:length(P.ind_y);h(P.ind_y(i),P.ind_y(i))=P.F2s(i)^2/P.N;end
      end
      %for i=1:length(P.ind_z);h(P.ind_z(i),P.ind_z(i))= P.eps;end %to handle slacks
   return
