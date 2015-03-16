% This m file calculates the optimum response function
% z(x)=argmax (nik_iso(x,y))
%      y in X
%
% The region of 


function[z, lambda, exitflag]=z_const(x, dims, lowerbound, upperbound, toler)

global constrfun

y0 = x;			% initial guess is where we are now

options = optimset('Diagnostics','off','Display','off','LargeScale', 'off', 'MaxFunEvals', 500, 'FunValCheck', 'on', 'TolCon', toler(1), 'TolFun', toler(2), 'TolX', toler(3), 'algorithm', 'active-set');

[z, fval, exitflag, output, lambda]=fmincon(@nik_iso, y0, [], [], [], [], lowerbound, upperbound, constrfun, options, x, dims);