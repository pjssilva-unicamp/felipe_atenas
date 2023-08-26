function [Xbar,Ybar,Wbar,g,ser]=BPHA3(P,Q)
% initialization parameters
  max_it = Q.max_it;tol=Q.tol;
  t=Q.t;tser=t;ser=[];
  N = P.N;

  [XYZ_0,~] = BPHA3_subprob0(N,P);
  Xhalf = XYZ_0(1:N);Ybar=XYZ_0(N+1:2*N);
  W = zeros(N,1);
  % the following 2 lines do not work because BPHA3_subprob0 is defined for
  %    P.F1 that is one dimensional, so it is easier to solve these problems
  %    that define hat y^0 using BPHA3_subprob with r = 0 (t =0).
  %    Same issue in line 35
  %Py=P;Py.F1=P.F1+W;%P.F1 becomes N-dimensional
  %[XYZhat,hval] = BPHA3_subprob0(N,Py);hval=-hval;
  % find hat y^0
  hval = 0.0;
  for s=1:N; %(t,P,ws,barxs,s)
      % t = 0 because we don't have quadratic term in these problems
      % Xbar can be anything, in this case 0.0
      % find initial hat y^0 and its respective function value
      XYZhats = BPHA3_subprob(0.0,P,W(s),0.0,s); %assumes the simple case: xyz \in R^3
      XYhat(s) = XYZhats(1);
      XYhat(s+P.N) = XYZhats(2);
      hval = hval + 0.5*(P.F1^2*XYZhats(1)^2 + P.F2s(s)^2*XYZhats(2)^2) + W(s)*XYZhats(1);
  end
  hval = -hval/P.N;
  for k = 1:max_it;
    %projection
    Xbar = sum(Xhalf)/N;
    % dual update
    u = W + t*(Xhalf - Xbar);
    % pre-descent test (no test at all)
    %Pu = P; Pu.F1 = P.F1 + u;
    %[XYZ, Lu] = BPHA3_subprob0(N,Pu); gives an error as when computing hat y^0

    %%%% r = 0 (t = 0) as in line 22
    Lu = 0.0;
    for s=1:N; %(t,P,ws,barxs,s)
      uYZs = BPHA3_subprob(0.0,P,u(s),0.0,s); %assumes the simple case: xyz \in R^3
      XY(s) = uYZs(1);
      XY(s+P.N) = uYZs(2);
      Lu = Lu + 0.5*(P.F1^2*uYZs(1)^2 + P.F2s(s)^2*uYZs(2)^2) + u(s)*uYZs(1);
    end
    Lu = Lu/P.N;
    if strcmp(P.family, "lin") == 1 %P.family == "lin"
    P_val(k) = sum(P.F1*Xhalf+ P.F2s.*Ybar)/N;
    else %quad
    P_val(k) = sum(P.F1^2*Xhalf.^2+ P.F2s.^2.*Ybar.^2)/N;
    end
    % dual half update
    dX = Xhalf - Xbar;
    Whalf = W + t*dX;

    % stopping test
    Lk = P_val(k) + (1/N)*Whalf'*dX;
    if strcmp(P.family, "lin") == 1 %P.family == "lin"
    Lhat = sum(P.F1*XYhat(1:N)+ P.F2s.*XYhat(N+1:2*N))/N + sum(W.*XYhat(1:N))/N;
  else %quad

    Lhat = sum(P.F1^2*XYhat(1:N).^2)/N+ sum(P.F2s.^2.*(XYhat(N+1:2*N)').^2)/N + sum(W.*XYhat(1:N)')/N;
  end

    g(k) = -(Lhat - Lk);
    % descent test
    if k == 1 ||  (Lhat - Lu) <= -Q.m*g(k); %serious stepsize;
      W = u;
      XYhat = XY;
      t = min(Q.tmax,max(Q.tmin,tser/Q.factor)); tser = t;
      ser(k)=1;
    else;
      t = t*Q.factor; %keep W and XYhat
      ser(k)=0;
    end;
    if g(k) < tol; break;end;

    % define x half with new t and new possible center and multiplier w
    for s=1:N; %(t,P,ws,barxs,s)
      XYZs = BPHA3_subprob(t,P,W(s),Xbar,s); %assumes the simple case: xyz \in R^3
      Xhalf(s) = XYZs(1);
      Ybar(s) = XYZs(2);
      Lu = Lu + 0.5*(P.F1^2*uYZs(1)^2 + P.F2s(s)^2*uYZs(2)^2) + u(s)*uYZs(1);
    end

  end
  fprintf('termination after %d iterations\n', k);
  Xbar = XYhat(1:N)
  mean_x = mean(Xbar)
  %%Ybar = XYhat(N+1:2*N);
  Wbar=W
  mean_w = mean(Wbar)
end
