function populateoutput(Output, selectedcell, solutiontype, handles)
% populates the output gui based off results and the game being solved

% load the game structure
global GAME

CurrentOutput = Output(selectedcell);


% add solution to handles structure
handles.currentoutput = CurrentOutput;
handles.output = Output;
handles.solutiontype = solutiontype;
guidata(handles.figureresults,handles);


% Set the title
if strcmp(solutiontype, 'CCNE')
    set(handles.texttitle, 'String', ['GAME: ',GAME.name, ' (coupled constraint Nash equilibrium)']);
elseif  strcmp(solutiontype, 'WelfareMax')
    set(handles.texttitle, 'String', ['GAME: ',GAME.name, ' (welfare-maximising solution)']);
else
    error('Game is of an unknown type.');
end

% Create the outcomes array, its column titles and its row titles
outcomecolumn = {};
outcomerow = {};
outcomedata = {};

for n = 1: GAME.numplayers
    outcomecolumn = [outcomecolumn, ['Player ', num2str(n)]];
end

% calculate maxvar -- the maximum variables of any player
maxvar = 1;
for n = 1: GAME.numplayers
    maxvar = max(maxvar, length(GAME.variables{n}));
end

% this generates the row titles and creates the data array
if GAME.type(1) == 0;
    % if it's static
    
    % for each row
    for m = 1 : maxvar
        rowheader = '';
        % add up the variable symbols for any player that has that many
        % variables, and add 'data to be entered' for any point in the data
        % that will have data added
        for n = 1: GAME.numplayers
            if length (GAME.variables{n}) >= m;
                nextsym = GAME.variables{n}(m).varsym;
                if strcmp(rowheader,''); rowheader = [nextsym];
                else rowheader = [rowheader, ', ', nextsym]; end
                outcomedata{m,n} = 'data to be entered';
            end
        end
        % add that row to the list of rows
        outcomerow = [outcomerow, rowheader];
    end
    
    % then turn the data array into an array which has numbers which
    % correspond to the outputs
    track = 1;
    for column = 1:GAME.numplayers
        for m = 1:maxvar
            if strcmp(outcomedata{m, column}, 'data to be entered')
                outcomedata{m, column} = CurrentOutput.playervariables(track).result;
                track = track + 1;
            else
                outcomedata{m,column} = NaN;
            end
        end
    end
    
else
    % if it's openloop
    
    % for each period
    for h = 0:(GAME.periods-1)
        % for each period
        for m = 1 : maxvar
            
            % add up the variable symbols for any player that has that many
            % variables, and add 'data to be entered' for any point in the data
            % that will have data added
            rowheader = '';
            for n = 1: GAME.numplayers
                if length (GAME.variables{n}) >= m;
                    nextsym = GAME.variables{n}(m).varsym;
                    if strcmp(rowheader,''); rowheader = [nextsym];
                    else rowheader = [rowheader, ', ', nextsym]; end
                    rowupto = maxvar * h + m;
                    outcomedata{rowupto,n} = 'data to be entered';
                end
            end
            % add that row to the list of rows
            outcomerow = [outcomerow, [rowheader, ' (t_', num2str(h), ')']];
        end
    end
    
    % then turn the data array into an array which has numbers which
    % correspond to the outputs
    track = 1;
    for column = 1:GAME.numplayers
        for n = 1:maxvar
            for m = n:maxvar:length(outcomerow)
                if strcmp(outcomedata{m, column}, 'data to be entered')
                    outcomedata{m, column} = CurrentOutput.playervariables(track).result;
                    track = track + 1;
                else
                    outcomedata{m,column} = NaN;
                end
            end
        end
    end
    
end

% add payoffs to the bottom
payoffs = CurrentOutput.payoffs;
outcomerow = [outcomerow, 'Payoffs'];
payoffcell = {};
for n = 1: length(payoffs)
    payoffcell = [payoffcell, {payoffs(n)}];
end
outcomedata = [outcomedata; payoffcell];


set(handles.uitableoutcomes, 'ColumnName', outcomecolumn);
set(handles.uitableoutcomes, 'RowName', outcomerow);
set(handles.uitableoutcomes, 'Data', outcomedata);

% do the customfunctions
% create a cellarray for the columns
customcolumn = {CurrentOutput.customfunctions(:).reference};
% create a cellarray for the data
customresults = {CurrentOutput.customfunctions.value};

set(handles.uitablecustomfunctions, 'ColumnName', customcolumn);
set(handles.uitablecustomfunctions, 'Data', customresults);


% do the constraints

% create a cellarray for the columns
constraintcolumn = {};
for n = 1:length(GAME.lessconstraints)
    constraintcolumn = [constraintcolumn, {['Constraint ', num2str(n), ' (', GAME.lessconstraints(n).raw, ')']}];
end
for n = 1:length(GAME.eqconstraints)
    constraintcolumn = [constraintcolumn, {['Constraint ', num2str(n), ' (', GAME.eqconstraints(n).raw, ')']}];
end

% create a cellarray for the data
constraintdata = [CurrentOutput.constraints.lessthan, CurrentOutput.constraints.equals];

set(handles.uitableconstraints, 'ColumnName', constraintcolumn);
set(handles.uitableconstraints, 'RowName', [{'Lambda'}, {'Slack'}]);
set(handles.uitableconstraints, 'Data', constraintdata);

% do the bounds

% create a cellarray for the columns
boundcolumn = {};
for n = 1:length (GAME.variables)
    for m = 1:length (GAME.variables{n})
        boundcolumn = [boundcolumn, {GAME.variables{n}(m).varsym}];
    end
end

% create a cell array for the rows
if GAME.type(1) == 0;
    % if static have this array
    boundrow = {'Lower lambda', 'Upper lambda'};
else
    % if openloop have an array that depends on the number of periods
    boundrow = {};
    for n = 1:GAME.periods
        boundrow = [boundrow, {['Lower lambda (t_', num2str(n), ')']}];
    end
	for n = 1:GAME.periods
        boundrow = [boundrow, {['Upper lambda (t_', num2str(n), ')']}];
    end
end

% create a cellarray for the data
bounddata = {};
if  GAME.type(1) == 0;
    trackconstraint = 1;
    trackcolumn = 1;
    for m = 1:length(GAME.variables)
        for h = 1:length (GAME.variables{m})
            upperbounddata{1,trackcolumn} = CurrentOutput.playervariables(trackconstraint).bounds(2,2);
            trackconstraint = trackconstraint + 1;
            trackcolumn = trackcolumn + 1;
        end
    end
    trackconstraint = 1;
    trackcolumn = 1;
    for m = 1:length(GAME.variables)
        for h = 1:length (GAME.variables{m})
            lowerbounddata{1,trackcolumn} = CurrentOutput.playervariables(trackconstraint).bounds(2,1);
            trackconstraint = trackconstraint + 1;
            trackcolumn = trackcolumn + 1;
        end
    end
else
    trackconstraint = 1;
    trackcolumn = 1;
    for m = 1:length(GAME.variables)
        for h = 1:length (GAME.variables{m})
            for n = 1:GAME.periods
                upperbounddata{n,trackcolumn} = CurrentOutput.playervariables(trackconstraint).bounds(2,2);
                trackconstraint = trackconstraint + 1;
            end
            trackcolumn = trackcolumn + 1;
        end
    end
    trackconstraint = 1;
    trackcolumn = 1;
    for m = 1:length(GAME.variables)
        for h = 1:length (GAME.variables{m})
            for n = 1:GAME.periods
                lowerbounddata{n,trackcolumn} = CurrentOutput.playervariables(trackconstraint).bounds(2,1);
                trackconstraint = trackconstraint + 1;
            end
            trackcolumn = trackcolumn + 1;
        end
    end
end
bounddata=[lowerbounddata;upperbounddata];


set(handles.uitablebounds, 'ColumnName', boundcolumn);
set(handles.uitablebounds, 'RowName', boundrow);
set(handles.uitablebounds, 'Data', bounddata);


exitflag = CurrentOutput.exitflag;
switch exitflag
    case 1
        termination = 'first order optimality conditions were satisfied to the specified tolerance.';
    case 2
        termination = 'change in x was less than the specified tolerance.';
    case 3
        termination = 'change in the objective function value was less than the specified tolerance.';
    case 4
        termination = 'magnitude of the search direction was less than the specified tolerance and constraint violation was less than TolCon.';
    case 5
        termination = 'magnitude of directional derivative was less than the specified tolerance and constraint violation was less than TolCon.';
    case 0
        termination = 'number of iterations exceeded the maximum iterations or number of function evaluations exceeded options.FunEvals.';
    case -1
        termination = 'algorithm was terminated by the output function.';
    case -2
        termination = 'no feasible point was found.';
end

set(handles.texttermination, 'String', ['The relaxation algorithm terminated when ', termination]);

% set axis dropdown lists
variablelist = {CurrentOutput.playervariables.symbol}';
playerlist = 1:GAME.numplayers;
set(handles.popupmenustaticxplayer, 'String', variablelist);
set(handles.popupmenustaticyplayer, 'String', variablelist);
set(handles.popupmenustaticzplayer, 'String', [{'None (2d graph)'};variablelist]);
set(handles.popupmenuXaxispayoffs, 'String', variablelist);
set(handles.popupmenuYaxispayoffs, 'String', variablelist);
set(handles.popupmenuplayerselect, 'String', playerlist);