% relax.m
%
%
% Matlab function for the relaxation algorithm
% Started 9-1-96
% Steffan Berridge
% continued by Sue-Anne Lee February 2002
% uses m files :- relax_f(x) 	- payoff function
%		- nik_iso(y,x) 	- nik_iso-Isoda function
% 		- z_const(x) 		- optimum response function
%
% The relaxation algorithm.  This function returns the normalised Nash equilibrium,
% assuming that the conditions set out by Uryas'ev and Rubinstein are met.
%
% Players are assumed to be minimisers.
%
% Global variables:
%		relaxfun = common payoff function
%		constrfun = coupled constraints
%
%
% Inputs:
%		start        =  starting guess for algorithm
%		dims         =  dimensions of players' action spaces
%		lowerbound   =  lower bound of collective action
%		upperbound   =  upper bound of collective action
%		precision    =  termination limits, precision[1] = NI value termination
%                                         , precision[2] = difference termination
%       maxits       =  maximum number of iterations
%		equconst     =  number of constraints which are equalities in constrfun
%		alphamethod  =  method for obtaining alphas: 0<=alphamethod<=1 means alpha = alphamethod
%                                                            2 means optimise alphas using common payoff
%                                                            3 means optimise alphas in next step fashion
%
% Outputs:	p        =  normalised equilibrium
%		    points   =  points traversed (each column is an iteration)
%           cost     =  costs at equilibrium
%	    	costs    =  costs at each point traversed (each column is an iteration)
%           nivals   =  nik_iso-isoda values at each iteration
%		    alphas   =  step sizes
%		    time     =  time taken by algorithm
%


function[p, points, c, costs, nivals, alphas, lambda, time, exitflag] = relax(start, dims, lowerbound, ...
                                 upperbound, precision, maxits, alphamethod, toler)

global relaxfun iteration log;

nplayers = length(dims);


%clc

load2log(['Number of players is ',num2str(nplayers),'.'])
load2log(' ')


% initialise

x = start;

points(1:sum(dims),1) = start';

for i=1:nplayers

        costs(i,1) = eval([relaxfun,'(x,i)']);

end

nivals = [];

alphas = [];



load2log(['The starting point is: ',vect2str(start,dims)])
load2log(' ')


tic


iteration = 0;

contin = 1;

while contin,

	iteration = iteration + 1;

	load2log(['Iteration ',num2str(iteration)])


	lastx = x;

	[z, lambda, exitflag]=z_const(x,dims,lowerbound,upperbound, toler);

	load2log(['z(x) = ',vect2str(z,dims)])


	nivals = [nivals, -nik_iso(z, x, dims)];


options = optimset('Diagnostics','off','Display','off','LargeScale', 'off', 'MaxFunEvals', 300, 'TolCon', toler(1), 'TolFun', toler(2), 'TolX', toler(3), 'algorithm', 'active-set');


	if ((alphamethod>=0) && (alphamethod<=1))

		alpha = alphamethod;

    %elseif alphamethod == 2

    %alpha = fmincon('op_alpha',0.5,[],[],[],[],0,1,[],options,x,z);

	elseif alphamethod == 3
        
        alpha = fmincon(@op_alph3,0.5,[],[],[],[],0,1,@relaxconstr,options,x,z,dims,lowerbound,upperbound,[],[],toler);
    
    else error('alphamethod not in required range');

    end

    if alpha == 0
        load2log('Alpha zero error caused programme to break')
        break
    end

	alphas(length(alphas)+1) = alpha;

	load2log(['alpha = ',num2str(alpha)])



	x = (1-alpha)*x + alpha*z;

	load2log(['x = ',vect2str(x,dims)])


	points(1:sum(dims),size(points,2)+1)=x';

	for i = 1:length(dims)

                costs(i,iteration+1) = eval([relaxfun,'(x,i)']);

	end


	load2log(['NI = ',num2str(-nik_iso(x,lastx,dims))])

	load2log(' ')

    if iteration >= maxits
        load2log('Maximum number of iterations reached. Please change "maxits".')
        break
    end

    contin = any([abs(nik_iso(x,lastx,dims)) > precision(1), abs(x-lastx) > precision(2)]);


end


time=toc;


load2log(' ')


p = x;

c = costs(1:length(dims),size(costs,2))';
