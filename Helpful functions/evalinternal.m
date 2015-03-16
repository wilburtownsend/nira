function symbolicfunction = evalinternal(symbolicfunction)
% Evaluates a symbolic expression, hopefully symplifying it


if isnan(symbolicfunction); return; end

% turn into a sym if necessary
if ~strcmp(class(symbolicfunction), 'sym'); symbolicfunction = sym(symbolicfunction); end

% This function requires variables not to have pre-existing values, so the
% following must be declared to remove their usual values
syms j pi i

% symplify
symbolicfunction = simplify(symbolicfunction);

% fix any '_(5)' (won't work if there are still '_(n)', so we only try to do it)
symbolicfunction = sym(underscorebracketfixer(symbolicfunction));

% Create a struct which we'll use to substitute functions out
functionsubstituter = struct([]);

% go through using eval(). note eval() requires internal variables to be
% declared, the error-catching deals with that
while 1
    try
        symbolicfunction = eval(symbolicfunction);
        break;
    catch exception;
        if ~strcmp(exception.identifier,'MATLAB:UndefinedFunction');
            throw(exception);
        end
        % If the problem is that we have an undeclared variable, declare it
        if strcmp(exception.message([20,21]), 'or');
            undeclaredvariable = strsplit(exception.message, '''');
            undeclaredvariable = undeclaredvariable{2};
            eval(['syms ', undeclaredvariable])
        % If the problem is that we have an undeclared function, things are
        % MUCH more complicated. We have to substitute the function out,
        % and then put it in later. The main issue here is that, if there
        % is a function within the function
        % [e.g., max(sum(x_1,x_2), sum(y_1,y_2))] then those internal
        % functions aren't simplified -- this is fixed by recursively
        % calling on those functions
        elseif strcmp(exception.message([1:20]), 'Undefined function ''');
            % Turn it into a char
            symbolicfunction = char(symbolicfunction);
            % Find the name of the problematic function
            undeclaredfunction = strsplit(exception.message, '''');
            undeclaredfunction = undeclaredfunction{2};
            % Find the (first occurence of) the function in the expression
            uflocation = strfind(symbolicfunction, undeclaredfunction);
            uflocation = uflocation(1);
            % Find the appropriate brackets for the function
            openbracket = uflocation + length(undeclaredfunction);
            if ~strcmp(symbolicfunction(openbracket),'('); throw(MException(...
                    'stringerror:notopenbracket', ...
                    'Character after function is not an opening bracket')); end
            closebracket = closingbracketfinder(symbolicfunction(openbracket:end)) + openbracket - 1;
            % Store the problematic function in a struct, evaluating its
            % contents
            functionsubstituter(length(functionsubstituter)+1).fname = undeclaredfunction;
            content = symbolicfunction(openbracket+1:closebracket-1);
            functionsubstituter(length(functionsubstituter)).content = ...
                char(evalinternal(['[',content,']']));
            if length(functionsubstituter(end).content) > 6 && strcmp(functionsubstituter(end).content(1:7), 'matrix('); ...
                    functionsubstituter(end).content = functionsubstituter(end).content(10:end-3); end
            % Replace the problematic function
            symbolicfunction = [symbolicfunction(1:uflocation-1), 'substitutedfunction',...
                num2str(length(functionsubstituter)), symbolicfunction(closebracket+1:end)];
            % Turn it back into a sym
            symbolicfunction = sym(symbolicfunction);
        else
            throw(exception);
        end
    end
end

% Replace substituted function back
symbolicfunction = tostr(symbolicfunction);
for f = 1:length(functionsubstituter);
    newfunction = [functionsubstituter(f).fname, '(',...
        functionsubstituter(f).content, ')'];
    symbolicfunction = strrep(symbolicfunction, ['substitutedfunction', num2str(f)], newfunction);
end
symbolicfunction = sym(symbolicfunction);


% turn into a sym if necessary
if strcmp(class(symbolicfunction), 'double'); symbolicfunction = sym(symbolicfunction); end