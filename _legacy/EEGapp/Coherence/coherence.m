function varargout = coherence(varargin)
% COHERENCE MATLAB code for coherence.fig
%      COHERENCE, by itself, creates a new COHERENCE or raises the existing
%      singleton*.
%
%      H = COHERENCE returns the handle to a new COHERENCE or the handle to
%      the existing singleton*.
%
%      COHERENCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COHERENCE.M with the given input arguments.
%
%      COHERENCE('Property','Value',...) creates a new COHERENCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coherence_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coherence_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coherence

% Last Modified by GUIDE v2.5 24-May-2017 12:11:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coherence_OpeningFcn, ...
                   'gui_OutputFcn',  @coherence_OutputFcn, ...
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


% --- Executes just before coherence is made visible.
function coherence_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coherence (see VARARGIN)

% Choose default command line output for coherence
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coherence wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coherence_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in continue_tag.
function continue_tag_Callback(hObject, eventdata, handles)
% hObject    handle to continue_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file
end

from = (str2num(get(findobj('Tag','from'), 'String')))';
to = (str2num(get(findobj('Tag','to'), 'String')))';

if length(from) > EEG.nbchan || length(to) > EEG.nbchan
    textlabel = sprintf('Please make sure to input at most %.f channels',EEG.nbchan);  
    set(findobj('Tag','Output'), 'String',textlabel);
    return;
end

%Checking in from channels for illegal values
for i =1:length(from)
   if from(i,1) > EEG.nbchan || from(i,1) < 1 
       textlabel = sprintf('Make sure the channel numbers are not greater than %.f or smaller than 1.',EEG.nbchan);  
       set(findobj('Tag','Output'), 'String',textlabel);
       return
   end
end

%Checking in to channels for illegal values
for i =1:length(to)
   if to(i,1) > EEG.nbchan || to(i,1) < 1 
       textlabel = sprintf('Make sure the channel numbers are not greater than %.f or smaller than 1.',EEG.nbchan);  
       set(findobj('Tag','Output'), 'String',textlabel);
       return
   end
end

%Load the print and save variable
print_coherence = get(findobj('Tag','print_coherence'),'Value');
save_coherence = get(findobj('Tag','save_coherence'),'Value');


%Load the bandpass
full_coherence = get(findobj('Tag','full_band'),'Value');
delta_coherence = get(findobj('Tag','delta_band'),'Value');
theta_coherence = get(findobj('Tag','theta_band'),'Value');
alpha_coherence = get(findobj('Tag','alpha_band'),'Value');
beta_coherence = get(findobj('Tag','beta_band'),'Value');
gamma_coherence = get(findobj('Tag','gamma_band'),'Value');


%Test for possible illegal inputs and output a warning
if isempty(from) || isempty(to)
	textLabel = sprintf('Please make sure all field are correctly filled.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif print_coherence == 0 && save_coherence == 0
    textLabel = sprintf('To continue, at least check the print or save checkbox');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif full_coherence == 0 && delta_coherence == 0 && theta_coherence == 0 && alpha_coherence == 0 ...
        && beta_coherence == 0 && gamma_coherence == 0
    textLabel = sprintf('To continue, please select at least one of the bandpass for the filtering.');
    set(findobj('Tag','Output'), 'String',textLabel);
else
    
    textLabel = sprintf('All good!');
    set(findobj('Tag','Output'), 'String',textLabel);
    assignin('base', 'all_good', 1);
    
     coherence_prp = struct('source',from,'sink',to,...
    'full',full_coherence,'delta',delta_coherence,...
    'theta',theta_coherence,'alpha',alpha_coherence,...
    'beta',beta_coherence,'gamma',gamma_coherence,...
    'print',print_coherence,'save',save_coherence);
    assignin('base','coherence_prp',coherence_prp);

    close;
 end

% --- Executes on button press in full_band.
function full_band_Callback(hObject, eventdata, handles)
% hObject    handle to full_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of full_band


% --- Executes on button press in theta_band.
function theta_band_Callback(hObject, eventdata, handles)
% hObject    handle to theta_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of theta_band


% --- Executes on button press in delta_band.
function delta_band_Callback(hObject, eventdata, handles)
% hObject    handle to delta_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delta_band


% --- Executes on button press in gamma_band.
function gamma_band_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gamma_band


% --- Executes on button press in alpha_band.
function alpha_band_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alpha_band


% --- Executes on button press in beta_band.
function beta_band_Callback(hObject, eventdata, handles)
% hObject    handle to beta_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of beta_band


% --- Executes on button press in print_coherence.
function print_coherence_Callback(hObject, eventdata, handles)
% hObject    handle to print_coherence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_coherence


% --- Executes on button press in save_coherence.
function save_coherence_Callback(hObject, eventdata, handles)
% hObject    handle to save_coherence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_coherence



function from_Callback(hObject, eventdata, handles)
% hObject    handle to from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of from as text
%        str2double(get(hObject,'String')) returns contents of from as a double


% --- Executes during object creation, after setting all properties.
function from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_Callback(hObject, eventdata, handles)
% hObject    handle to to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to as text
%        str2double(get(hObject,'String')) returns contents of to as a double


% --- Executes during object creation, after setting all properties.
function to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
assignin('base','all_good',0);
font_size = evalin('base','font_size');

set(findobj('Tag','uipanel1'),'FontSize',font_size)
set(findobj('Tag','uipanel2'),'FontSize',font_size)
set(findobj('Tag','uipanel3'),'FontSize',font_size)
set(findobj('Tag','text2'),'FontSize',font_size)
set(findobj('Tag','text3'),'FontSize',font_size)
set(findobj('Tag','text5'),'FontSize',font_size)
set(findobj('Tag','from'),'FontSize',font_size)
set(findobj('Tag','to'),'FontSize',font_size)
set(findobj('Tag','print_coherence'),'FontSize',font_size)
set(findobj('Tag','save_coherence'),'FontSize',font_size)
set(findobj('Tag','full_band'),'FontSize',font_size)
set(findobj('Tag','alpha_band'),'FontSize',font_size)
set(findobj('Tag','beta_band'),'FontSize',font_size)
set(findobj('Tag','delta_band'),'FontSize',font_size)
set(findobj('Tag','theta_band'),'FontSize',font_size)
set(findobj('Tag','gamma_band'),'FontSize',font_size)
set(findobj('Tag','Output'),'FontSize',font_size)
set(findobj('Tag','continue_tag'),'FontSize',font_size)




% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
all_good = evalin('base','all_good');
if all_good == 1
    assignin('base', 'premature_close_coherence', 0);
else
    assignin('base','premature_close_coherence',1);
end

evalin('base', 'clear all_good');%The value is no longer needed so we remove it
delete(hObject);


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') % This will need to change when the documentation will be done
