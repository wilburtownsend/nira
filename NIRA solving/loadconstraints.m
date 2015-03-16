function [c, ceq] = loadconstraints(z, varargin)
% loads the constraints from the global variable GAME to a form usable by
% relax()

global GAME

%% This part does the 'equal or less than' stuff

% If there are constraints...
if ~isempty(GAME.lessconstraints)

    % evaluate those constraints
    for n = 1:length(GAME.lessconstraints);
        c(n) = eval (GAME.lessconstraints(n).simple);
    end

% else set to []
else
   c = [];
end
%% This part does the 'equal to' stuff

% If there are constraints...
if ~isempty(GAME.eqconstraints)

    % evaluate those contraints
    for n = 1:length(GAME.eqconstraints);
        ceq(n) = eval(GAME.eqconstraints(n).simple);
    end

% else set to []
else
   ceq = [];
end