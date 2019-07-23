function varargout = customize_plot(varargin)
% CUSTOMIZE_PLOT MATLAB code for customize_plot.fig
%      CUSTOMIZE_PLOT, by itself, creates a new CUSTOMIZE_PLOT or raises the existing
%      singleton*.
%
%      H = CUSTOMIZE_PLOT returns the handle to a new CUSTOMIZE_PLOT or the handle to
%      the existing singleton*.
%
%      CUSTOMIZE_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUSTOMIZE_PLOT.M with the given input arguments.
%
%      CUSTOMIZE_PLOT('Property','Value',...) creates a new CUSTOMIZE_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before customize_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to customize_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help customize_plot

% Last Modified by GUIDE v2.5 15-Mar-2018 14:43:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @customize_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @customize_plot_OutputFcn, ...
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

% --- Executes just before customize_plot is made visible.
function customize_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to customize_plot (see VARARGIN)

% Choose default command line output for customize_plot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
settings = evalin('base','settings');
settings.options.custom_plot_pli = 0;
assignin('base','settings',settings);
EEG = evalin('base','EEG');
subset = evalin('base','subset');
    if(strcmp(subset,'custom') == 1)
        EEGOrderString =  evalin('base','channelSubset');
        EEGOrderString = strsplit(EEGOrderString);
        display('EEGorder string')
        display(EEGOrderString);
        labels = {EEG.chanlocs.labels}.';
        index = 1;

        for i=1:length(EEGOrderString)
           location = 0;
           for j=1:EEG.nbchan
               EEGOrderString{i}
               labels{j}
               if(strcmp(EEGOrderString{i},labels{j}) == 1)
                   location  = j;
                   break;
               end
           end
           if(location ~= 0)
            new_data(index,:) = EEG.data(location,:);
            new_chanlocs(index,:) = EEG.chanlocs(:,location);
            index = index + 1;
           end
        end
        EEG.data = new_data;
        EEG.chanlocs = new_chanlocs;
        EEG.nbchan = index - 1;
        clearvars new_data new_chanlocs
    end
h = make_default_plot(EEG);
assignin('base','figure_handle',h);
movegui(gcf,'center')



% UIWAIT makes customize_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = customize_plot_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in save_plot.
function save_plot_Callback(hObject, eventdata, handles)
% hObject    handle to save_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
settings = evalin('base','settings');
settings.options.custom_plot_pli = 1;
assignin('base','settings',settings);
figure_handle = evalin('base','figure_handle');
[folder, name, ext] = fileparts(which('customize_plot.m'))
saveas(figure_handle,[ folder, '/custom_plot_pli']);
close;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%       contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure_handle = evalin('base','figure_handle');
close(figure_handle);