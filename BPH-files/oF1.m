	function f1=oF1(x1,P,r,barxs,ws)
  if nargin == 2;
	f1=P.F1*x1;
  elseif nargin == 5;
  f1=(P.F1+ws-r*barxs)*x1+r*x1^2;
  end
	return
	end
