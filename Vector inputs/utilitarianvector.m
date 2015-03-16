function output = utilitarianvector(inputs)
% This solves for the welfare-maximising solution where some constants are vectors. Designed to be used
% with cellfunc, the inputs are a vector of doubles which subsitute into
% GAME.constants

global GAME

vectorconstants = GAME.constants; % this saves the old version of GAME.constants,
% allowing us to revert to it later, after we've subsituted in the
% temporary scalar constants and used them

arrays = checkarray({GAME.constants.value}); % figuring out which constants have vectors
for n = 1:length(arrays); % turning those vectors into the corresponding scalars
    GAME.constants((arrays(n))).value = inputs(n);
end

simplifystruct(); % simplify
[variables, c, l, exitflag, t, customfunctions] = utilitarian(); % solve!

% create the output
output.vectorinput = inputs;
output.playervariables = variables;
output.payoffs = c;
output.constraints = l;
output.exitflag = exitflag;
output.customfunctions = customfunctions;
output.time = t;

GAME.constants = vectorconstants; % reverting to the old version