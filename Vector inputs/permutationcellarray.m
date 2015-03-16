function constants = permutationcellarray(inputcell)
% Creates a k-dimensional cell array, which includes all possible
% permutations of k vectors (i.e. each entry in the cell array is a vector
% containing one double from each of the vectors, and all possible vectors
% exist).

% The input should be a one dimensional cell array of strings, where each
% string describes either a vector or a scalar. The vectors will be used to
% create the output, the scalars will be ignored.


arrays = checkarray(inputcell); % this refers to which constants have arrays entered

% this creates two things: a cell array of vectors of a form where it can be used by
% indicesmatrix(), and a vector which records the length of each of the
% vector entries
constantvectors = cell(length(arrays));
lengtharrays = zeros(1,length(arrays));
for n = 1:length(arrays)
    currentarray = arrays(n);
    constantvectors{n} = str2num(inputcell{currentarray});
    lengtharrays(n) = length(constantvectors{n});
end

% this creates the indices matrix, which we will use to refer to parts of
% the constants cell array
indices = indicesmatrix(constantvectors);

% this creates the constants cell array. this is a cell array, where each
% entry is a vector containing a combination of constants
if length(lengtharrays) == 1; constants = cell(lengtharrays,1); else constants = cell(lengtharrays); end
for n = 1:size(indices,1); % for each index
    thiscombo = zeros(1,length(arrays)); % pre-load with zeros
    for m = 1:length(arrays) % for each vector of constants, select the one which corresponds with the index
        currentarray = arrays(m);
        currentvector = str2num(inputcell{currentarray});
        thiscombo(m) = currentvector(indices(n,m));
    end
    thisindex = num2cell(indices(n,:));  % add the vector to the indexed cell array
    constants(thisindex{:}) = {thiscombo};
end