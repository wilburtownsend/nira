function varargout = results(varargin)
% RESULTS MATLAB code for results.fig
%      RESULTS, by itself, creates a new RESULTS or raises the existing
%      singleton*.
%
%      H = RESULTS returns the handle to a new RESULTS or the handle to
%      the existing singleton*.
%
%      RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTS.M with the given input arguments.
%
%      RESULTS('Property','Value',...) creates a new RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help results

% Last Modified by GUIDE v2.5 14-Jun-2013 17:57:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @results_OpeningFcn, ...
                   'gui_OutputFcn',  @results_OutputFcn, ...
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


% --- Executes just before results is made visible.
function results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to results (see VARARGIN)

% Choose default command line output for results
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes results wait for user response (see UIRESUME)
% uiwait(handles.figureresults);

if isempty(varargin)
    return
end

% declare equilibrium variables
output = varargin{1};
solutiontype =  varargin{2};

% populate the results GUI, with the first result (if vector(s) were
% entered)
populateoutput(output, 1, solutiontype, handles);

% create the list of vectors
if (length (output) == 1);
    set(handles.textvectorinput, 'visible', 'off');
    set(handles.popupmenuvectorinput, 'visible', 'off');
else
    set(handles.textvectorinput, 'visible', 'on');
    set(handles.popupmenuvectorinput, 'visible', 'on');
    popdown = {output(:).vectorinput}';
	for n = 1:length(popdown);
        popdown{n} = num2str(popdown{n});
    end
    set(handles.popupmenuvectorinput, 'String', popdown);
end

%%
% --- Outputs from this function are returned to the command line.
function varargout = results_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonlog.
function pushbuttonlog_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
logdisplay();



% --- Executes on button press in pushbuttonstaticsolutions.
function pushbuttonstaticsolutions_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonstaticsolutions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

plotstatic(handles);


% --- Executes on button press in pushbuttondynamicsolutions.
function pushbuttondynamicsolutions_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondynamicsolutions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editplayerpayoff_Callback(hObject, eventdata, handles)
% hObject    handle to editplayerpayoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editplayerpayoff as text
%        str2double(get(hObject,'String')) returns contents of editplayerpayoff as a double


% --- Executes during object creation, after setting all properties.
function editplayerpayoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editplayerpayoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonplotpayoffs.
function pushbuttonplotpayoffs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonplotpayoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotpayoffs(handles);


% --- Executes on selection change in popupmenuplayerselect.
function popupmenuplayerselect_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuplayerselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuplayerselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuplayerselect


% --- Executes during object creation, after setting all properties.
function popupmenuplayerselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuplayerselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figureresults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figureresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbuttonexport.
function pushbuttonexport_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonexport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base', 'Output', handles.output); 


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenustaticxplayer.
function popupmenustaticxplayer_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenustaticxplayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenustaticxplayer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenustaticxplayer


% --- Executes during object creation, after setting all properties.
function popupmenustaticxplayer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenustaticxplayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenustaticyplayer.
function popupmenustaticyplayer_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenustaticyplayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenustaticyplayer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenustaticyplayer


% --- Executes during object creation, after setting all properties.
function popupmenustaticyplayer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenustaticyplayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenustaticzplayer.
function popupmenustaticzplayer_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenustaticzplayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenustaticzplayer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenustaticzplayer


% --- Executes during object creation, after setting all properties.
function popupmenustaticzplayer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenustaticzplayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuXaxispayoffs.
function popupmenuXaxispayoffs_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuXaxispayoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuXaxispayoffs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuXaxispayoffs


% --- Executes during object creation, after setting all properties.
function popupmenuXaxispayoffs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuXaxispayoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuYaxispayoffs.
function popupmenuYaxispayoffs_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuYaxispayoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuYaxispayoffs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuYaxispayoffs


% --- Executes during object creation, after setting all properties.
function popupmenuYaxispayoffs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuYaxispayoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuvectorinput.
function popupmenuvectorinput_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuvectorinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuvectorinput contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuvectorinput

populateoutput(handles.output, get(hObject,'Value'), handles.solutiontype, handles)

% --- Executes during object creation, after setting all properties.
function popupmenuvectorinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuvectorinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
