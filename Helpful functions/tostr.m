function a = tostr(a)
% Transforms a num or a sym into a string
if isnumeric(a);
    a = num2str(a);
else
    a = char(a);
end