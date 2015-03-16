function indices = indicesmatrix(A)
% Creates an 'indices matrix' for a cell array A. That is, it creates a matrix
% for which each row is a reference to the various elements of A. Note: A
% must be a 1 dimensional cell array of vectors.

width = length(A); % calculate width of indices matrix
% calculate height of indices matrix -- product of all vector sizes
height = 1; 
for n = 1:width;
    height = height * length(A{n});
end

indices = zeros(height, width); % create indices matrix
indices(1,:) = ones(1,width); % first row is all ones

for n = 2:height % for other rows
    indices(n,:) = indices(n-1,:); % make it same as row before, except...
    examinedcell = width; % you want to make the last number..
    nonew = 0;
    while nonew == 0; % one higher than what it was before
        if ~(indices(n,examinedcell) == length(A{examinedcell}));
            indices(n,examinedcell) = indices(n,examinedcell)+1;
            nonew = 1;
        else % unless its as high as it can get, in which case it resets to one and you examine the one before, and so on
            indices(n,examinedcell) = 1;
            examinedcell = examinedcell -1;
        end
    end
end