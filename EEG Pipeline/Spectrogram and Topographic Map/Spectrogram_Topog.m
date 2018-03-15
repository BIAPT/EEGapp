function varargout = Spectrogram_Topog(varargin)
% SPECTROGRAM_TOPOG MATLAB code for Spectrogram_Topog.fig
%      SPECTROGRAM_TOPOG, by itself, creates a new SPECTROGRAM_TOPOG or raises the existing
%      singleton*.
%
%      H = SPECTROGRAM_TOPOG returns the handle to a new SPECTROGRAM_TOPOG or the handle to
%      the existing singleton*.
%
%      SPECTROGRAM_TOPOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTROGRAM_TOPOG.M with the given input arguments.
%
%      SPECTROGRAM_TOPOG('Property','Value',...) creates a new SPECTROGRAM_TOPOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Spectrogram_Topog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Spectrogram_Topog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Spectrogram_Topog

% Last Modified by GUIDE v2.5 15-Mar-2018 12:57:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spectrogram_Topog_OpeningFcn, ...
                   'gui_OutputFcn',  @Spectrogram_Topog_OutputFcn, ...
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


% --- Executes just before Spectrogram_Topog is made visible.
function Spectrogram_Topog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Spectrogram_Topog (see VARARGIN)
% Choose default command line output for Spectrogram_Topog
handles.output = hObject;

%Intialize a variable that will be used to test if all input are legal
assignin('base','all_good',0);
%Here we load an EEG structure file to write custom text
fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file if more than one
end
set(findobj('Tag','topo_text'),'String',sprintf('Frequencies\n0Hz to %.0fHz\n0.5 increment',EEG.srate/2));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Spectrogram_Topog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Spectrogram_Topog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function sampleFreq_Callback(hObject, eventdata, handles)
% hObject    handle to sampleFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampleFreq as text
%        str2double(get(hObject,'String')) returns contents of sampleFreq as a double


% --- Executes during object creation, after setting all properties.
function sampleFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function Output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function frequencyPass_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequencyPass as text
%        str2double(get(hObject,'String')) returns contents of frequencyPass as a double


% --- Executes during object creation, after setting all properties.
function frequencyPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencyPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tSOrder_Callback(hObject, eventdata, handles)
% hObject    handle to tSOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tSOrder as text
%        str2double(get(hObject,'String')) returns contents of tSOrder as a double


% --- Executes during object creation, after setting all properties.
function tSOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tSOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in isPrintFigure.
function isPrintFigure_Callback(hObject, eventdata, handles)
% hObject    handle to isPrintFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isPrintFigure

% --- Executes during object creation, after setting all properties.
function fileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Here we load an EEG structure file to write custom text
fileName = evalin('base','fileName');
if iscell(FileName) == 0
    set(findobj('Tag','fileName'),'String',fileName);
else
    set(findobj('Tag','fileName'),'String',fileName{1});
end

% --- Executes during object deletion, before destroying properties.
function fileName_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
    set(findobj('Tag','advancedOptions'),'Position',[3.4 1.923 47.2 1.923]);

    %Bandwidth:
    set(findobj('Tag','bandwidth'),'Visible','On');
    %timeBandwidth:
    set(findobj('Tag','timeBandwidth'),'Visible','On');
    %numberTaper:
    set(findobj('Tag','numberTaper'),'Visible','On');
    %lengthWindow
    set(findobj('Tag','lengthWindow'),'Visible','On');
    %windowLength
    set(findobj('Tag','windowLength'),'Visible','On');
    %stepSize
    set(findobj('Tag','stepSize'),'Visible','On');
else
    %Otherwise we hide the advanced options
    set(findobj('Tag','advancedOptions'),'String','Advanced Options');
    set(findobj('Tag','advancedOptions'),'Position',[3.4 7.6923 47.2 1.923]); 

    %The advanced option position
    %Bandwidth:
    set(findobj('Tag','bandwidth'),'Visible','Off');
    %timeBandwidth:
    set(findobj('Tag','timeBandwidth'),'Visible','Off');
    %numberTaper:
    set(findobj('Tag','numberTaper'),'Visible','Off');
    %lengthWindow
    set(findobj('Tag','lengthWindow'),'Visible','Off');
    %windowLength
    set(findobj('Tag','windowLength'),'Visible','Off');
    %stepSize
    set(findobj('Tag','stepSize'),'Visible','Off');
end



function timeBandwidth_Callback(hObject, eventdata, handles)
% hObject    handle to timeBandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeBandwidth as text
%        str2double(get(hObject,'String')) returns contents of timeBandwidth as a double


% --- Executes during object creation, after setting all properties.
function timeBandwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeBandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberTaper_Callback(hObject, eventdata, handles)
% hObject    handle to numberTaper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberTaper as text
%        str2double(get(hObject,'String')) returns contents of numberTaper as a double


% --- Executes during object creation, after setting all properties.
function numberTaper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberTaper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windowLength_Callback(hObject, eventdata, handles)
% hObject    handle to windowLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowLength as text
%        str2double(get(hObject,'String')) returns contents of windowLength as a double


% --- Executes during object creation, after setting all properties.
function windowLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stepSize_Callback(hObject, eventdata, handles)
% hObject    handle to stepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stepSize as text
%        str2double(get(hObject,'String')) returns contents of stepSize as a double


% --- Executes during object creation, after setting all properties.
function stepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get the input from the various checboxes or textfields
%and store them in variables
fp = str2num(get(findobj('Tag','frequencyPass'),'string'));
tso = str2double(get(findobj('Tag','tSOrder'),'string'));

fileName = evalin('base','fileName');
if iscell(fileName) == 0
    EEG = evalin('base','EEG');
else
    EEG = evalin('base','EEG'); %We will only load the first EEG file if more than one
end

%Advanced options:
timeBandwidth = str2double(get(findobj('Tag','timeBandwidth'),'string'));
numberTaper = str2double(get(findobj('Tag','numberTaper'),'string'));
windowLength = str2double(get(findobj('Tag','windowLength'),'string'));
stepSize = str2double(get(findobj('Tag','stepSize'),'string'));
 
%Topomap:
frequencies = str2num(get(findobj('Tag','topofreq'),'string')); 

%Here we check if the topomap frequencies are empty or not
if isempty(frequencies)
    frequencies_ok = 0;
elseif isnan(frequencies)
    frequencies_ok = 0;
else
    frequencies_ok = 1;
end

negative_freq = 0;
%Here we check if the topomap frequencies are negative
for i=1:length(frequencies)
    if(frequencies(1,i) < 0)
    	negative_freq = 1;   
    end
end

%Check if there is a min and max for the spectrogram
if size(fp,2) == 2 && isempty(fp) == 0
	fp_ok = 1;
else
	fp_ok = 0;
end

%Here we load the print and save variables
print_spect = get(findobj('Tag','print_spect'),'Value');
save_spect = get(findobj('Tag','save_spect'),'Value');
print_topo = get(findobj('Tag','print_topo'),'Value');
save_topo = get(findobj('Tag','save_topo'),'Value');
 
%Test for possible illegal inputs and output a warning
if isnan(tso) || fp_ok == 0 || isnan(timeBandwidth)...
        || isnan(numberTaper) || isnan(windowLength) || isnan(stepSize) || frequencies_ok == 0
	textLabel = sprintf('Please make sure all field are correctly filled');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif print_spect == 0 && save_spect == 0
    textLabel = sprintf('You need to at least print or save the figures in the spectrogram.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif print_topo == 0 && save_topo == 0
    textLabel = sprintf('You need to at least print or save the figures in the topographic map.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif fp(1,1) < 0 || fp(1,2) < 0
    textLabel = sprintf('The frequency range must be positive.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif fp(1,2) < fp(1,1)
    textLabel = sprintf('The maximum of the frequency range must be greater than the minimum.');
    set(findobj('Tag','Output'), 'String',textLabel);     
elseif negative_freq == 1
    textLabel = sprintf('Please make sure the frequencies of the topographic map are positive.');
    set(findobj('Tag','Output'), 'String',textLabel);   
elseif windowLength < 2/frequencies(1,1)
    textLabel = sprintf('Please make sure the windows length is at least 2/(min frequency).');
    set(findobj('Tag','Output'), 'String',textLabel);   
elseif stepSize < 1/EEG.srate
    textLabel = sprintf('Please make sure the step size is at least greater than the 1/(sampling frequency).');
    set(findobj('Tag','Output'), 'String',textLabel); 
else
    %This is needed to know the index of the frequencies to calculate the
    %Topographic map properly.
   freqidx = (2*frequencies) + 1; 
    %If no illegal input then everything is good and we can save and close
    %this window
   spectopo_prp = struct('fp',fp,'tso',tso,'timeBandwidth',timeBandwidth,...
   'numberTaper',numberTaper,'windowLength',windowLength,'stepSize',stepSize,...
   'freqidx',freqidx,'frequencies',frequencies,'print_spect',print_spect,...
   'save_spect',save_spect,'print_topo',print_topo,'save_topo',save_topo);
   assignin('base','spectopo_prp',spectopo_prp);
    
   textLabel = sprintf('All good!');
   set(findobj('Tag','Output'), 'String',textLabel);
   assignin('base', 'all_good', 1);
   close;
end



function topofreq_Callback(hObject, eventdata, handles)
% hObject    handle to topofreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of topofreq as text
%        str2double(get(hObject,'String')) returns contents of topofreq as a double


% --- Executes during object creation, after setting all properties.
function topofreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to topofreq (see GCBO)
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
    assignin('base', 'premature_close_spectopo', 0);
else
    assignin('base','premature_close_spectopo',1);
end

evalin('base', 'clear all_good');%The value is no longer needed so we remove it

delete(hObject);


% --- Executes on button press in print_topo.
function print_topo_Callback(hObject, eventdata, handles)
% hObject    handle to print_topo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_topo


% --- Executes on button press in save_topo.
function save_topo_Callback(hObject, eventdata, handles)
% hObject    handle to save_topo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_topo


% --- Executes on button press in print_spect.
function print_spect_Callback(hObject, eventdata, handles)
% hObject    handle to print_spect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_spect


% --- Executes on button press in save_spect.
function save_spect_Callback(hObject, eventdata, handles)
% hObject    handle to save_spect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_spect


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
assignin('base','all_good',0);%We initialize this variable to 0

font_size = evalin('base','font_size');

set(findobj('Tag','inputPanel'),'FontSize',font_size)
set(findobj('Tag','uipanel5'),'FontSize',font_size)
set(findobj('Tag','feedPanel'),'FontSize',font_size)
set(findobj('Tag','Output'),'FontSize',font_size)
set(findobj('Tag','done'),'FontSize',font_size)
set(findobj('Tag','text5'),'FontSize',font_size)
set(findobj('Tag','text6'),'FontSize',font_size)
set(findobj('Tag','bandwidth'),'FontSize',font_size)
set(findobj('Tag','lengthWindow'),'FontSize',font_size)
set(findobj('Tag','frequencyPass'),'FontSize',font_size)
set(findobj('Tag','tSOrder'),'FontSize',font_size)
set(findobj('Tag','timeBandwidth'),'FontSize',font_size)
set(findobj('Tag','numberTaper'),'FontSize',font_size)
set(findobj('Tag','windowLength'),'FontSize',font_size)
set(findobj('Tag','stepSize'),'FontSize',font_size)
set(findobj('Tag','print_spect'),'FontSize',font_size)
set(findobj('Tag','save_spect'),'FontSize',font_size)
set(findobj('Tag','topo_text'),'FontSize',font_size)
set(findobj('Tag','topofreq'),'FontSize',font_size)
set(findobj('Tag','print_topo'),'FontSize',font_size)
set(findobj('Tag','save_topo'),'FontSize',font_size)

set(findobj('Tag','advancedOptions'),'FontSize',font_size)
% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') %This will need to change when the documentation will be done.


% --------------------------------------------------------------------
function customize_Callback(hObject, eventdata, handles)
% hObject    handle to customize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
