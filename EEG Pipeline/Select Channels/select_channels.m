function varargout = select_channels(varargin)
% SELECT_CHANNELS MATLAB code for select_channels.fig
%      SELECT_CHANNELS, by itself, creates a new SELECT_CHANNELS or raises the existing
%      singleton*.
%
%      H = SELECT_CHANNELS returns the handle to a new SELECT_CHANNELS or the handle to
%      the existing singleton*.
%
%      SELECT_CHANNELS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECT_CHANNELS.M with the given input arguments.
%
%      SELECT_CHANNELS('Property','Value',...) creates a new SELECT_CHANNELS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before select_channels_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to select_channels_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help select_channels

% Last Modified by GUIDE v2.5 26-Nov-2017 18:43:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @select_channels_OpeningFcn, ...
                   'gui_OutputFcn',  @select_channels_OutputFcn, ...
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


% --- Executes just before select_channels is made visible.
function select_channels_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to select_channels (see VARARGIN)

% Choose default command line output for select_channels
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes select_channels wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = select_channels_OutputFcn(hObject, eventdata, handles) 
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
if get(findobj('Tag','name'), 'Value') == 1
   % NEED TO TRANSLATE THE NAMES INTO NUMBER
   EEGOrderString = (get(findobj('Tag','order_tag'), 'String'));
   EEGOrderString = strsplit(EEGOrderString);
   EEGOrder = [];
   labels = {EEG.chanlocs.labels}.';
   for i=1:length(EEGOrderString)
      found = 0;
      for j=1:EEG.nbchan
          EEGOrderString{i}
          labels{j}
          if(strcmp(EEGOrderString{i},labels{j}) == 1)
              found = 1;
              EEGOrder = [EEGOrder ; j];
              break;
          end
      end
      if(found == 0)
        textlabel = ['Please make sure all names are legal, name: ', EEGOrderString{i}, ' is not correct.'];  
        set(findobj('Tag','feedback'), 'String',textlabel);    
        return; 
      end
   end
   
elseif (get(findobj('Tag','number'), 'Value') == 1 || get(findobj('Tag','selection'), 'Value') == 1)
EEGOrder = (str2num(get(findobj('Tag','order_tag'), 'String')))';
else
    textlabel = ['Please make sure one of the three option is selected.'];  
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
assignin('base','channelSubset',EEGOrder);
assignin('base','subset','custom'); %If everything worked, then the order is custom, not default

workingDirectory = lower(evalin('base','workingDirectory'));
if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir')
    mkdir(workingDirectory,EEG.filename);
end
savingDirectory = [workingDirectory '/' EEG.filename];
   
ordering = (get(findobj('Tag','order_tag'), 'String'));
if get(findobj('Tag','name'), 'Value') == 1
   isName = 1;
else
    isName = 0;
end
orderData.ordering = ordering;
orderData.isName = isName;
save([savingDirectory '/channelsSubset.mat'],'orderData');

close;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Here we set up custom text when select_channels is opened
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
set(findobj('Tag','name'),'FontSize',font_size)
set(findobj('Tag','number'),'FontSize',font_size)
set(findobj('Tag','selection'),'FontSize',font_size)
set(findobj('Tag','load_button'),'FontSize',font_size)

set(findobj('Tag','feedback'), 'String', 'Please select order type. When ready click rearrenge, the order will be saved in your working directory.');

% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') %This will need to change when the documentation will be done.


% --- Executes on button press in number.
function number_Callback(hObject, eventdata, handles)
% hObject    handle to number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(findobj('Tag','number'), 'Value') == 1
set(findobj('Tag','order_tag'), 'String', '');
set(findobj('Tag','name'), 'Value', 0);
set(findobj('Tag','selection'), 'Value', 0);
set(findobj('Tag','feedback'), 'String', 'Please enter the numbers corresponding to the channels in the text box above.');
else
set(findobj('Tag','feedback'), 'String', '');  
set(findobj('Tag','order_tag'), 'String', '');
end
% Hint: get(hObject,'Value') returns toggle state of number


% --- Executes on button press in name.
function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(findobj('Tag','name'), 'Value') == 1
set(findobj('Tag','order_tag'), 'String', '');
set(findobj('Tag','number'), 'Value', 0);
set(findobj('Tag','selection'), 'Value', 0);
set(findobj('Tag','feedback'), 'String', 'Please enter the name corresponding to the channels in the text box above.');
else
    set(findobj('Tag','feedback'), 'String', '');
    set(findobj('Tag','order_tag'), 'String', '');
end
% Hint: get(hObject,'Value') returns toggle state of name



% --- Executes on button press in selection.
function selection_Callback(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(findobj('Tag','selection'), 'Value') == 1
set(findobj('Tag','order_tag'), 'String', '');
set(findobj('Tag','number'), 'Value', 0);
set(findobj('Tag','name'), 'Value', 0);
set(findobj('Tag','feedback'), 'String', 'Please select the channels in the order you want them to appear.');

fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file
end

order = [];
assignin('base','order',order);
assignin('base','count',0);
figure
tweaked_topoplot([],EEG.chanlocs,'style','blank','electrodes','labelpoint','chaninfo',EEG.chaninfo);
title('Left click on the channels in the order you want them to appear in the plots. When all channels have been selected close the windows and click on the rearrenge button.');
else
    set(findobj('Tag','feedback'), 'String', ''); 
    set(findobj('Tag','order_tag'), 'String', ''); 
end
% Hint: get(hObject,'Value') returns toggle state of selection


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[OrderFileName,OrderPathName] = uigetfile({'*.mat','All Files'},'Select Channel Subset File');
input = num2str(OrderFileName);
if strcmp(input,'0') == 1
    %Do nothing
else
orderStruct = load([OrderPathName OrderFileName]);
isName = orderStruct.orderData.isName;
ordering = orderStruct.orderData.ordering;
set(findobj('Tag','feedback'), 'String', 'Please make sure that the ordering is consistent with the data you have. In doubt use the selection tool.'); 
set(findobj('Tag','order_tag'), 'String', ordering);
if(isName == 1)  
    set(findobj('Tag','number'), 'Value', 0);
    set(findobj('Tag','selection'), 'Value', 0);
    set(findobj('Tag','name'), 'Value', 1);
else
    set(findobj('Tag','number'), 'Value', 1);
    set(findobj('Tag','selection'), 'Value', 0);
    set(findobj('Tag','name'), 'Value', 0);
end
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj('Tag','feedback'), 'String', ''); 
evalin('base','clear order orderData');
% Hint: delete(hObject) closes the figure
delete(hObject);
