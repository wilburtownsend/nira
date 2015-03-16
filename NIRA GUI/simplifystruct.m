function simplifystruct()
% simplifies GAME into a form that can be solved numerically

global GAME;

%% Prepare the variables cell array for later substitution
        
% create that variables thing
track = 1;
variables = {};
if GAME.type(1) == 0;
% If the game is static...
    for n = 1:length(GAME.variables)
        for m = 1:length(GAME.variables{n})
            variables{track} = GAME.variables{n}(m).varsym;
            track = track + 1;
        end
    end    
else
% If the game is openloop...
    for n = 1:length(GAME.variables)
        for m = 1:length(GAME.variables{n})
            for q = 1:GAME.periods
                variables{track} = strcat(GAME.variables{n}(m).varsym, '_', num2str(q));
                track = track + 1;
            end
        end
    end  
end

%% Simplify and prepare the custom functions

% create the custom functions cell array
customfunctions = {};

% if non-empty...
if ~isempty(GAME.customfunctions)
    for n = 1: length(GAME.customfunctions);
            customfunctions{n,1} = GAME.customfunctions(n).reference;
            customfunctions{n,2} = GAME.customfunctions(n).code;
            customfunctions{n,3} = char(evalinternal(sym(GAME.customfunctions(n).code)));
            % substitute previously-declared custom functions
            if size(customfunctions,1) > 1;
                for m = 1: (size(customfunctions,1) - 1);
                    oldchar = customfunctions{n,3};
                    referencechar = customfunctions{m,1};
                    codechar = customfunctions{m,3};
                    customfunctions{n,3} = char(subs(sym(oldchar), sym(referencechar), sym(codechar)));
                end
            end
            customfunctions{n,3} = char(evalinternal(sym(customfunctions{n,3})));
    end
end

%% Simplify the constraints

if GAME.type(1) == 1; periods = GAME.periods; else periods = 0; end

GAME.lessconstraints = constraintsimplify(GAME.lessconstraints, variables, GAME.constants, customfunctions, periods);
GAME.eqconstraints = constraintsimplify(GAME.eqconstraints, variables, GAME.constants, customfunctions, periods);

%% Simplify the social welfare function

% if non-empty...
if ~strcmp(GAME.socialwelfare.raw, '')

    % load from GAME
    syms sw;
    sw = sym(GAME.socialwelfare.raw);
    
    % evaluate internal functions
    sw = evalinternal(sw);
    
    % substitute custom functions
    for m = 1: size(customfunctions,1);
        sw = subs(sw, sym(customfunctions{m,1}), sym(customfunctions{m,3}));
    end    
    
	% Substitute constant values
	for n = 1:length(GAME.constants);
    	sw = subs(sw, GAME.constants(n).consym, GAME.constants(n).value);
	end

    % replace dynamic variables with z(1), z(2), etc
    % (the slightly convoluted approach is to prevent weird substitutions
    % of parts of variable names). also converts to string.
    for m = 1:length(variables);
        sw = subs(sw, sym(variables{m}), sym(['dynamicvariabletobereplaced', num2str(m), 'X']));
	end
    sw = char(sw);
    for m = 1:length(variables);
        sw = strrep(sw, ['dynamicvariabletobereplaced', num2str(m), 'X'], ['(z(',num2str(m),'))']);
    end

    % return to GAME
    GAME.socialwelfare.simple = sw;
    
end


%% Simplify the payoffs

% if non-empty...
if ~isempty(GAME.payoffs)
    syms f;    
    
    % if not an open loop game which is summing payoffs...
    if ~isequal(GAME.type, [1,1]);
        
        % load from GAME
        for n = 1:length(GAME.payoffs);
            f(n) = evalinternal(sym(GAME.payoffs(n).raw));
        end
    
        % substitute custom functions
        for n = 1: length(f);
            for m = 1: size(customfunctions,1);
                f(n) = subs(f(n), sym(customfunctions{m,1}), sym(customfunctions{m,3}));
            end
        end
        
	% if is an open loop game which is summing payoffs....
    else
        
        % for each player...
        for n = 1:length(GAME.payoffs); 
            
            summedperiod = '0';
            % Sum a copy of each period together, in each period...
            for m = 0:(GAME.periods);
                
                % If it's the last period, load the scrap function. Else
                % load the stage function
                if m ~= GAME.periods
                    subperiod = GAME.payoffs(n).stage;
                else   
                    subperiod = GAME.payoffs(n).scrap;
                end
                
                % Add the custom functions
                subperiod = addperiodcustomfunctions(subperiod, customfunctions, m);

                % Add this period to the list of sum payoffs
                summedperiod = strcat(summedperiod, ' + ',subperiod);
            end
            
            % Add it to that sym
            f(n) = sym(summedperiod);
        end  
    end
    
    % Evaluate internal functions
    f = evalinternal(f);
    
	% Substitute constant values into constraints variable
	for n = 1:length(GAME.constants);
        constant = GAME.constants(n).value;
        if ischar(constant); constant = str2num(GAME.constants(n).value); end
    	f = subs(f, GAME.constants(n).consym, constant);
	end
    
    % and multiply by the weights
	for n = 1:length(f);
        f(n) = GAME.payoffs(n).weight * f(n);
    end

    % evaluate internal functions
    f = evalinternal(f);
    
    % replace dynamic variables with z(1), z(2), etc
    % (the slightly convoluted approach is to prevent weird substitutions
    % of parts of variable names). also converts to string.
    g={};
    for n = 1:length(GAME.payoffs);
        for m = 1:length(variables);
            f(n) = subs(f(n), sym(variables{m}), sym(['dynamicvariabletobereplaced', num2str(m), 'X']));
        end
        g{n} = char(f(n));
        for m = 1:length(variables);
            g{n} = strrep(g{n}, ['dynamicvariabletobereplaced', num2str(m), 'X'], ['(z(',num2str(m),'))']);
        end
    end
    f = g;
        
    % return to GAME
    for n = 1:length(GAME.payoffs);
        GAME.payoffs(n).simple = f{n};
    end

end

function expression = addperiodcustomfunctions(expression, customfunctions, period)
% This substitutes the custom functions into a mathematical expression,
% with a given period replacing "(n)"

% Create a list of simplified custom functions with '(n)'
% substituted by the period number
for p = 1:size(customfunctions, 1);
    customfunctions{p,3} = strrep(customfunctions{p,2}, '(n)', num2str(period));
    % substitute previously-declared custom functions
    if p > 1;
        for q = 1: (p - 1);
            oldchar = customfunctions{p,3};
            referencechar = customfunctions{q,1};
            codechar = customfunctions{q,2};
            customfunctions{p,3} = char(subs(sym(oldchar), sym(referencechar), sym(codechar)));
        end
    end
    customfunctions{p,3} = char(evalinternal(sym(customfunctions{p,3})));
end

% Substitute the custom functions in.
% The gross thing here is that we can't use symbolic substitution, as doing
% so would simplify '(n)' into 'n'. Which, to be honest in hindsight would
% be a good reason to use a form other than '(n)', e.g. _n_ or |n|. C'est
% le vie. We also don't want to use raw text switching with strrep() as
% that causes glitches when one function's name can be found within
% another, such as with 'phi' and 'p'. (That is why we try and use symbolic
% substitution as often as possible in this script.)
% Sorry.
expression = strrep(expression, '(n)', 'n2beFlickedL8r');
expression = sym(expression);
for p = 1: size(customfunctions,1);
    replaceyname = strrep(customfunctions{p,1},'(n)', 'n2beFlickedL8r');
    replaceycontent = strrep(customfunctions{p,3}, '(n)', 'n2beFlickedL8r');
    expression = subs(expression, sym(replaceyname), sym(replaceycontent));
end
expression = char(expression);
expression = strrep(expression, 'n2beFlickedL8r', '(n)');

% Substitute '(n)' with the period number in the stage
% payoff function (in brackets),
expression = strrep(expression, '(n)', ['(',num2str(period),')']);
    
% Change any (e.g.) '_(1)' to '_1'
expression = underscorebracketfixer(expression);

% Substitute the custom functions in again -- this
% is necessary as custom functions' reference could have
% '(n)' or whatever n actually is.
for p = 1: size(customfunctions,1);
    expression = char(subs(sym(expression), sym(customfunctions{p,1}), sym(customfunctions{p,3})));
end
    
% Evaluate internal functions
expression = char(evalinternal(expression));

function constraints = constraintsimplify(constraints, variables, constants, customfunctions, periods)
% simplifies the constrains (works for both the 'equal to' and the 'equal
% or lesser than' cases)

% if non-empty...
if ~isempty(constraints)
    
    % load constraints
    c = sym([]);
    for n = 1:length(constraints);
        constraint = (constraints(n).raw);
    
        % For each constraint, if it contains "(n)", we add that constraint
        % with (n) substituted as 0,...,T-1 (T = number of periods). This
        % substitutes the custom functions in. If not, we just add it with 
        % the custom functions substituted. (We only have to do this if
        % we're openloop, of course.)
        if strfind(constraint, '(n)') & (periods > 0);
            for p = 0:periods-1
                periodconstraint = addperiodcustomfunctions(constraint, customfunctions, p);
                c(end+1) = sym(periodconstraint);
            end
        else
            c(end+1) = sym(constraint);
            for h = 1: size(customfunctions,1);
                c(end) = subs(c(end), sym(customfunctions{h,1}), sym(customfunctions{h,3}));
            end
        end
    end
    
    % evaluate internal functions
    c = evalinternal(c);
    
	% Substitute constant values into constraints variable
	for n = 1:length(constants);
        constant = constants(n).value;
        if ischar(constant); constant = str2num(constants(n).value); end
    	c = subs(c, constants(n).consym, constant);
	end
    
    % replace dynamic variables with z(1), z(2), etc
    % (the slightly convoluted approach is to prevent weird substitutions
    % of parts of variable names). also converts to string.
    g={};
    for n = 1:length(c);
        for m = 1:length(variables);
            c(n) = subs(c(n), sym(variables{m}), sym(['dynamicvariabletobereplaced', num2str(m), 'X']));
        end
        g{n} = char(c(n));
        for m = 1:length(variables);
            g{n} = strrep(g{n}, ['dynamicvariabletobereplaced', num2str(m), 'X'], ['(z(',num2str(m),'))']);
        end
    end
    c = g;

    % Match up the constraint functions with the equations that matched
    % them. This is only a problem if "(n)" was used.
    oldraw = {constraints.raw};
    constraints = [];
    for n = 1:length(oldraw);
        % For each constraint, if it contains "(n)", we add that constraint
        % n times. Otherwise just add it
        if strfind(oldraw{n}, '(n)') & (periods > 0);
            for p = 0:periods-1
                constraints(end+1).raw = strrep(oldraw{n}, '(n)', [num2str(p)]);
                constraints(end).simple = c{1};
                c = c(2:end);
            end
        else
            constraints(end+1).raw = oldraw{n};
            constraints(end).simple = c{1};
            c = c(2:end);
        end
    end

end