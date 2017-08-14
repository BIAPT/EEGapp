function varargout = reorder(varargin)
% REORDER MATLAB code for reorder.fig
%      REORDER, by itself, creates a new REORDER or raises the existing
%      singleton*.
%
%      H = REORDER returns the handle to a new REORDER or the handle to
%      the existing singleton*.
%
%      REORDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REORDER.M with the given input arguments.
%
%      REORDER('Property','Value',...) creates a new REORDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before reorder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to reorder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help reorder

% Last Modified by GUIDE v2.5 06-Feb-2017 10:07:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reorder_OpeningFcn, ...
                   'gui_OutputFcn',  @reorder_OutputFcn, ...
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


% --- Executes just before reorder is made visible.
function reorder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to reorder (see VARARGIN)

% Choose default command line output for reorder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes reorder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = reorder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function order_tag_Callback(hObject, eventdata, handles)
% hObject    handle to order_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of order_tag as text
%        str2double(get(hObject,'String')) returns contents of order_tag as a double


% --- Executes during object creation, after setting all properties.
function order_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in rearrengeEEG.
function rearrengeEEG_Callback(hObject, eventdata, handles)
% hObject    handle to rearrengeEEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This bit of code assume that if there is more than one file that they
%have the same number of channels
fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file
end

%Take the order as inputed by the user
EEGOrder = (str2num(get(findobj('Tag','order_tag'), 'String')))';

%First check if there is the same number of channels in this new order
%versus the full length EEG.
if length(EEGOrder) ~= EEG.nbchan
    textlabel = ['Please make sure the new order contain the same number of channels as the default order.'];  
    set(findobj('Tag','feedback'), 'String',textlabel);
    return;
end

%Then iterate through each channels and check that each channels value are
%legal
for i =1:length(EEGOrder)
   if EEGOrder(i,1) > EEG.nbchan || EEGOrder(i,1) < 1 
       textlabel = ['Make sure the channels are not greater than the number of channels or smaller than 1.'];  
       set(findobj('Tag','feedback'), 'String',textlabel);
       return
   end
end

%Here we go through the new order and check if there is duplicates
oldOrder = (1:EEG.nbchan)';
for i=1:length(EEGOrder)
    if oldOrder(EEGOrder(i,1),1) ~= 0
        oldOrder(EEGOrder(i,1),1) = 0;
    else
        textlabel = ['Please make sure there is no duplicate.'];  
        set(findobj('Tag','feedback'), 'String',textlabel);
        return;
    end
end

%If everything is legal with the input we save the new order to workspace
assignin('base','newOrder',EEGOrder);
assignin('base','orderType','custom'); %If everything worked, then the order is custom, not default
close;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Here we set up custom text when Reorder is opened
fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file
end
textlabel = ['New EEG Order (' num2str(EEG.nbchan) ') :'];
set(findobj('Tag','ordertext'), 'String',textlabel);

font_size = evalin('base','font_size');

set(findobj('Tag','uipanel1'),'FontSize',font_size)
set(findobj('Tag','uipanel3'),'FontSize',font_size)
set(findobj('Tag','ordertext'),'FontSize',font_size)
set(findobj('Tag','feedback'),'FontSize',font_size)
set(findobj('Tag','order_tag'),'FontSize',font_size)
set(findobj('Tag','rearrengeEEG'),'FontSize',font_size)

% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') %This will need to change when the documentation will be done.