function f = loadpayofffunctions(z, i)
% loads the payoffs from the global variable GAME to a usable form
% loadpayofffunctions(z,i) = payoff for player i from action vector z

global GAME
f = eval(GAME.payoffs(i).simple);