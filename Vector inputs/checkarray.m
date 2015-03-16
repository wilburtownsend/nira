function arrays = checkarray(inputcell)
% looks through a cell array of strings. Each string corresponds to either a 
% double or an array. 'arrays' is a vector which references which bits of the cell array
% had, finding any arrays


arrays = [];
for n = 1:length(inputcell)
    conlength = length(str2num(inputcell{n}));
    if conlength > 1; arrays = [arrays,n]; end
end