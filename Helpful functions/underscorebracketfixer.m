function symbolicfunction = underscorebracketfixer(symbolicfunction)
% Sometimes in dynamic contexts, a variable will be referred to as (e.g.)
% 'u_(2)' when it should be 'u_2'. This fixes that. Works for char or sym
% inputs, always produces a char output.

% Turn into a char
symbolicfunction = char(symbolicfunction);

% While there are still '_(' to clean
while strfind(symbolicfunction, '_('); 

    % Find the opening bracket
    open = strfind(symbolicfunction, '_(');
    open = open(1);
    % Find the closing bracket
    remainingstring = symbolicfunction(open:end);
    close = open + strfind(remainingstring, ')');
    close = close(1);
    
    % If what we've found isn't an integer, ignore it for now by putting a
    % thing between the underscore and the bracket (we fix this below)
    index = symbolicfunction(open+2:close-2);
    if ~checkint(index) && (~strcmp(index,'0'));
        symbolicfunction = [symbolicfunction(1:open), '**(', symbolicfunction(open+2:end)];
    % If not, take away the brackets and leave what remains
    else    
        symbolicfunction = symbolicfunction([1:open, open+2:close-2, close:end]);
    end
end

symbolicfunction = strrep(symbolicfunction, '_**(', '_(');