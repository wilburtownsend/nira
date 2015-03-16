function plotstatic(handles)
% Plots (in either 2d or 3d) a graph of the constraints with the outcome
% point. all variables not on an axis are set to the equilibrium value.

%% Load the variables

global GAME
variables = handles.currentoutput.playervariables;

xvariable = get(handles.popupmenustaticxplayer, 'Value');
yvariable = get(handles.popupmenustaticyplayer, 'Value');
zvariable = get(handles.popupmenustaticzplayer, 'Value') - 1;

if xvariable == yvariable || yvariable == zvariable || xvariable == zvariable
    errordlg('Two of the variables which have been selected are identical -- please select distinct variables.');
    return;
end

%% Create the data to plot
% load various variables
xequilibrium = variables(xvariable).result;
xguess = variables(xvariable).guess;
xlower = variables(xvariable).bounds(1,1);
xupper = variables(xvariable).bounds(1,2);
yequilibrium = variables(yvariable).result;
yguess = variables(yvariable).guess;
ylower = variables(yvariable).bounds(1,1);
yupper = variables(yvariable).bounds(1,2);
syms X Y

if zvariable % FOR 3 VARIABLES also get z variables
    zequilibrium = variables(zvariable).result;
    zlower = variables(zvariable).bounds(1,1);
    zupper = variables(zvariable).bounds(1,2);
    syms Z
end

% Figure out the axis dimensions. First attempts to use the variable
% bounds, if they're finite, or the difference between a variable bound
% and the equilibrium, if only one is finite. Failing all that, uses 4
% times the difference between the starting guess and the equilibrium point
if isfinite(xlower) && isfinite(xupper) 
    xlowerbound = xlower;
    xupperbound = xupper;
elseif isfinite(xlower) 
    xlowerbound = xlower;
    xupperbound = 2*xequilibrium - xlower;
elseif isfinite(xupper)
    xlowerbound = 2*xequilibrium - xupper;
    xupperbound = xupper;
else
    xlowerbound = xequilibrium - 4*(abs(xequilibrium - xguess));
    xupperbound = xequilibrium + 4*(abs(xequilibrium - xguess));
end
    t_x = xlowerbound:((xupperbound-xlowerbound)/20):xupperbound;

if zvariable % FOR 3 VARIABLES also set y variables
    if isfinite(ylower) && isfinite(yupper) 
        ylowerbound = ylower;
        yupperbound = yupper;
    elseif isfinite(ylower) 
        ylowerbound = ylower;
        yupperbound = 2*yequilibrium - ylower; % make sure this is referring t the ys! esp. equilibrium (1) and xguess
    elseif isfinite(yupper)
        ylowerbound = 2*yequilibrium - yupper;
        yupperbound = yupper;
    else
        ylowerbound = yequilibrium - 4*(abs(yequilibrium - yguess));
        yupperbound = yequilibrium + 4*(abs(yequilibrium - yguess));
    end
        t_y = ylowerbound:((yupperbound-ylowerbound)/20):yupperbound;
end
    


% load each lessconstraint, change the
% way the variables are represented and solve for the second variable.
% finally, turn the constraint into a sequence of vectors for plotting and
% put it into a cellarray
lessconstraints = cell(length(GAME.lessconstraints));
for n = 1:length(GAME.lessconstraints)
    constraint = GAME.lessconstraints(n).simple;
    for m = 1:length(variables)
        if m == xvariable; constraint = strrep(constraint, ['z(',num2str(m),')'], 'X');
        elseif m == yvariable; constraint = strrep(constraint, ['z(',num2str(m),')'], 'Y');
        elseif m == zvariable; constraint = strrep(constraint, ['z(',num2str(m),')'], 'Z');
        else constraint = strrep(constraint, ['z(',num2str(m),')'], ['(',num2str(variables(m).result),')']);
        end
    end
    if ~zvariable % FOR 3 VARIABLES
        constraint = solve(sym([constraint, ' == 0']), 'Y');
        constraint = char(constraint(1));
        lessconstraints{n} = zeros(length(t_x),2);
        for m = 1:length(t_x);
            X = t_x(m);
            Y = eval(constraint);
            lessconstraints{n}(m,1) = X;
            lessconstraints{n}(m,2) = Y;
        end
    else
        constraint = solve(sym([constraint, ' == 0']), 'Z');
        constraint = char(constraint(1));
        lessconstraints{n} = zeros(length(t_x),length(t_y),3);
        for m = 1:length(t_x);
            for p = 1:length(t_y)
                X = t_x(m);
                Y = t_y(p);
                Z = eval(constraint);
                lessconstraints{n}(m,p,1) = X;
                lessconstraints{n}(m,p,2) = Y;
                lessconstraints{n}(m,p,3) = Z;
            end
        end
    end
end

% load each eqconstraint, change the
% way the variables are represented and solve for the second variable.
% finally, turn the constraint into a sequence of vectors for plotting and
% put it into a cellarray
eqconstraints = cell(length(GAME.eqconstraints));
for n = 1:length(GAME.eqconstraints)
    constraint = GAME.eqconstraints(n).simple;
    for m = 1:length(variables)
        if m == xvariable; constraint = strrep(constraint, ['z(',num2str(m),')'], 'X');
        elseif m == yvariable; constraint = strrep(constraint, ['z(',num2str(m),')'], 'Y');
        elseif m == zvariable; constraint = strrep(constraint, ['z(',num2str(m),')'], 'Z');
        else constraint = strrep(constraint, ['z(',num2str(m),')'], ['(',num2str(variables(m).result),')']);
        end
    end
    if ~zvariable % FOR 2 VARIABLES
        constraint = char(solve(sym([constraint, ' == 0']), 'Z2'));
        eqconstraints{n} = zeros(length(t_x),2);
        for m = 1:length(t_x);
            X = t_x(m);
            Y = eval(constraint);
            eqconstraints{n}(m,1) = X;
            eqconstraints{n}(m,2) = Y;
        end
    else % FOR 3 VARIABLES
        constraint = char(solve(sym([constraint, ' == 0']), 'Z3'));
        eqconstraints{n} = zeros(length(t_x),length(t_y),3);
        for m = 1:length(t_x);
            for p = 1:length(t_y)
                X = t_x(m);
                Y = t_y(p);
                Z = eval(constraint);
                eqconstraints{n}(m,p,1) = X;
                eqconstraints{n}(m,p,2) = Y;
                eqconstraints{n}(m,p,3) = Z;
            end
        end
    end
end
    




%% PLOT

% create a new figure
figure;

hold on

if ~zvariable % FOR 2 VARIABLES

    % add the lessconstraints, in blue
    for n = 1:length(lessconstraints)
        currentconstraint = lessconstraints{n};
        x = currentconstraint(:,1);
        y = currentconstraint(:,2);
        plot(x,y, 'b');
    end

    % add the eqconstraints, in red
    for n = 1:length(eqconstraints)
        currentconstraint = eqconstraints{n};
        x = currentconstraint(:,1);
        y = currentconstraint(:,2);
        plot(x,y, 'r');
    end

    % add the equilibrium point
    plot(xequilibrium, yequilibrium, 'g:diamond');

    % sort the axes. note we can't set any to inf, as that stops us from
    % getting what they'd auto-adjust too later (when we do the heatmap)
    xlim([xlowerbound, xupperbound]);
    xlimits = xlim;
    ylimits = ylim;
    if ylimits(1) < ylower
        ylimits(1) = ylower;
    end
    if ylimits(2) > yupper
        ylimits(2) = yupper;
    end
    ylim(ylimits);
    hold off
    xlabel(variables(xvariable).symbol);
    ylabel(variables(yvariable).symbol);

else % FOR 3 VARIABLES

    % add the lessconstraints
    for n = 1:length(lessconstraints)
        currentconstraint = lessconstraints{n};
        x = currentconstraint(:,1,1);
        y = currentconstraint(1,:,2)';
        z = currentconstraint(:,:,3);
        surf(x,y,z);
    end

    % add the eqconstraints
    for n = 1:length(eqconstraints)
        currentconstraint = eqconstraints{n};
        x = currentconstraint(:,1,1);
        y = currentconstraint(1,:,2)';
        z = currentconstraint(:,:,3);
        surf(x,y,z, 'r');
    end

    % add the equilibrium point
    h = plot3(xequilibrium, yequilibrium, zequilibrium, 'g:diamond');

    % sort the axes. note we can't set any to inf, as that stops us from
    % getting what they'd auto-adjust too later (when we do the heatmap)
    xlim([xlowerbound, xupperbound]);
    ylim([ylowerbound, yupperbound]);
    hold off
   
    view([-60,-30]);
    colormap hot;
    xlabel(variables(xvariable).symbol);
    ylabel(variables(yvariable).symbol);
    zlabel(variables(zvariable).symbol);
end