function [check] = checkint(string)
% checks if a number is an integer greater than zero

% if input is string, turn it into a number
if ischar(string);
    number = str2double(string);
else
    number = string;
end

% checks if a number is non-empty, is an integer (by turning into an integer and comparing with itself)
% and  greater than zero
check = ~isempty(number);
check = check * (strcmp(num2str(int32(number)), num2str(number)));
check = check * (number > 0);