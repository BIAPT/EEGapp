function varargout = Phase_Amplitude_Coupling(varargin)
% PHASE_AMPLITUDE_COUPLING MATLAB code for Phase_Amplitude_Coupling.fig
%      PHASE_AMPLITUDE_COUPLING, by itself, creates a new PHASE_AMPLITUDE_COUPLING or raises the existing
%      singleton*.
%
%      H = PHASE_AMPLITUDE_COUPLING returns the handle to a new PHASE_AMPLITUDE_COUPLING or the handle to
%      the existing singleton*.
%
%      PHASE_AMPLITUDE_COUPLING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHASE_AMPLITUDE_COUPLING.M with the given input arguments.
%
%      PHASE_AMPLITUDE_COUPLING('Property','Value',...) creates a new PHASE_AMPLITUDE_COUPLING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Phase_Amplitude_Coupling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Phase_Amplitude_Coupling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Phase_Amplitude_Coupling

% Last Modified by GUIDE v2.5 24-May-2017 12:28:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Phase_Amplitude_Coupling_OpeningFcn, ...
                   'gui_OutputFcn',  @Phase_Amplitude_Coupling_OutputFcn, ...
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


% --- Executes just before Phase_Amplitude_Coupling is made visible.
function Phase_Amplitude_Coupling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Phase_Amplitude_Coupling (see VARARGIN)

% Choose default command line output for Phase_Amplitude_Coupling
handles.output = hObject;

%Intialize a variable that will be used to test if all input are legal
assignin('base','all_good',0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Phase_Amplitude_Coupling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Phase_Amplitude_Coupling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Here we load an EEG structure file
fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file if more than one
end

%Get the input from the various checboxes or textfields
%and store them in variables

%Normal Options
channels = (str2num(get(findobj('Tag','chan'), 'String')))';
window_length = str2double(get(findobj('Tag','window_length'),'string'));
numberOfBin = str2double(get(findobj('Tag','numberOfBin'),'string'));
LFO_bp = str2num(get(findobj('Tag','LFO_bp'),'string'));
HFO_bp = str2num(get(findobj('Tag','HFO_bp'),'string'));

%Here we check if various properties of the input are respected
if length(channels) > EEG.nbchan
    textlabel = sprintf('Please make sure to input at most %.f channels',EEG.nbchan);    
    set(findobj('Tag','Output'), 'String',textlabel);
    return;
end

for i =1:length(channels)
   if channels(i,1) > EEG.nbchan || channels(i,1) < 1 
       textlabel = sprintf('Make sure the channel numbers are not greater than %.f or smaller than 1.',EEG.nbchan);
       set(findobj('Tag','Output'), 'String',textlabel);
       return
   end 
end

%Check if there is a min and max for LFO_bp
if size(LFO_bp,2) == 2 && isempty(LFO_bp) == 0
	LFO_ok = 1;
else
	LFO_ok = 0;
end

%Check if there is a min and max for HFO_bp
if size(HFO_bp,2) == 2 && isempty(HFO_bp) == 0
	HFO_ok = 1;
else
	HFO_ok = 0;
end



%Load the print and save variable
print_pac = get(findobj('Tag','print_pac'),'Value');
save_pac = get(findobj('Tag','save_pac'),'Value');


%Test for possible illegal inputs and output a warning
if isnan(window_length) || isnan(numberOfBin) ...
        || isempty(channels) || LFO_ok == 0 || HFO_ok == 0
	textLabel = sprintf('Please make sure all field are correctly filled');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif print_pac == 0 && save_pac == 0
    textLabel = sprintf('To continue, at least check the print or save checkbox');
    set(findobj('Tag','Output'), 'String',textLabel);
else
    
     pac_prp = struct('window_length',window_length,'numberOfBin',numberOfBin,...
    'channels',channels,'LFO_bp',LFO_bp,'HFO_bp',HFO_bp,'print',print_pac,'save',save_pac);
    assignin('base','pac_prp',pac_prp);
    
    textLabel = sprintf('All good!');
    set(findobj('Tag','Output'), 'String',textLabel);
    assignin('base', 'all_good', 1);
    close
end


function window_length_Callback(hObject, eventdata, handles)
% hObject    handle to window_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of window_length as text
%        str2double(get(hObject,'String')) returns contents of window_length as a double


% --- Executes during object creation, after setting all properties.
function window_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberOfBin_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfBin as text
%        str2double(get(hObject,'String')) returns contents of numberOfBin as a double


% --- Executes during object creation, after setting all properties.
function numberOfBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFO_bp_Callback(hObject, eventdata, handles)
% hObject    handle to LFO_bp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFO_bp as text
%        str2double(get(hObject,'String')) returns contents of LFO_bp as a double


% --- Executes during object creation, after setting all properties.
function LFO_bp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFO_bp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HFO_bp_Callback(hObject, eventdata, handles)
% hObject    handle to HFO_bp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HFO_bp as text
%        str2double(get(hObject,'String')) returns contents of HFO_bp as a double


% --- Executes during object creation, after setting all properties.
function HFO_bp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HFO_bp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in print_pac.
function print_pac_Callback(hObject, eventdata, handles)
% hObject    handle to print_pac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_pac


% --- Executes on button press in save_pac.
function save_pac_Callback(hObject, eventdata, handles)
% hObject    handle to save_pac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_pac



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



function chan_Callback(hObject, eventdata, handles)
% hObject    handle to chan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chan as text
%        str2double(get(hObject,'String')) returns contents of chan as a double


% --- Executes during object creation, after setting all properties.
function chan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

%When the figure close we check if the variable all_good was switched to 1
%If it was then the close request is not premature, else it is.
all_good = evalin('base','all_good');
if all_good == 1
    assignin('base', 'premature_close_pac', 0);
else
    assignin('base','premature_close_pac',1);
end

evalin('base', 'clear all_good');%The value is no longer needed so we remove it


delete(hObject);


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') 


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
font_size = evalin('base','font_size');

set(findobj('Tag','uipanel4'),'FontSize',font_size)
set(findobj('Tag','uipanel5'),'FontSize',font_size)
set(findobj('Tag','Output'),'FontSize',font_size)
set(findobj('Tag','done'),'FontSize',font_size)
set(findobj('Tag','text1'),'FontSize',font_size)
set(findobj('Tag','text7'),'FontSize',font_size)
set(findobj('Tag','text8'),'FontSize',font_size)
set(findobj('Tag','text9'),'FontSize',font_size)
set(findobj('Tag','text10'),'FontSize',font_size)
set(findobj('Tag','print_pac'),'FontSize',font_size)
set(findobj('Tag','save_pac'),'FontSize',font_size)
set(findobj('Tag','chan'),'FontSize',font_size)
set(findobj('Tag','window_length'),'FontSize',font_size)
set(findobj('Tag','numberOfBin'),'FontSize',font_size)
set(findobj('Tag','LFO_bp'),'FontSize',font_size)
set(findobj('Tag','HFO_bp'),'FontSize',font_size)
