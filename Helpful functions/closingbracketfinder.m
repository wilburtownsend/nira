function location = closingbracketfinder(text)
% Finds the location of a closing bracket in a string of text. Requires the
% first character to be an opening bracket

if ~strcmp(text(1), '(');
    error = MException('stringerror:nofirstbracket',...
        'First character of string is not an opening bracket');
    throw(error);
end

% Start counting brackets, adding one when the next is an open bracket,
% subtracting one when the next is a closing bracket. When you get to zero,
% you have your closing bracket.
bracketcount = 1; % Start with one opening bracket 
location = 2; % Start after that opening bracket
while 1;    
    % Find the next closing bracket
    firstclose = strfind(text(location:end), ')');
    % If no closing bracket, throw an error
    if isempty(firstclose); throw(MException('stringerror:insufficientclosingbracket',...
        'There are more opening brackets than closing brackets')); end
    firstclose = firstclose(1) - 1;
    % See if there is an opening bracket between location and the next
    % closing bracket
    nextopen = strfind(text(location:(location+firstclose)), '(');
    % If there is, move just past it, and note we have one more closing
    % bracket to find
    if nextopen;
        nextopen = nextopen(1);
        bracketcount = bracketcount + 1;
        location = location + nextopen;
    % If not, move just past the closing bracket, and note we have one less
    % closing bracket to find
    else
        bracketcount = bracketcount - 1;
        location = location + firstclose + 1;        
        % If we need to find no more closing brackets, jump back one step
        % then exit        
        if ~bracketcount;
            location = location - 1;
            break
        end
    end
end