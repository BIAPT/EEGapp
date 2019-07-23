function varargout = GraphTheory(varargin)
% GRAPHTHEORY MATLAB code for GraphTheory.fig
%      GRAPHTHEORY, by itself, creates a new GRAPHTHEORY or raises the existing
%      singleton*.
%
%      H = GRAPHTHEORY returns the handle to a new GRAPHTHEORY or the handle to
%      the existing singleton*.
%
%      GRAPHTHEORY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHTHEORY.M with the given input arguments.
%
%      GRAPHTHEORY('Property','Value',...) creates a new GRAPHTHEORY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GraphTheory_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GraphTheory_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GraphTheory

% Last Modified by GUIDE v2.5 23-Feb-2017 14:11:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GraphTheory_OpeningFcn, ...
                   'gui_OutputFcn',  @GraphTheory_OutputFcn, ...
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


% --- Executes just before GraphTheory is made visible.
function GraphTheory_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GraphTheory (see VARARGIN)

% Choose default command line output for GraphTheory
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GraphTheory wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GraphTheory_OutputFcn(hObject, eventdata, handles) 
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

%Get the input from the various checboxes or textfields
%and store them in variables
network_thresh = str2double(get(findobj('Tag','network_thresh'),'string'));
win = str2double(get(findobj('Tag','win'),'string'));

print_graph = get(findobj('Tag','print_graph'),'Value');
save_graph = get(findobj('Tag','save_graph'),'Value');

fullband_graph = get(findobj('Tag','full_band'),'Value');
delta_graph = get(findobj('Tag','delta_band'),'Value');
theta_graph = get(findobj('Tag','theta_band'),'Value');
alpha_graph = get(findobj('Tag','alpha_band'),'Value');
beta_graph = get(findobj('Tag','beta_band'),'Value');
gamma_graph = get(findobj('Tag','gamma_band'),'Value');

%Test for possible illegal inputs and output a warning
if print_graph == 0 && save_graph == 0
    textLabel = sprintf('You need to at least print or save the figures.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif size(network_thresh,1) > 1 || size(win,1) > 1 
    textLabel = sprintf('Please make sure all field contain only one number.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif isnan(network_thresh) || isnan(win)
    textLabel = sprintf('Please make sure all field are correctly filled.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif network_thresh > 100 || network_thresh < 1
    textLabel = sprintf('Please make sure the treshold is between 1 and 100.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif fullband_graph == 0 && delta_graph == 0 && theta_graph == 0 && alpha_graph == 0 ...
        && beta_graph == 0 && gamma_graph == 0
    textLabel = sprintf('Please select at least one of the bandpass for the filtering.');
    set(findobj('Tag','Output'), 'String',textLabel);
else
    %If no illegal input then everything is good and we can save and close
    %this window
    textLabel = sprintf('All good');
    set(findobj('Tag','Output'), 'String',textLabel);

    check_graph = get(findobj('Tag','check_graph'),'Value');
    
    graph_prp = struct('network_thresh',network_thresh/100,'win',win,...
    'full',fullband_graph,'delta',delta_graph,...
    'theta',theta_graph,'alpha',alpha_graph,...
    'beta',beta_graph,'gamma',gamma_graph,...
    'print',print_graph,'save',save_graph,'check',check_graph);
    assignin('base','graph_prp',graph_prp);

    assignin('base', 'all_good', 1);
    close
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


% --- Executes on button press in print_graph.
function print_graph_Callback(hObject, eventdata, handles)
% hObject    handle to print_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_graph


% --- Executes on button press in save_graph.
function save_graph_Callback(hObject, eventdata, handles)
% hObject    handle to save_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_graph



function network_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to network_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of network_thresh as text
%        str2double(get(hObject,'String')) returns contents of network_thresh as a double


% --- Executes during object creation, after setting all properties.
function network_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to network_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function win_Callback(hObject, eventdata, handles)
% hObject    handle to win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of win as text
%        str2double(get(hObject,'String')) returns contents of win as a double


% --- Executes during object creation, after setting all properties.
function win_CreateFcn(hObject, eventdata, handles)
% hObject    handle to win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_graph.
function check_graph_Callback(hObject, eventdata, handles)
% hObject    handle to check_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_graph


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Intialize a variable that will be used to test if all input are legal
assignin('base','all_good',0);%We initialize this variable to 0

font_size = evalin('base','font_size');

set(findobj('Tag','uipanel1'),'FontSize',font_size)
set(findobj('Tag','uipanel2'),'FontSize',font_size)
set(findobj('Tag','uipanel3'),'FontSize',font_size)
set(findobj('Tag','text2'),'FontSize',font_size)
set(findobj('Tag','text3'),'FontSize',font_size)
set(findobj('Tag','text6'),'FontSize',font_size)
set(findobj('Tag','network_thresh'),'FontSize',font_size)
set(findobj('Tag','win'),'FontSize',font_size)
set(findobj('Tag','print_graph'),'FontSize',font_size)
set(findobj('Tag','save_graph'),'FontSize',font_size)
set(findobj('Tag','check_graph'),'FontSize',font_size)
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

%When the figure close we check if the variable all_good was switched to 1
%If it was then the close request is not premature, else it is.
all_good = evalin('base','all_good');
if all_good == 1
    assignin('base', 'premature_close_graph', 0);
else
    assignin('base','premature_close_graph',1);
end

evalin('base', 'clear all_good');%The value is no longer needed so we remove it
delete(hObject);


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') %This will need to change when the documentation will be done.
