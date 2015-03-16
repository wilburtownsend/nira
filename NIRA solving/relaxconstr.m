% Function to constrain the value of optimised alpha in such a way that 
% the relaxation algorithm never generates a value outside the constraints


function [c, ceq] = relaxconstr(alpha, varargin)

global constrfun

cf = str2func(constrfun);

x = varargin(1);
z = varargin(2);

r = (1 - alpha) * x{1,1} + alpha * z{1,1};

c = cf(r);

ceq = [];
