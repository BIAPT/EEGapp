function varargout = loadWindow(varargin)
% LOADWINDOW MATLAB code for loadWindow.fig
%      LOADWINDOW, by itself, creates a new LOADWINDOW or raises the existing
%      singleton*.
%
%      H = LOADWINDOW returns the handle to a new LOADWINDOW or the handle to
%      the existing singleton*.
%
%      LOADWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOADWINDOW.M with the given input arguments.
%
%      LOADWINDOW('Property','Value',...) creates a new LOADWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before loadWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to loadWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help loadWindow

% Last Modified by GUIDE v2.5 16-Feb-2017 21:21:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @loadWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @loadWindow_OutputFcn, ...
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


% --- Executes just before loadWindow is made visible.
function loadWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to loadWindow (see VARARGIN)

% Choose default command line output for loadWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes loadWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = loadWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base','continue_load',1)
close();

% --- Executes on button press in abort.
function abort_Callback(hObject, eventdata, handles)
% hObject    handle to abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base','continue_load',0)
close();

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileNameLoad = evalin('base','fileName');

currentPosition = evalin('base','currentPosition');
numberOfEEG = evalin('base','numberOfEEG');
currentPosition = currentPosition + 1;
if(currentPosition == numberOfEEG)
    set(findobj('Tag','next'),'Visible','Off');
    set(findobj('Tag','previous'),'Visible','On');
else
    set(findobj('Tag','previous'),'Visible','On'); 
end
assignin('base','currentPosition',currentPosition);

if(numberOfEEG > 1)
    sets_data = evalin('base','sets_data');
    EEG = sets_data{currentPosition};
    set(findobj('Tag','filename'),'String',EEG.filename); 
    set(findobj('Tag','setname'),'String',EEG.setname); 
    set(findobj('Tag','nbchan'),'String',sprintf('%.0f Channels',EEG.nbchan)); 
    set(findobj('Tag','srate'),'String',sprintf('%.0fHz',EEG.srate)); 
    set(findobj('Tag','length'),'String',sprintf('%.0fsec',EEG.xmax - EEG.xmin)); 
end

% --- Executes on button press in previous.
function previous_Callback(hObject, eventdata, handles)
% hObject    handle to previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileNameLoad = evalin('base','fileName');

currentPosition = evalin('base','currentPosition');
numberOfEEG = evalin('base','numberOfEEG');
currentPosition = currentPosition - 1;
if(currentPosition == 1)
    set(findobj('Tag','previous'),'Visible','Off'); 
    set(findobj('Tag','next'),'Visible','On');
else
    set(findobj('Tag','next'),'Visible','On'); 
end
assignin('base','currentPosition',currentPosition);

if(numberOfEEG > 1)
    sets_data = evalin('base','sets_data');
    EEG = sets_data{currentPosition};
    set(findobj('Tag','filename'),'String',EEG.filename); 
    set(findobj('Tag','setname'),'String',EEG.setname); 
    set(findobj('Tag','nbchan'),'String',sprintf('%.0f Channels',EEG.nbchan)); 
    set(findobj('Tag','srate'),'String',sprintf('%.0fHz',EEG.srate)); 
    set(findobj('Tag','length'),'String',sprintf('%.0fsec',EEG.xmax - EEG.xmin)); 
end

% --- Executes during object deletion, before destroying properties.
function next_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
evalin('base','clear currentPosition');
delete(hObject);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
currentPosition = 1;
assignin('base','currentPosition',currentPosition);
numberOfEEG = evalin('base','numberOfEEG');
if(numberOfEEG > 1)
    set(findobj('Tag','next'),'Visible','On'); 
end
movegui(hObject,'center');

%Set the parameters for the first EEG
if(numberOfEEG > 1)
   %More than one EEG 
    fileNameLoad = evalin('base','fileName');
else
   %Only one EEG we will load the first one
    fileName = evalin('base','fileName');
end
    sets_data = evalin('base','sets_data');
    EEG = sets_data{1};
    set(findobj('Tag','filename'),'String',EEG.filename); 
    set(findobj('Tag','setname'),'String',EEG.setname); 
    set(findobj('Tag','nbchan'),'String',sprintf('%.0f Channels',EEG.nbchan)); 
    set(findobj('Tag','srate'),'String',sprintf('%.0fHz',EEG.srate)); 
    set(findobj('Tag','length'),'String',sprintf('%.0fsec',EEG.xmax - EEG.xmin)); 
    
    
font_size = evalin('base','font_size');

set(findobj('Tag','uipanel1'),'FontSize',font_size)
set(findobj('Tag','text3'),'FontSize',font_size)
set(findobj('Tag','text4'),'FontSize',font_size)
set(findobj('Tag','text5'),'FontSize',font_size)
set(findobj('Tag','text6'),'FontSize',font_size)
set(findobj('Tag','setname'),'FontSize',font_size)
set(findobj('Tag','nbchan'),'FontSize',font_size)
set(findobj('Tag','srate'),'FontSize',font_size)
set(findobj('Tag','length'),'FontSize',font_size)
set(findobj('Tag','filename'),'FontSize',font_size)
set(findobj('Tag','previous'),'FontSize',font_size)
set(findobj('Tag','save'),'FontSize',font_size)
set(findobj('Tag','abort'),'FontSize',font_size)
set(findobj('Tag','next'),'FontSize',font_size)