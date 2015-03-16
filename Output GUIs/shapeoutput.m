function [variables, c, constraints, exitflag, t, customfunctions] = shapeoutput(p, c, l, exitflag, t)
% this changes the structure of the outputs, making them more intuitive
% (especially for vector inputs)

global GAME

z = p; % this makes eval work

%% Create variables structure.
track = 1;
variables = struct;
if GAME.type(1) == 0;
% If the game is static...
    for n = 1:length(GAME.variables)
        for m = 1:length(GAME.variables{n})
            variables(track).symbol = GAME.variables{n}(m).varsym;
            variables(track).guess = GAME.variables{n}(m).guess;
            bounds(1,1) = GAME.variables{n}(m).lower;
            bounds(1,2) = GAME.variables{n}(m).upper;
            bounds(2,1) = l.lower(track);
            bounds(2,2) = l.upper(track);
            variables(track).bounds = bounds;
            track = track + 1;
        end
    end    
else
% If the game is openloop...
    for n = 1:length(GAME.variables)
        for m = 1:length(GAME.variables{n})
            for q = 1:GAME.periods
                variables(track).symbol = strcat(GAME.variables{n}(m).varsym, '_', num2str(q));
                variables(track).guess = GAME.variables{n}(m).guess;
                bounds(1,1) = GAME.variables{n}(m).lower;
                bounds(1,2) = GAME.variables{n}(m).upper;
                bounds(2,1) = l.lower(track);
                bounds(2,2) = l.upper(track);
                variables(track).bounds = bounds;
                track = track + 1;
            end
        end
    end  
end
if exitflag>0
    for n=1:length(variables)
        variables(n).result = p(n);
    end
else
    for n=1:length(variables)
        variables(n).result = NaN;
    end
end

%% Create constraints structure
constraints = struct;
constraints.equals = l.eqnonlin';
constraints.lessthan = l.ineqnonlin';
for n = 1:length(constraints.equals)
    thisslack = -eval(GAME.eqconstraints(n).simple);
    if abs(thisslack) < GAME.accuracy(4); thisslack = 0; end
    constraints.equals(2,n) = thisslack;
end
for n = 1:length(constraints.lessthan)
    thisslack = -eval(GAME.lessconstraints(n).simple);
    if abs(thisslack) < GAME.accuracy(4); thisslack = 0; end
    constraints.lessthan(2,n) = thisslack;
end


%% Create custom functions structure
if ~isempty(GAME.customfunctions) && exitflag > 0;
    blanks = cell(ones(1,length(GAME.customfunctions)));
    customfunctions = struct('reference',blanks,'value',blanks);
    for n = 1:length(GAME.customfunctions)
        customfunctions(n).reference = GAME.customfunctions(n).reference;
        thiscustom = GAME.customfunctions(n).code;
        % Substitute constant values into custom function
        for m = 1:length(GAME.constants);
            thiscustom = char(sym(subs(thiscustom, GAME.constants(m).consym, ['(', num2str(GAME.constants(m).value), ')'])));
        end
        thiscustom = char(evalinternal(sym(thiscustom)));
        % Substitute dynamic values into custom function
        for m = 1:length(variables);
            thiscustom = strrep(thiscustom, variables(m).symbol, ['(',num2str(variables(m).result),')']);
        end
        % Substitute previously deduced custom functions
        if n > 1;
            for m = 1: (n - 1);
                referencechar = GAME.customfunctions(m).reference;
                codechar = customfunctions(m).value;
                thiscustom = strrep(thiscustom, referencechar, ['(',num2str(codechar),')']);
            end
        end
        % evaluate custom function
        thiscustom = char(evalinternal(sym(thiscustom)));
        try
            thiscustom = eval(thiscustom);
        catch
            thiscustom = [NaN];
        end
        customfunctions(n).value = thiscustom;
    end
else
    customfunctions = struct([]);
end
% add the external social welfare and the total welfare to the custom
% functions
if ~strcmp(GAME.socialwelfare.raw,'')
    try
        externalwelfare = eval([GAME.socialwelfare.simple, ';']);
    catch
        externalwelfare = NaN;
    end
    customfunctions(end+1).reference = 'External welfare';
    customfunctions(end).value = externalwelfare;
else
    externalwelfare = 0;
end
totalwelfare = sum(c) + externalwelfare;
customfunctions(end+1).reference = 'Total welfare';
customfunctions(end).value = totalwelfare;