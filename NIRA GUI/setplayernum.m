function setplayernum(handles, playernum)
% Does things with the player number box is changed

global GAME;

% sets the list of players under variables
playerlist=[];
for n = 1:playernum;
  	playerlist=[playerlist,n];
end
set(handles.popupmenuvar, 'String', playerlist);
       
% make the current selection of the list back to 1
set(handles.popupmenuvar, 'Value', 1.0 );
resetvartable(1, handles);
    
% resizes the GAME.variables cell array
oldvar = GAME.variables;
newvar = {};
for n = 1:playernum;
	if length(oldvar) >= n;
        newvar{n}=oldvar{n};
    else
    	newvar{n} = struct('varname','','varsym','','guess',NaN,'upper',NaN,'lower',NaN);
	end
end
GAME.variables = newvar;
        
% changes the pay-offs box so that it has the correct number of players
oldpayoffs = get(handles.uitablepayoffs, 'Data');
oldheight = size(oldpayoffs,1);
if oldheight > playernum;
	newpayoffs = oldpayoffs(1:playernum,:);
elseif  oldheight < playernum;
	novelplayersnum = playernum - oldheight;
    newestplayer = oldheight + 1;
    novelplayers = {newestplayer};
    novelpayoffs = {''};
    novelscraps = {''};
    novelstage = {''};
    novelweights = {1};
    for n = 1:(novelplayersnum-1);
    	newestplayer = newestplayer + 1;
        novelplayers = [novelplayers(:,1); newestplayer];
    	novelpayoffs = [novelpayoffs(:,1);' '];
    	novelscraps = [novelscraps(:,1);' '];
    	novelstage = [novelstage(:,1);' '];
    	novelweights = [novelweights(:,1);1];
    end
	novel = [novelplayers, novelpayoffs, novelscraps, novelstage, novelweights];
    newpayoffs = [oldpayoffs;novel];
else    
	newpayoffs = oldpayoffs;
end
set (handles.uitablepayoffs, 'Data', newpayoffs);

GAME.numplayers = playernum;