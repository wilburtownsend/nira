function populate(handles)
% Populates the GUI from GAME

global GAME playerselected;
playerselected = 1;

set(handles.editname, 'String', GAME.name);

set(handles.editnumber, 'String', GAME.numplayers);

playerlist=[];
for n = 1:GAME.numplayers;
  	playerlist=[playerlist,n];
end
set(handles.popupmenuvar, 'String', playerlist);

if GAME.type(1) == 0;
    set(handles.radiobuttonstatic, 'Value', 1);
	set(handles.editperiods, 'Enable', 'off');
	set(handles.uiopenlooppayoffs, 'Visible', 'off');
    position = get(handles.uitablepayoffs, 'Position');
    set(handles.uitablepayoffs, 'Position', [position(1:3), 9]);
else
    set(handles.radiobuttonopenloop, 'Value', 1);
    set(handles.editperiods, 'String', GAME.periods);
    set(handles.editperiods, 'Enable', 'on');
	set(handles.uiopenlooppayoffs, 'Visible', 'on');
    position = get(handles.uitablepayoffs, 'Position');
    set(handles.uitablepayoffs, 'Position', [position(1:3), 8]);
end;

vartable = (struct2cell(GAME.variables{1}))';
set(handles.uitablevar, 'Data', vartable);

contable = (struct2cell(GAME.constants))';
set(handles.uitableconstants, 'Data', contable);

eqtable = (struct2cell(GAME.eqconstraints))';
eqtable = eqtable(:,1);
set(handles.uitableequal, 'Data', eqtable);

lesstable = (struct2cell(GAME.lessconstraints))';
lesstable = lesstable(:,1);
set(handles.uitableless, 'Data', lesstable);

functable = (struct2cell(GAME.customfunctions))';
functable = functable(:,[1,2]);
set(handles.uitablecustom, 'Data', functable);

paytable = (struct2cell(GAME.payoffs))';
paytable = paytable(:,1:5);
set(handles.uitablepayoffs, 'Data', paytable);

if GAME.type(2) == 0;
    set(handles.radiobuttonindividual, 'Value', 1);
    widths = {75,300,0,0,75};
else
    set(handles.radiobuttonsum, 'Value', 1);
    widths = {75,0,150,150,75};
end;
set(handles.uitablepayoffs, 'ColumnWidth', widths);

if GAME.accuracy(1) == 3;
	set(handles.radiobuttonautostep, 'Value', 1);
else
	set(handles.radiobuttonfixedstep, 'Value', 1);
    set(handles.editstepsize, 'String', GAME.accuracy(1));
    set(handles.editstepsize, 'Enable', 'on');
end

set(handles.editNI, 'String', GAME.accuracy(2));
set(handles.editdiff, 'String', GAME.accuracy(3));
set(handles.edittolcon, 'String', GAME.accuracy(4));
set(handles.edittolfun, 'String', GAME.accuracy(5));
set(handles.edittolx, 'String', GAME.accuracy(6));
set(handles.editmaxits, 'String', GAME.accuracy(7));

if isfield(GAME, 'socialwelfare')
    set(handles.editoptimum, 'String', GAME.socialwelfare.raw);
else
    set(handles.editoptimum, 'String', '');
end

if isfield(GAME, 'customsolution')
    set(handles.editcustom, 'String', GAME.customsolution);
else
    set(handles.editcustom, 'String', '');
end