function [variables, c, constraints, exitflag, t, customfunctions] = utilitarian()
% Solves the game for the utilitarian solution -- the action vector which
% maximises a weighted sum of payoffs

global GAME

tic;

% create the weighted sum (note: individual payoffs are already weighted)
weightedsumstring = 'loadpayofffunctions(z, 1)';
for n = 2:length(GAME.payoffs);
    weightedsumstring = strcat(weightedsumstring, ' + loadpayofffunctions(z, ', num2str(n), ')');
end
if ~strcmp(GAME.socialwelfare.raw, '')
    weightedsumstring = strcat(weightedsumstring, [' + (', GAME.socialwelfare.simple, ')']);
end
weightedsumfunction = @(z) -eval(weightedsumstring);

% Creates the lowerbound, upperbound, and start vectors
lowerbound = [];
upperbound = [];
start = [];
if GAME.type(1) == 0; % if static 
    for n = 1:length(GAME.variables)
        for m = 1:length(GAME.variables{n})
            start = [start, [GAME.variables{n}(m).guess]];
            lowerbound = [lowerbound, [GAME.variables{n}(m).lower]];
            upperbound = [upperbound, [GAME.variables{n}(m).upper]];
        end
    end
else % if openloop
    for n = 1:length(GAME.variables)
        for m = 1:length(GAME.variables{n})
            for h = 1:GAME.periods
                start = [start, [GAME.variables{n}(m).guess]];
                lowerbound = [lowerbound, [GAME.variables{n}(m).lower]];
                upperbound = [upperbound, [GAME.variables{n}(m).upper]];
            end
        end
    end
end

% Solves the problem!
options = optimset('Diagnostics','off','Display','off','LargeScale', 'off', 'MaxFunEvals', 300, 'TolCon', GAME.accuracy(4), 'TolFun', ...
    GAME.accuracy(5), 'TolX', GAME.accuracy(6), 'algorithm', 'active-set');
[actionvector, ~, exitflag, ~, lambda] = fmincon(weightedsumfunction,start,[],[],[],[],lowerbound,upperbound,@loadconstraints,options);

% Finds payoffs
for n = 1:GAME.numplayers
    payoffs(n) = loadpayofffunctions(actionvector, n);
end

t = toc;

%% Re-shape some of the output variables so that they're of a more usable form
[variables, c, constraints, exitflag, t, customfunctions] = shapeoutput(actionvector, payoffs, lambda, exitflag, t);