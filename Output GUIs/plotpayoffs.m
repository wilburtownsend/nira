function plotpayoffs(handles)
% Create the heatmap indicating selected player's payoffs for ceteris
% paribus changes to two variables (all other variables are set to the
% equilibrium point)

%% load the variables
xvariable = get(handles.popupmenuXaxispayoffs, 'Value');
yvariable = get(handles.popupmenuYaxispayoffs, 'Value');
selectedplayer = get(handles.popupmenuplayerselect, 'Value');
if xvariable == yvariable
    errordlg('The variables which have been selected are identical -- please select distinct variables.');
    return;
end
variables = handles.currentoutput.playervariables;
xequilibrium = variables(xvariable).result;
xguess = variables(xvariable).guess;
xlower = variables(xvariable).bounds(1,1);
xupper = variables(xvariable).bounds(1,2);
yequilibrium = variables(yvariable).result;
yguess = variables(yvariable).guess;
ylower = variables(yvariable).bounds(1,1);
yupper = variables(yvariable).bounds(1,2);

%% develop the heatmap

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
    xwidth = length(xlowerbound:xupperbound);
if isfinite(ylower) && isfinite(yupper) 
    ylowerbound = ylower;
    yupperbound = yupper;
elseif isfinite(ylower) 
    ylowerbound = ylower;
    yupperbound = 2*yequilibrium - ylower;
elseif isfinite(yupper)
    ylowerbound = 2*yequilibrium - yupper;
    yupperbound = yupper;
else
    ylowerbound = yequilibrium - 40*(abs(yequilibrium - yguess));
    yupperbound = yequilibrium + 40*(abs(yequilibrium - yguess));
end
    ywidth = length(ylowerbound:yupperbound);
    
payoffimage = ones(ywidth, xwidth);

equilibrium = {variables(:).result};
equilibrium{xvariable} = NaN;
equilibrium{yvariable} = NaN;
actions = zeros(length(equilibrium),1);
for n = 1:length(actions); actions(n)= equilibrium{n}; end % convert cell to vector

for n = 1:xwidth
    for m = 1:ywidth
        actions(xvariable) = n;
        actions(yvariable) = m;
        payoffimage(m, n) = loadpayofffunctions(actions, selectedplayer);
    end
end

%% plots
figure();
surf(xlowerbound:xupperbound, ylowerbound:yupperbound, payoffimage);
colormap(hot);
view(2);
colorbar;
xlim ([xlowerbound,xupperbound]);
ylim ([ylowerbound,yupperbound]);
xlabel(variables(xvariable).symbol);
ylabel(variables(yvariable).symbol);