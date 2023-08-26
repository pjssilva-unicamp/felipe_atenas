	function f=f_ecs(xyz,P,s)
    %simple case: xyz \in R^3
	f=[P.A_eqxyz(s,1) P.A_eqxyz(s,s+1) P.A_eqxyz(s,s+1+P.N)]*xyz -P.h_s(s);
	return
	end
