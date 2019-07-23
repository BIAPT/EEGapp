function varargout = symbolicTransferEntropy(varargin)
% SYMBOLICTRANSFERENTROPY MATLAB code for symbolicTransferEntropy.fig
%      SYMBOLICTRANSFERENTROPY, by itself, creates a new SYMBOLICTRANSFERENTROPY or raises the existing
%      singleton*.
%
%      H = SYMBOLICTRANSFERENTROPY returns the handle to a new SYMBOLICTRANSFERENTROPY or the handle to
%      the existing singleton*.
%
%      SYMBOLICTRANSFERENTROPY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SYMBOLICTRANSFERENTROPY.M with the given input arguments.
%
%      SYMBOLICTRANSFERENTROPY('Property','Value',...) creates a new SYMBOLICTRANSFERENTROPY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before symbolicTransferEntropy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to symbolicTransferEntropy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help symbolicTransferEntropy

% Last Modified by GUIDE v2.5 13-Apr-2017 21:21:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @symbolicTransferEntropy_OpeningFcn, ...
                   'gui_OutputFcn',  @symbolicTransferEntropy_OutputFcn, ...
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


% --- Executes just before symbolicTransferEntropy is made visible.
function symbolicTransferEntropy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to symbolicTransferEntropy (see VARARGIN)

% Choose default command line output for symbolicTransferEntropy
handles.output = hObject;

%Intialize a variable that will be used to test if all input are legal
assignin('base','all_good',0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes symbolicTransferEntropy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = symbolicTransferEntropy_OutputFcn(hObject, eventdata, handles) 
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
winsize = str2double(get(findobj('Tag','winsize'),'string'));
numberwin = str2double(get(findobj('Tag','numberWin'),'string'));
fromChan = (str2num(get(findobj('Tag','fromChan'), 'String')))';
toChan = (str2num(get(findobj('Tag','toChan'), 'String')))';

%Advanced Options
dim = str2double(get(findobj('Tag','dim'),'string'));
tau = (str2num(get(findobj('Tag','tau'), 'String')))';

%NEED TO SAFE CHECK TAU TO CHAN AND FORCHAN (TODO)

%Here we check if various properties of the input are respected
if length(fromChan) > EEG.nbchan
    textlabel = sprintf('Please make sure to input at most %.f channels as source channels.',EEG.nbchan);
    set(findobj('Tag','Output'), 'String',textlabel);
    return;
end

if length(toChan) > EEG.nbchan
    textlabel = sprintf('Please make sure to input at most %.f channels as sink channels.',EEG.nbchan);  
    set(findobj('Tag','Output'), 'String',textlabel);
    return;
end

for i =1:length(fromChan)
   if fromChan(i,1) > EEG.nbchan || fromChan(i,1) < 1 
       textlabel = sprintf('Make sure the source channels are not greater than %.f or smaller than 1.',EEG.nbchan);  
       set(findobj('Tag','Output'), 'String',textlabel);
       return
   end 
end

for i =1:length(toChan)
   if toChan(i,1) > EEG.nbchan || toChan(i,1) < 1 
       textlabel = sprintf('Make sure the sink channels are not greater than %.f or smaller than 1.',EEG.nbchan);   
       set(findobj('Tag','Output'), 'String',textlabel);
       return
   end 
end

%Load the print and save variable
print_ste = get(findobj('Tag','print_ste'),'Value');
save_ste = get(findobj('Tag','save_ste'),'Value');


%Load the bandpass
full_ste = get(findobj('Tag','full_ste'),'Value');
delta_ste = get(findobj('Tag','delta_ste'),'Value');
theta_ste = get(findobj('Tag','theta_ste'),'Value');
alpha_ste = get(findobj('Tag','alpha_ste'),'Value');
beta_ste = get(findobj('Tag','beta_ste'),'Value');
gamma_ste = get(findobj('Tag','gamma_ste'),'Value');

%Test for possible illegal inputs and output a warning
if isnan(winsize) || isnan(numberwin) || isnan(dim)...
        || isempty(fromChan) || isempty(toChan) || isempty(tau)
	textLabel = sprintf('Please make sure all field are correctly filled');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif print_ste == 0 && save_ste == 0
    textLabel = sprintf('To continue, at least check the print or save checkbox');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif full_ste == 0 && delta_ste == 0 && theta_ste == 0 && alpha_ste == 0 ...
        && beta_ste == 0 && gamma_ste == 0
    textLabel = sprintf('Please select at least one of the bandpass for the filtering.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif numberwin > ((EEG.xmax - EEG.xmin) / winsize)
    textLabel = sprintf('Please select the number of window and the size of the windows so as to not exceed numberwindow*windows_size = %.f sec',(EEG.xmax - EEG.xmin));
    set(findobj('Tag','Output'), 'String',textLabel);
else

    
    ste_prp = struct('winsize',winsize,'numberwin',numberwin,'fromchan',fromChan,...
   'tochan',toChan,'dim',dim,'tau',tau,'print',print_ste,'save',save_ste,...
   'full',full_ste,'delta',delta_ste,'theta',theta_ste,'alpha',alpha_ste,...
   'beta',beta_ste,'gamma',gamma_ste);
   assignin('base','ste_prp',ste_prp);
    
    textLabel = sprintf('All good!');
    set(findobj('Tag','Output'), 'String',textLabel);
    assignin('base', 'all_good', 1);
    close
 end



% --- Executes on button press in advancedOptions.
function advancedOptions_Callback(hObject, eventdata, handles)
% hObject    handle to advancedOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Here we toggle the Advanced options button and make some field disapear
%or appear.
value = get(findobj('Tag','advancedOptions'),'string');
if strcmp(value,'Advanced Options') == 1 
    %If the button was written Avanced Option then we show the advanced
    %options
    set(findobj('Tag','advancedOptions'),'String','See Less');
    set(findobj('Tag','advancedOptions'),'Position',[4.4 2.692 47.2 1.923]);  
    
    %dim_tag
    set(findobj('Tag','dim_tag'),'Visible','On');
    %dim
    set(findobj('Tag','dim'),'Visible','On');
    
    %tau_tag
    set(findobj('Tag','tau_tag'),'Visible','On');
    %tau
    set(findobj('Tag','tau'),'Visible','On');
else
    %Otherwise we hide the advanced options    
    set(findobj('Tag','advancedOptions'),'String','Advanced Options');
    set(findobj('Tag','advancedOptions'),'Position',[4.4 7.308 47.2 1.923]);

    %dim_tag
    set(findobj('Tag','dim_tag'),'Visible','Off');
    %dim
    set(findobj('Tag','dim'),'Visible','Off');

    %tau_tag
    set(findobj('Tag','tau_tag'),'Visible','Off');
    %tau
    set(findobj('Tag','tau'),'Visible','Off');    
end

% --- Executes on button press in full_ste.
function full_ste_Callback(hObject, eventdata, handles)
% hObject    handle to full_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of full_ste


% --- Executes on button press in theta_ste.
function theta_ste_Callback(hObject, eventdata, handles)
% hObject    handle to theta_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of theta_ste


% --- Executes on button press in delta_ste.
function delta_ste_Callback(hObject, eventdata, handles)
% hObject    handle to delta_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delta_ste


% --- Executes on button press in gamma_ste.
function gamma_ste_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gamma_ste


% --- Executes on button press in alpha_ste.
function alpha_ste_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alpha_ste


% --- Executes on button press in beta_ste.
function beta_ste_Callback(hObject, eventdata, handles)
% hObject    handle to beta_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of beta_ste



function winsize_Callback(hObject, eventdata, handles)
% hObject    handle to winsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of winsize as text
%        str2double(get(hObject,'String')) returns contents of winsize as a double


% --- Executes during object creation, after setting all properties.
function winsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberWin_Callback(hObject, eventdata, handles)
% hObject    handle to numberWin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberWin as text
%        str2double(get(hObject,'String')) returns contents of numberWin as a double


% --- Executes during object creation, after setting all properties.
function numberWin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberWin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fromChan_Callback(hObject, eventdata, handles)
% hObject    handle to fromChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromChan as text
%        str2double(get(hObject,'String')) returns contents of fromChan as a double


% --- Executes during object creation, after setting all properties.
function fromChan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function toChan_Callback(hObject, eventdata, handles)
% hObject    handle to toChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of toChan as text
%        str2double(get(hObject,'String')) returns contents of toChan as a double


% --- Executes during object creation, after setting all properties.
function toChan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in print_ste.
function print_ste_Callback(hObject, eventdata, handles)
% hObject    handle to print_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_ste


% --- Executes on button press in save_ste.
function save_ste_Callback(hObject, eventdata, handles)
% hObject    handle to save_ste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_ste



function dim_Callback(hObject, eventdata, handles)
% hObject    handle to dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim as text
%        str2double(get(hObject,'String')) returns contents of dim as a double


% --- Executes during object creation, after setting all properties.
function dim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tau_Callback(hObject, eventdata, handles)
% hObject    handle to tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tau as text
%        str2double(get(hObject,'String')) returns contents of tau as a double


% --- Executes during object creation, after setting all properties.
function tau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tau (see GCBO)
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
    assignin('base', 'premature_close_ste', 0);
else
    assignin('base','premature_close_ste',1);
end

evalin('base', 'clear all_good');%The value is no longer needed so we remove it
delete(hObject);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
assignin('base','all_good',0);%We initialize this variable to 0

font_size = evalin('base','font_size');

set(findobj('Tag','uipanel1'),'FontSize',font_size)
set(findobj('Tag','uipanel2'),'FontSize',font_size)
set(findobj('Tag','uipanel3'),'FontSize',font_size)
set(findobj('Tag','text2'),'FontSize',font_size)
set(findobj('Tag','text3'),'FontSize',font_size)
set(findobj('Tag','text4'),'FontSize',font_size)
set(findobj('Tag','text5'),'FontSize',font_size)
set(findobj('Tag','text7'),'FontSize',font_size)
set(findobj('Tag','dim_tag'),'FontSize',font_size)
set(findobj('Tag','tau_tag'),'FontSize',font_size)
set(findobj('Tag','winsize'),'FontSize',font_size)
set(findobj('Tag','numberWin'),'FontSize',font_size)
set(findobj('Tag','fromChan'),'FontSize',font_size)
set(findobj('Tag','toChan'),'FontSize',font_size)
set(findobj('Tag','dim'),'FontSize',font_size)
set(findobj('Tag','tau'),'FontSize',font_size)

set(findobj('Tag','print_ste'),'FontSize',font_size)
set(findobj('Tag','save_ste'),'FontSize',font_size)
set(findobj('Tag','full_ste'),'FontSize',font_size)
set(findobj('Tag','alpha_ste'),'FontSize',font_size)
set(findobj('Tag','beta_ste'),'FontSize',font_size)
set(findobj('Tag','delta_ste'),'FontSize',font_size)
set(findobj('Tag','theta_ste'),'FontSize',font_size)
set(findobj('Tag','gamma_ste'),'FontSize',font_size)
set(findobj('Tag','Output'),'FontSize',font_size)
set(findobj('Tag','done'),'FontSize',font_size)

set(findobj('Tag','advancedOptions'),'FontSize',font_size)
% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') %This will need to change when the documentation will be done.
