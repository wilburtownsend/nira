
function[relaxfun, constrfun, description, gametype,dims, lowerbound, upperbound,...
		precision, maxits, start, alphamethod, toler] = loadGAME()


global GAME;

% Load the payoff and constraint functions -- note that the actual loading
% from GAME takes place within loadpayofffunctions() and loadconstraints(),
% this approach is due to the evolution of this game.
relaxfun = 'loadpayofffunctions';
constrfun = 'loadconstraints';

% Load the description
description = GAME.name;

if GAME.type(1) == 0;
% If the game is static...

    % say that it's static,
    gametype = 'static';

    % create the lowerbound, upperbound, and start vectors, and the dims
    % vector which notes the number of dynamic variables each player has.
    lowerbound = [];
    upperbound = [];
    start = [];
    dims = [];
    for n = 1:length(GAME.variables)
        dims = [dims, length(GAME.variables{n})];
        for m = 1:length(GAME.variables{n})
            start = [start, [GAME.variables{n}(m).guess]];
            lowerbound = [lowerbound, [GAME.variables{n}(m).lower]];
            upperbound = [upperbound, [GAME.variables{n}(m).upper]];
        end
    end    
    
else
% If the game is openloop...

    % say that it's openloop,
    gametype = 'openloop';

    % create the lowerbound, upperbound, and start vectors (which all have
    % repeats for the number of duplicated variables), and the dims vector
    % which notes the number of dynamic variables each player has
    % (multiplied by the number of periods).
    lowerbound = [];
    upperbound = [];
    start = [];
    dims = [];
    for n = 1:length(GAME.variables)
        dims = [dims, (length(GAME.variables{n}) * GAME.periods)];
        for m = 1:length(GAME.variables{n})
            for q = 1:GAME.periods
                start = [start, [GAME.variables{n}(m).guess]];
                lowerbound = [lowerbound, [GAME.variables{n}(m).lower]];
                upperbound = [upperbound, [GAME.variables{n}(m).upper]];
            end
        end
    end  
    
end

% Load the accuracy variables
precision = [GAME.accuracy(2), GAME.accuracy(3)];
maxits = GAME.accuracy(7);
alphamethod = GAME.accuracy(1);
TolCon = GAME.accuracy(4);
TolFun = GAME.accuracy(5);
TolX = GAME.accuracy(6);
toler = [TolCon, TolFun, TolX];