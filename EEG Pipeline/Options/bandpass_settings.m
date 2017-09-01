function varargout = bandpass_settings(varargin)
% BANDPASS_SETTINGS MATLAB code for bandpass_settings.fig
%      BANDPASS_SETTINGS, by itself, creates a new BANDPASS_SETTINGS or raises the existing
%      singleton*.
%
%      H = BANDPASS_SETTINGS returns the handle to a new BANDPASS_SETTINGS or the handle to
%      the existing singleton*.
%
%      BANDPASS_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BANDPASS_SETTINGS.M with the given input arguments.
%
%      BANDPASS_SETTINGS('Property','Value',...) creates a new BANDPASS_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bandpass_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bandpass_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bandpass_settings

% Last Modified by GUIDE v2.5 01-Sep-2017 11:44:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bandpass_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @bandpass_settings_OutputFcn, ...
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


% --- Executes just before bandpass_settings is made visible.
function bandpass_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bandpass_settings (see VARARGIN)

% Choose default command line output for bandpass_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bandpass_settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bandpass_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in set_button.
function set_button_Callback(hObject, eventdata, handles)
% hObject    handle to set_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
full_bp = str2num(get(findobj('Tag','full_text'),'string'));
alpha_bp = str2num(get(findobj('Tag','alpha_text'),'string'));
beta_bp = str2num(get(findobj('Tag','beta_text'),'string'));
delta_bp = str2num(get(findobj('Tag','delta_text'),'string'));
theta_bp = str2num(get(findobj('Tag','theta_text'),'string'));
gamma_bp = str2num(get(findobj('Tag','gamma_text'),'string'));

if size(full_bp,2) ~= 2 || size(alpha_bp,2) ~= 2 || size(beta_bp,2) ~= 2 ...
    || size(delta_bp,2) ~= 2 || size(theta_bp,2) ~= 2 || size(gamma_bp,2) ~= 2
    textLabel = sprintf('Please make sure all bandpass contain two numbers.');
    set(findobj('Tag','feedback'), 'String',textLabel);
else
    settings = evalin('base','settings');
    settings.options.full = full_bp;
    settings.options.alpha = alpha_bp;
    settings.options.beta = beta_bp;
    settings.options.delta = delta_bp;
    settings.options.theta = theta_bp;
    settings.options.gamma = gamma_bp;
    assignin('base','settings',settings);
    set(findobj('Tag','feedback'), 'String','');
    close;
end

    

% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

settings = evalin('base','settings');
settings.options.full = settings.options.defaultFull;
settings.options.alpha = settings.options.defaultAlpha;
settings.options.beta = settings.options.defaultBeta;
settings.options.delta = settings.options.defaultDelta;
settings.options.theta = settings.options.defaultTheta;
settings.options.gamma = settings.options.defaultGamma;
assignin('base','settings',settings);
set(findobj('Tag','feedback'), 'String','');
close;


function full_text_Callback(hObject, eventdata, handles)
% hObject    handle to full_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of full_text as text
%        str2double(get(hObject,'String')) returns contents of full_text as a double


% --- Executes during object creation, after setting all properties.
function full_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to full_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_text_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha_text as text
%        str2double(get(hObject,'String')) returns contents of alpha_text as a double


% --- Executes during object creation, after setting all properties.
function alpha_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_text_Callback(hObject, eventdata, handles)
% hObject    handle to beta_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta_text as text
%        str2double(get(hObject,'String')) returns contents of beta_text as a double


% --- Executes during object creation, after setting all properties.
function beta_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delta_text_Callback(hObject, eventdata, handles)
% hObject    handle to delta_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delta_text as text
%        str2double(get(hObject,'String')) returns contents of delta_text as a double


% --- Executes during object creation, after setting all properties.
function delta_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_text_Callback(hObject, eventdata, handles)
% hObject    handle to theta_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_text as text
%        str2double(get(hObject,'String')) returns contents of theta_text as a double


% --- Executes during object creation, after setting all properties.
function theta_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma_text_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_text as text
%        str2double(get(hObject,'String')) returns contents of gamma_text as a double


% --- Executes during object creation, after setting all properties.
function gamma_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_text (see GCBO)
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

font_size = evalin('base','font_size');

set(findobj('Tag','title'),'FontSize',font_size);
set(findobj('Tag','uipanel1'),'FontSize',font_size);
set(findobj('Tag','full_tag'),'FontSize',font_size);
set(findobj('Tag','alpha_tag'),'FontSize',font_size);
set(findobj('Tag','beta_tag'),'FontSize',font_size);
set(findobj('Tag','delta_tag'),'FontSize',font_size);
set(findobj('Tag','theta_tag'),'FontSize',font_size);
set(findobj('Tag','gamma_tag'),'FontSize',font_size);
set(findobj('Tag','full_text'),'FontSize',font_size);
set(findobj('Tag','alpha_text'),'FontSize',font_size);
set(findobj('Tag','beta_text'),'FontSize',font_size);
set(findobj('Tag','delta_text'),'FontSize',font_size);
set(findobj('Tag','theta_text'),'FontSize',font_size);
set(findobj('Tag','gamma_text'),'FontSize',font_size);
set(findobj('Tag','feedback_panel'),'FontSize',font_size);
set(findobj('Tag','feedback'),'FontSize',font_size);
set(findobj('Tag','set_button'),'FontSize',font_size);
set(findobj('Tag','reset_button'),'FontSize',font_size);

settings = evalin('base','settings');
set(findobj('Tag','full_text'),'String',num2str(settings.options.full));
set(findobj('Tag','alpha_text'),'String',num2str(settings.options.alpha));
set(findobj('Tag','beta_text'),'String',num2str(settings.options.beta));
set(findobj('Tag','delta_text'),'String',num2str(settings.options.delta));
set(findobj('Tag','theta_text'),'String',num2str(settings.options.theta));
set(findobj('Tag','gamma_text'),'String',num2str(settings.options.gamma));
