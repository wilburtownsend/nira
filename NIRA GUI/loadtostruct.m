function loadtostruct(handles)
% Loads variables from GUI to a global structure called GAME

global GAME;

% name
GAME.name = get(handles.editname, 'String');

% gametype
if get(handles.radiobuttonstatic, 'Value') == 1.0;
    GAME.type(1) = 0;
else
    GAME.type(1) = 1;
end

% individually summed payoffs or not
if get(handles.radiobuttonindividual, 'Value') == 1.0;
    GAME.type(2) = 0;
else
    GAME.type(2) = 1;
end


% numberofperiods
GAME.periods = str2double(get(handles.editperiods, 'String'));

% numberofplayers
GAME.numplayers = str2double(get(handles.editnumber, 'String'));

% variables
playerselected = get(handles.popupmenuvar, 'Value');
resetvartable(playerselected, handles);

% custom functions
customfunctionsdata = get(handles.uitablecustom, 'Data');
customfunctionsreference = customfunctionsdata(:,1);
customfunctionscode = customfunctionsdata(:,2);
GAME.customfunctions = struct('reference', customfunctionsreference, 'code', customfunctionscode);

% constants
constantsdata = get(handles.uitableconstants, 'Data');
constantsdataname = constantsdata(:,1);
constantsdatasym = constantsdata(:,2);
constantsdataval = constantsdata(:,3);
GAME.constants = struct('conname', constantsdataname, 'consym', constantsdatasym, 'value', constantsdataval);

% eqconstraints
GAME.eqconstraints = struct('raw', get(handles.uitableequal, 'Data'));

% lessconstraints
GAME.lessconstraints = struct('raw', get(handles.uitableless, 'Data'));

% payoffs
payoffsdata = get(handles.uitablepayoffs, 'Data');
payoffsdataplayer = payoffsdata(:,1);
payoffsdataexplicit =  payoffsdata(:,2);
payoffsdatastage =  payoffsdata(:,3);
payoffsdatascrap =  payoffsdata(:,4);
payoffsdataweight =  payoffsdata(:,5);
GAME.payoffs = struct('player', payoffsdataplayer, 'raw', payoffsdataexplicit,  'stage', payoffsdatastage,  'scrap', payoffsdatascrap, 'weight', payoffsdataweight);

% accuracy
GAME.accuracy = [NaN,NaN,NaN,NaN,NaN,NaN];
if get(handles.radiobuttonautostep, 'Value') == 1.0;
    GAME.accuracy(1) = 3;
else
    GAME.accuracy(1) = str2double(get(handles.editstepsize, 'String'));
end
GAME.accuracy(2) = str2double(get(handles.editNI, 'String'));
GAME.accuracy(3) = str2double(get(handles.editdiff, 'String'));
GAME.accuracy(4) = str2double(get(handles.edittolcon, 'String'));
GAME.accuracy(5) = str2double(get(handles.edittolfun, 'String'));
GAME.accuracy(6) = str2double(get(handles.edittolx, 'String'));
GAME.accuracy(7) = str2double(get(handles.editmaxits, 'String'));

% external social welfare function
GAME.socialwelfare = struct('raw', get(handles.editoptimum, 'String'));

% custom solution
GAME.customsolution = get(handles.editcustom, 'String');