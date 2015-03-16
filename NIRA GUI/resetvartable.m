function resetvartable(newplayer, handles)
% Resets the vartable to display a certain player's variables after
% uploading currently entered data to GAME

global GAME
global playerselected

% uploads currentdata to game
vardata =  get(handles.uitablevar, 'Data');
namecell = vardata(:,1);
symcell = vardata(:,2);
guesscell = vardata(:,3);
upcell = vardata(:,4);
lowcell = vardata(:,5);
updateplayer = struct('varname',namecell,'varsym',symcell,'guess',guesscell,'upper',upcell,'lower',lowcell);
GAME.variables{playerselected} = updateplayer;

newtable = (struct2cell(GAME.variables{newplayer}))';
set(handles.uitablevar, 'Data', newtable);
playerselected = get(handles.popupmenuvar, 'Value');

    