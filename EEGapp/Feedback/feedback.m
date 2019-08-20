function varargout = feedback(varargin)
% FEEDBACK MATLAB code for feedback.fig
%      FEEDBACK, by itself, creates a new FEEDBACK or raises the existing
%      singleton*.
%
%      H = FEEDBACK returns the handle to a new FEEDBACK or the handle to
%      the existing singleton*.
%
%      FEEDBACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEEDBACK.M with the given input arguments.
%
%      FEEDBACK('Property','Value',...) creates a new FEEDBACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before feedback_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to feedback_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help feedback

% Last Modified by GUIDE v2.5 08-Aug-2019 11:58:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @feedback_OpeningFcn, ...
                   'gui_OutputFcn',  @feedback_OutputFcn, ...
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


% --- Executes just before feedback is made visible.
function feedback_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to feedback (see VARARGIN)

% Choose default command line output for feedback
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes feedback wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = feedback_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
WinOnTop(gcf);



% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();




% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
font_size = evalin('base','font_size');


set(findobj('Tag','text3'),'FontSize',font_size + 6)
set(findobj('Tag','text2'),'FontSize',font_size)
set(findobj('Tag','close'),'FontSize',font_size + 2)


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
imshow('LOGO_BG_GRAY.jpg');
movegui(gcf,'center');
