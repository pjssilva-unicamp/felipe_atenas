	function f2=oF2s(y,P,s)
  if nargin == 2;
	f2=P.F2s.*y; %a vector
  elseif nargin == 3; %subproblems, simple case: y is escalar
  f2=P.F2s(s)*y;
  end
  return
	end
