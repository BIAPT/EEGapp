function varargout = continue_analysis(varargin)
% CONTINUE_ANALYSIS MATLAB code for continue_analysis.fig
%      CONTINUE_ANALYSIS, by itself, creates a new CONTINUE_ANALYSIS or raises the existing
%      singleton*.
%
%      H = CONTINUE_ANALYSIS returns the handle to a new CONTINUE_ANALYSIS or the handle to
%      the existing singleton*.
%
%      CONTINUE_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTINUE_ANALYSIS.M with the given input arguments.
%
%      CONTINUE_ANALYSIS('Property','Value',...) creates a new CONTINUE_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before continue_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to continue_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help continue_analysis

% Last Modified by GUIDE v2.5 06-Feb-2017 09:58:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @continue_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @continue_analysis_OutputFcn, ...
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


% --- Executes just before continue_analysis is made visible.
function continue_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to continue_analysis (see VARARGIN)

continue_value = 0;
assignin('base','continue_value',continue_value); % Here we set continue to 0

% Choose default command line output for continue_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes continue_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = continue_analysis_OutputFcn(hObject, eventdata, handles) 
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

%If continue is pressed we set continue to 1
continue_value = 1;
assignin('base','continue_value',continue_value); 
close;


% --- Executes on button press in abort_tag.
function abort_tag_Callback(hObject, eventdata, handles)
% hObject    handle to abort_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%If abort is pressed we set continue to 0 and we close
continue_value = 0;
assignin('base','continue_value',continue_value);
close;

 % --- Executes when user attempts to close YourGuiName.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to YourGuiName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(hObject);


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%When the figure is created we set continue to 0
continue_value = 0;
assignin('base','continue_value',continue_value);
