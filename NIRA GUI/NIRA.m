function varargout = NIRA(varargin)
% NIRA MATLAB code for NIRA.fig
%      NIRA, by itself, creates a new NIRA or raises the existing
%      singleton*.
%
%      H = NIRA returns the handle to a new NIRA or the handle to
%      the existing singleton*.
%
%      NIRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRA.M with the given input arguments.
%
%      NIRA('Property','Value',...) creates a new NIRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRA

% Last Modified by GUIDE v2.5 10-May-2013 19:04:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRA_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NIRA is made visible.
function NIRA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRA (see VARARGIN)

% Choose default command line output for NIRA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Define global variable, loading from the default river game, and checking
% if the default is not corrupted

global GAME;

load('default');

populate(handles);



% UIWAIT makes NIRA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




function editname_Callback(hObject, eventdata, handles)
% hObject    handle to editname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editname as text
%        str2double(get(hObject,'String')) returns contents of editname as a double


% --- Executes during object creation, after setting all properties.
function editname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edittolcon_Callback(hObject, eventdata, handles)
% hObject    handle to edittolcon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edittolcon as text
%        str2double(get(hObject,'String')) returns contents of edittolcon as a double


% --- Executes during object creation, after setting all properties.
function edittolcon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittolcon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edittolfun_Callback(hObject, eventdata, handles)
% hObject    handle to edittolfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edittolfun as text
%        str2double(get(hObject,'String')) returns contents of edittolfun as a double


% --- Executes during object creation, after setting all properties.
function edittolfun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittolfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edittolx_Callback(hObject, eventdata, handles)
% hObject    handle to edittolx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edittolx as text
%        str2double(get(hObject,'String')) returns contents of edittolx as a double


% --- Executes during object creation, after setting all properties.
function edittolx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittolx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editNI_Callback(hObject, eventdata, handles)
% hObject    handle to editNI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNI as text
%        str2double(get(hObject,'String')) returns contents of editNI as a double


% --- Executes during object creation, after setting all properties.
function editNI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editdiff_Callback(hObject, eventdata, handles)
% hObject    handle to editdiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdiff as text
%        str2double(get(hObject,'String')) returns contents of editdiff as a double


% --- Executes during object creation, after setting all properties.
function editdiff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editnumber_Callback(hObject, eventdata, handles)
% hObject    handle to editnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Does things with the player number box is changed

% Get number of players
playernum = str2double(get(hObject,'String'));

% checks if string is integer > 0
if checkint(playernum);
    setplayernum(handles, playernum);
else 
    msgbox('The number of players must be an integer greater than zero.')
end

% Hints: get(hObject,'String') returns contents of editnumber as text
%        str2double(get(hObject,'String')) returns contents of editnumber as a double


% --- Executes during object creation, after setting all properties.
function editnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editstepsize_Callback(hObject, eventdata, handles)
% hObject    handle to editstepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editstepsize as text
%        str2double(get(hObject,'String')) returns contents of editstepsize as a double


% --- Executes during object creation, after setting all properties.
function editstepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editstepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuplayselectvar.
function popupmenuplayselectvar_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuplayselectvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuplayselectvar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuplayselectvar


% --- Executes during object creation, after setting all properties.
function popupmenuplayselectvar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuplayselectvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuvar.
function popupmenuvar_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GAME;
newplayer = get(hObject,'Value');
resetvartable(newplayer, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuvar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuvar




% --- Executes during object creation, after setting all properties.
function popupmenuvar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonaddequal.
function pushbuttonaddequal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonaddequal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% adds an empty line to the equal constraints table
olddata = get(handles.uitableequal, 'Data');
newline = {' '};
newdata = [olddata;newline];
set (handles.uitableequal, 'Data', newdata);


% --- Executes on button press in pushbuttondeleteequal.
function pushbuttondeleteequal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondeleteequal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deletes the last line of the equal constraints table
olddata = get(handles.uitableequal, 'Data');
newheight = size(olddata,1) - 1;
newdata = {};
newdata = olddata(1:newheight,:);
set (handles.uitableequal, 'Data', newdata);

% --- Executes on button press in pushbuttonaddless.
function pushbuttonaddless_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonaddless (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% adds an empty line to the less constraints table
olddata = get(handles.uitableless, 'Data');
newline = {' '};
newdata = [olddata;newline];
set (handles.uitableless, 'Data', newdata);


% --- Executes on button press in pushbuttondeleteless.
function pushbuttondeleteless_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondeleteless (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deletes the last line of the less constraints table
olddata = get(handles.uitableless, 'Data');
newheight = size(olddata,1) - 1;
newdata = {};
newdata = olddata(1:newheight,:);
set (handles.uitableless, 'Data', newdata);



function editperiods_Callback(hObject, eventdata, handles)
% hObject    handle to editperiods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editperiods as text
%        str2double(get(hObject,'String')) returns contents of editperiods as a double


% --- Executes during object creation, after setting all properties.
function editperiods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editperiods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonaddvar.
function pushbuttonaddvar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonaddvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% adds an empty line to the variables table
olddata = get(handles.uitablevar, 'Data');
newline = {' ',' ',[],[],[]};
newdata = [olddata;newline];
set (handles.uitablevar, 'Data', newdata);

% --- Executes on button press in pushbuttondeletevar.
function pushbuttondeletevar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondeletevar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deletes the last line of the variables table
olddata = get(handles.uitablevar, 'Data');
newheight = size(olddata,1) - 1;
newdata = {};
newdata = olddata(1:newheight,:);
set (handles.uitablevar, 'Data', newdata);

% --- Executes on button press in pushbuttonaddconstants.
function pushbuttonaddconstants_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonaddconstants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% adds an empty line to the constants table
olddata = get(handles.uitableconstants, 'Data');
newline = {' ',' ',''};
newdata = [olddata;newline];
set (handles.uitableconstants, 'Data', newdata);

% --- Executes on button press in pushbuttondeleteconstants.
function pushbuttondeleteconstants_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondeleteconstants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deletes the last line of the constants table
olddata = get(handles.uitableconstants, 'Data');
newheight = size(olddata,1) - 1;
newdata = {};
newdata = olddata(1:newheight,:);
set (handles.uitableconstants, 'Data', newdata);

% --- Executes when selected object is changed in uigametype.
function uigametype_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uigametype 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% enable the editperiods textbox if the game is openloop, disable it otherwise
if hObject == handles.radiobuttonstatic;
	set(handles.editperiods, 'Enable', 'off');
	set(handles.uiopenlooppayoffs, 'Visible', 'off');
    position = get(handles.uitablepayoffs, 'Position');
    set(handles.uitablepayoffs, 'Position', [position(1:3), 9]);
    widths = {75,300,0,0,75};
    set(handles.uitablepayoffs, 'ColumnWidth', widths);
    set(handles.radiobuttonindividual, 'Value', 1);
elseif hObject == handles.radiobuttonopenloop;
    set(handles.editperiods, 'Enable', 'on');
	set(handles.uiopenlooppayoffs, 'Visible', 'on');
    position = get(handles.uitablepayoffs, 'Position');
    set(handles.uitablepayoffs, 'Position', [position(1:3), 8]);
end;


% --- Executes on button press in pushbuttonloadtostruct.
function pushbuttonloadtostruct_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonloadtostruct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttoncheckstruct.
function pushbuttoncheckstruct_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncheckstruct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GAME;
checkvalid (GAME);


% --- Executes on button press in pushbuttonsavestruct.
function pushbuttonsavestruct_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonsavestruct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in radiobuttonfixedstep.
function uistepsize_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radiobuttonfixedstep 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%enable the editstepsize textbox if the game has a fixed stepsize, disable it otherwise
if hObject == handles.radiobuttonautostep;
    set(handles.editstepsize, 'Enable', 'off');
elseif hObject == handles.radiobuttonfixedstep;
    set(handles.editstepsize, 'Enable', 'on');
end;


% --- Executes during object creation, after setting all properties.
function pushbuttonloadtostruct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbuttonloadtostruct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function editmaxits_Callback(hObject, eventdata, handles)
% hObject    handle to editmaxits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editmaxits as text
%        str2double(get(hObject,'String')) returns contents of editmaxits as a double


% --- Executes during object creation, after setting all properties.
function editmaxits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editmaxits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonNIRA.
function pushbuttonNIRA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonNIRA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GAME

working;
loadtostruct(handles);

arrays = checkarray({GAME.constants.value}); % this refers to which constants have arrays entered

% if doesn't contain arrays
if isempty(arrays)
    simplifystruct();
    [variables, c, constraints, exitflag, t, customfunctions] = solveNIRA();
    output.vectorinput = [];
    output.playervariables = variables;
    output.payoffs = c;
    output.constraints = constraints;
    output.exitflag = exitflag;
    output.customfunctions = customfunctions;
    output.time = t;
% if it does contain arrays
else
    constants = permutationcellarray({GAME.constants.value});
    output = cellfun(@NIRAvector,constants);
end
results(output, 'CCNE');
close(working);

% --- Executes when entered data in editable cell(s) in uitableequal.
function uitableequal_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitableequal (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbuttonoptimum.
function pushbuttonoptimum_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonoptimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global GAME

working;
loadtostruct(handles);
arrays = checkarray({GAME.constants.value}); % this refers to which constants have arrays entered

% if doesn't contain arrays
if isempty(arrays)
    simplifystruct();
    [variables, c, constraints, exitflag, t, customfunctions] = utilitarian();
    output.vectorinput = [];
    output.playervariables = variables;
    output.payoffs = c;
    output.constraints = constraints;
    output.exitflag = exitflag;
    output.customfunctions = customfunctions;
    output.time = t;
% if it does contain arrays
else
    constants = permutationcellarray({GAME.constants.value});
    output = cellfun(@utilitarianvector,constants);
    assignin('base', 'Output', output);
end
results(output, 'WelfareMax');
close(working);


function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function new_menu_Callback(hObject, eventdata, handles)
% hObject    handle to new_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get the pathname


load('blank');
populate(handles)

% --------------------------------------------------------------------
function open_menu_Callback(hObject, eventdata, handles)
% hObject    handle to open_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get the pathname
[filename, pathname] = uigetfile( {'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
    
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
    return
    
% Otherwise construct the fullfilename and load the file.
else
    File = fullfile(pathname,filename);
    if (exist(File,'file') == 2)
        % Load the file if it exists.
        load(File);
        populate(handles)
    else
        msgbox(['Could not find file: ', File]);
    end
end




% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GAME;

loadtostruct(handles);

% Select the file name to save to
[filename, pathname] = uiputfile({'*.mat';'*.*'},'Save as');
    
% If 'Cancel' was selected then return
if isequal([filename,pathname],[0,0])
        return;
else
    % else add '.mat' to the end, if necessary 
    if (~strcmp(filename(end-3:end), '.mat'))
        filename = [filename, '.mat'];
    end

	% Construct the full path and save (catching any errors)
    file = fullfile(pathname,filename);
	try
        save(file,'GAME');
    catch error
        msgbox(['Could not save ', filename, ': ', error.message]);
	end
    
end



% --------------------------------------------------------------------
function close_menu_Callback(hObject, eventdata, handles)
% hObject    handle to close_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(NIRA)


% --- Executes when selected object is changed in uiopenlooppayoffs.
function uiopenlooppayoffs_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uiopenlooppayoffs 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

if eventdata.NewValue == handles.radiobuttonindividual
    widths = {75,300,0,0,75};
else
    widths = {75,0,150,150,75};
end
set(handles.uitablepayoffs, 'ColumnWidth', widths);


% --- Executes on button press in pushbuttonaddcustom.
function pushbuttonaddcustom_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonaddcustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% adds an empty line to the custom functions table
olddata = get(handles.uitablecustom, 'Data');
newline = {' ',' '};
newdata = [olddata;newline];
set (handles.uitablecustom, 'Data', newdata);


% --- Executes on button press in pushbuttondeletecustom.
function pushbuttondeletecustom_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondeletecustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deletes the last line of the custom functions table
olddata = get(handles.uitablecustom, 'Data');
newheight = size(olddata,1) - 1;
newdata = olddata(1:newheight,:);
set (handles.uitablecustom, 'Data', newdata);


% --- Executes on button press in pushbuttoncustom.
function pushbuttoncustom_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GAME
working; % bring up the 'working' dialog box
loadtostruct(handles); % load variables
if ~isempty(checkarray({GAME.constants.value})); % checks if any of the constants are arrays
    errordlg('You cannot have constants as arrays when you are using the custom solution.');
    close(working); 
    return
end
simplifystruct(); % simplify variables
% concatenate all lines of the box, adding a semicolon to the end of each
% box is that doesn't already exist
customsolution = '';
for n = 1:size(GAME.customsolution, 1)
    thisline = GAME.customsolution(n,:);
    if ~(thisline(end) == ';'); thisline(end+1) = ';'; end;
    customsolution = [customsolution, thisline];
end
eval(customsolution); % evaluate that concatenation
close(working); % close the working dialogue box




function editcustom_Callback(hObject, eventdata, handles)
% hObject    handle to editcustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editcustom as text
%        str2double(get(hObject,'String')) returns contents of editcustom as a double


% --- Executes during object creation, after setting all properties.
function editcustom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editcustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editoptimum_Callback(hObject, eventdata, handles)
% hObject    handle to editoptimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editoptimum as text
%        str2double(get(hObject,'String')) returns contents of editoptimum as a double


% --- Executes during object creation, after setting all properties.
function editoptimum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editoptimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitableconstants.
function uitableconstants_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitableconstants (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

if ~(eventdata.Indices(2) == 3)
    return
end

newdata = eventdata.EditData;
if isempty(str2num(newdata));
    olddata = get(hObject, 'Data');
    olddata(eventdata.Indices(1),eventdata.Indices(2)) = {'NaN'};
    set(hObject, 'Data', olddata);    
end
