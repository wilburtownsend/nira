function summation = subsum(f,x,a,b)
% sums a function (f) over a variable f. different to symsum(), as subsum()
% substitutes '_x' (with x being the summation index) for '_1', '_2', etc
% as it sums.

% if trying to expand the sum throws an error, we return the sum unexpanded
try

    summation = 0;
    if ischar(x), x = sym(x); end
    if b<a
        summation = sym('0');
        return;
    end

    for n = a:b;
        newelement = char(f);
        newelement = strrep(newelement, ['_', char(x)], ['_', num2str(n)] );
        newelement = sym(newelement);
        newelement = symsum(newelement,x,n,n);
        summation = summation + newelement;
    end

    summation = sym(char(summation));
    
catch
   
    summation = sym(['subsum(',char(f),',',char(x),',',tostr(a),',',tostr(b),')']);
    
end