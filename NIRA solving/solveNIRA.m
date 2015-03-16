function [variables, c, constraints, exitflag, t, customfunctions] = solveNIRA()
% Solves the game!
%
% Runs the relaxation algorithm and returns an equilibrium point, entering
% important things in the log.
%
% inputs: none
%
% outputs: p        =  normalised Nash equilibrium
%          ps       =  matrix of points traversed (row=action, column=iteration)
%          c        =  costs at normalised equilibrium
%          cs       =  matrix of costs at traversed points (row=action, column=iteration)
%          n        =  values of nikaido-isoda function at each iteration
%          a        =  vector of step-sizes
%          t        =  time taken
%          l        =  constraints (incl. bounds) structure
%          exitflag	=  indicates how the algorithm ended

%% Sets up the variables
global relaxfun constrfun iteration log GAME;

log = {};
warning('off','MATLAB:dispatcher:InexactMatch')

[relaxfun,constrfun,description,gametype,dims,lowerbound,upperbound,...
                                        precision,maxits,start,alphamethod,toler]=loadGAME();

%% Solves the game
load2log(['Log for game ', description]);
    load2log(' ');
                                    
[p, ps, c, cs, n, a, l, t, exitflag] = relax(start, dims, lowerbound, upperbound, precision, maxits, alphamethod, toler);

%% This bit mainly just puts things into the log

% How the algorithm ended
load2log(['For the problem "',description,'", the relaxation algorithm terminated when...'])
load2log(' ')
switch exitflag    
    case 1
        load2log('First order optimality conditions were satisfied to the specified tolerance.')
    case 2
        load2log('Change in x was less than the specified tolerance.')
    case 3
        load2log('Change in the objective function value was less than the specified tolerance.')
    case 4
        load2log('Magnitude of the search direction was less than the specified tolerance and constraint violation was less than TolCon.')
    case 5
        load2log('Magnitude of directional derivative was less than the specified tolerance and constraint violation was less than TolCon.')
    case 0
        load2log('Number of iterations exceeded the maximum iterations or number of function evaluations exceeded options.FunEvals.')
    case -1
        load2log('Algorithm was terminated by the output function.')
    case -2
        load2log('No feasible point was found.')
end

% The main results, if it worked
if exitflag > 0
	if strcmpi(gametype, 'static') == 1
        load2log(' ')
        load2log('The software returned the following results ...') 
        load2log(' ')
        load2log(['The Nash equilibrium point is ',vect2str(p,dims),'.'])
        load2log([' with payoffs ',vect2str(c,dims./dims),'.'])
        load2log(' ')
        load2log('The succession of points taken to get there was: ')
        load2log(' ')
        load2log(vect2str(ps(:)',(dims*length(ps))))
        load2log(' ')
        load2log('The step-sizes (alpha) were: ')
        load2log(a)
        load2log(' ')
    elseif strcmpi(gametype, 'openloop') == 1
        load2log(' ')
        load2log('The software returned the following results ...') 
        load2log(' ')
        load2log(['The Nash equilibrium controls are ',vect2str(p,dims),'.'])
    else
        load2log(' ')
        load2log('Unknown gametype. Please check parameter input file.')
        return
    end
    
    % Logs the constraints
    if isempty(constrfun) == 0
        load2log(' ')
        load2log('The final constraint values were: ')
        load2log(eval([constrfun,'(p, ps, c)']))
        load2log(' ')
        load2log('The final Lagrange vectors were: ')
        load2log('With respect to constraints:')
        load2log(l.ineqnonlin)
    else
        load2log('The final Lagrange vectors were: ')
    end
    load2log('With respect to lower bounds:')
    load2log(l.lower)
    load2log('With respect to upper bounds:')
    load2log(l.upper)

    load2log(' ')
    load2log(' ')
    load2log(['Convergence occurred in ',num2str(t),' seconds and took ',num2str(iteration),' iterations.'])
    load2log(' ')

else
    load2log(' ')
    load2log('Your problem did not converge to a solution and was unable')
    load2log('to be solved by NIRA. Better luck next time.')
end

%% Re-shape some of the output variables so that they're of a more usable form
[variables, c, constraints, exitflag, t, customfunctions] = shapeoutput(p, c, l, exitflag, t);