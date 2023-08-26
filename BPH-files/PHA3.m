function [Xbar,Ybar,Wbar,g,k]=PHA3(P,Q)
N = P.N;
% initialization parameters
  max_it = Q.max_it;tol=Q.tol;
  if ~Q.varr;r=Q.r;end %r is fixed along iterations

  XYZ = PHA3_subprob0(N,P);
  X = XYZ(1:N); Ybar=XYZ(N+1:2*N);
  W = zeros(N,1);
  for k = 1:max_it;
    if Q.varr;r=Q.r/log(k*k+1);end %r varies along iterations
    %projection
    Xbar = sum(X)/N;
    %%%%% teste parada %%%%%
    g(k) = sqrt(norm(X-Xbar))/N;
    fprintf('g(k)= %d in iteration %i \n',g(k),k);
    %dual update
    W += r*(X - Xbar);

    if g(k) < tol; break;end;

    % solve subproblems
    for s=1:N;
      XYZs = PHA3_subprob(r,P,W(s),Xbar,s);
      X(s) = XYZs(1);
      Ybar(s) = XYZs(2);
    end

  end
  fprintf('termination after %d iterations\n', k);
  Xbar = sum(X)/N;
  Wbar=W;
end
