function varargout = Phase_lag_index(varargin)
% PHASE_LAG_INDEX MATLAB code for Phase_lag_index.fig
%      PHASE_LAG_INDEX, by itself, creates a new PHASE_LAG_INDEX or raises the existing
%      singleton*.
%
%      H = PHASE_LAG_INDEX returns the handle to a new PHASE_LAG_INDEX or the handle to
%      the existing singleton*.
%
%      PHASE_LAG_INDEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHASE_LAG_INDEX.M with the given input arguments.
%
%      PHASE_LAG_INDEX('Property','Value',...) creates a new PHASE_LAG_INDEX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Phase_lag_index_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Phase_lag_index_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Phase_lag_index

% Last Modified by GUIDE v2.5 15-Mar-2018 14:16:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Phase_lag_index_OpeningFcn, ...
                   'gui_OutputFcn',  @Phase_lag_index_OutputFcn, ...
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


% --- Executes just before Phase_lag_index is made visible.
function Phase_lag_index_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Phase_lag_index (see VARARGIN)

% Choose default command line output for Phase_lag_index
handles.output = hObject;

%Intialize a variable that will be used to test if all input are legal
assignin('base','all_good',0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Phase_lag_index wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Phase_lag_index_OutputFcn(hObject, eventdata, handles) 
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
data_length = str2double(get(findobj('Tag','data_length'),'string'));
permutation = str2double(get(findobj('Tag','permutation'),'string'));
p_value = str2double(get(findobj('Tag','p_value'),'string'));

print_pli = get(findobj('Tag','print_pli'),'Value');
save_pli = get(findobj('Tag','save_pli'),'Value');

fullband_pli = get(findobj('Tag','pli_fullband'),'Value');
delta_pli = get(findobj('Tag','pli_deltaband'),'Value');
theta_pli = get(findobj('Tag','pli_thetaband'),'Value');
alpha_pli = get(findobj('Tag','pli_alphaband'),'Value');
beta_pli = get(findobj('Tag','pli_betaband'),'Value');
gamma_pli = get(findobj('Tag','pli_gammaband'),'Value');

%Test for possible illegal inputs and output a warning
if print_pli == 0 && save_pli == 0
    textLabel = sprintf('You need to at least print or save the figures.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif size(data_length,1) > 1 || size(permutation,1) > 1 || size(p_value,1) > 1
    textLabel = sprintf('Please make sure all field contain only one number.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif isnan(data_length) || isnan(permutation) || isnan(p_value)
    textLabel = sprintf('Please make sure all field are correctly filled.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif p_value > 1 || p_value < 0
    textLabel = sprintf('Please make sure the p value is between 0 and 1.');
    set(findobj('Tag','Output'), 'String',textLabel);
elseif fullband_pli == 0 && delta_pli == 0 && theta_pli == 0 && alpha_pli == 0 ...
        && beta_pli == 0 && gamma_pli == 0
    textLabel = sprintf('Please select at least one of the bandpass for the filtering.');
    set(findobj('Tag','Output'), 'String',textLabel);
else
    %If no illegal input then everything is good and we can save and close
    %this window
    textLabel = sprintf('All good');
    set(findobj('Tag','Output'), 'String',textLabel);
    
    pli_prp = struct('data_length',data_length,'permutation',permutation,...
    'p_value',p_value,'full',fullband_pli,'delta',delta_pli,...
    'theta',theta_pli,'alpha',alpha_pli,'beta',beta_pli,'gamma',gamma_pli,...
    'print',print_pli,'save',save_pli);
    assignin('base','pli_prp',pli_prp);
   
    assignin('base', 'all_good', 1);
    close
end


% --- Executes on button press in pli_fullband.
function pli_fullband_Callback(hObject, eventdata, handles)
% hObject    handle to pli_fullband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pli_fullband


% --- Executes on button press in pli_thetaband.
function pli_thetaband_Callback(hObject, eventdata, handles)
% hObject    handle to pli_thetaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pli_thetaband


% --- Executes on button press in pli_deltaband.
function pli_deltaband_Callback(hObject, eventdata, handles)
% hObject    handle to pli_deltaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pli_deltaband


% --- Executes on button press in pli_gammaband.
function pli_gammaband_Callback(hObject, eventdata, handles)
% hObject    handle to pli_gammaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pli_gammaband


% --- Executes on button press in pli_alphaband.
function pli_alphaband_Callback(hObject, eventdata, handles)
% hObject    handle to pli_alphaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pli_alphaband


% --- Executes on button press in pli_betaband.
function pli_betaband_Callback(hObject, eventdata, handles)
% hObject    handle to pli_betaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pli_betaband


% --- Executes on button press in print_pli.
function print_pli_Callback(hObject, eventdata, handles)
% hObject    handle to print_pli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_pli


% --- Executes on button press in save_pli.
function save_pli_Callback(hObject, eventdata, handles)
% hObject    handle to save_pli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_pli



function data_length_Callback(hObject, eventdata, handles)
% hObject    handle to data_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_length as text
%        str2double(get(hObject,'String')) returns contents of data_length as a double


% --- Executes during object creation, after setting all properties.
function data_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function permutation_Callback(hObject, eventdata, handles)
% hObject    handle to permutation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of permutation as text
%        str2double(get(hObject,'String')) returns contents of permutation as a double


% --- Executes during object creation, after setting all properties.
function permutation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to permutation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_value_Callback(hObject, eventdata, handles)
% hObject    handle to p_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p_value as text
%        str2double(get(hObject,'String')) returns contents of p_value as a double


% --- Executes during object creation, after setting all properties.
function p_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Reorder.
function Reorder_Callback(hObject, eventdata, handles)
% hObject    handle to Reorder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This checks if the pipeline is allowed to reorder or not

%First we check if there is the same number of channels in all EEG inputed
%If not then we cannot proceed and reorder the channels
sameChan = evalin('base','sameChan');
if sameChan == 0
    textLabel = sprintf('You cannot input a custom order as the number of channels is not the same across EEG data');
    set(findobj('Tag','Output'), 'String',textLabel);
    set(findobj('Tag','Reorder'),'Value',0);
    return
end

%If we can reorder then we call the reordering figure in the Reorder folder
if(get(findobj('Tag','Reorder'),'Value') == 1)

    InterfaceObj=findobj(gcf,'Enable','on');
    set(InterfaceObj,'Enable','off');%disabling the current window
    run('reorder.m');%running the program (Reorder)
    uiwait(gcf);%wait for it to be done
        
    set(InterfaceObj,'Enable','on');%re-enabling the window

    if (strcmp(evalin('base','orderType'),'default') == 1)
        set(findobj('Tag','Reorder'),'Value',0);
    end
else
    %Remove the previous ordering if any    
	evalin('base','clear newOrder');
    assignin('base','orderType','default');
end

%Here we write what kind of order type we have after the Reorder call
%into the working directory
orderType = evalin('base','orderType');
if strcmp(orderType,'default') == 1
    set(findobj('Tag','Reorder'),'Value',0);
    evalin('base','clear newOrder');
end

% Hint: get(hObject,'Value') returns toggle state of Reorder


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') %This will need to change when the documentation will be done.

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%When the figure close we check if the variable all_good was switched to 1
%If it was then the close request is not premature, else it is.
all_good = evalin('base','all_good');
if all_good == 1
    assignin('base', 'premature_close_pli', 0);
else
    assignin('base','premature_close_pli',1);
end
evalin('base', 'clear all_good');%The value is no longer needed so we remove it


% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

assignin('base','all_good',0);%We initialize this variable to 0
%Here we check if there was already a reordering done in the pli
if strcmp(evalin('base','orderType'),'custom') == 1
    set(findobj('Tag','Reorder'),'Value',1);
end

font_size = evalin('base','font_size');

set(findobj('Tag','uipanel4'),'FontSize',font_size)
set(findobj('Tag','uipanel5'),'FontSize',font_size)
set(findobj('Tag','uipanel6'),'FontSize',font_size)
set(findobj('Tag','text7'),'FontSize',font_size)
set(findobj('Tag','text8'),'FontSize',font_size)
set(findobj('Tag','text9'),'FontSize',font_size)
set(findobj('Tag','text11'),'FontSize',font_size)
set(findobj('Tag','data_length'),'FontSize',font_size)
set(findobj('Tag','permutation'),'FontSize',font_size)
set(findobj('Tag','p_value'),'FontSize',font_size)
set(findobj('Tag','print_pli'),'FontSize',font_size)
set(findobj('Tag','save_pli'),'FontSize',font_size)
set(findobj('Tag','Reorder'),'FontSize',font_size)
set(findobj('Tag','pli_fullband'),'FontSize',font_size)
set(findobj('Tag','pli_alphaband'),'FontSize',font_size)
set(findobj('Tag','pli_betaband'),'FontSize',font_size)
set(findobj('Tag','pli_deltaband'),'FontSize',font_size)
set(findobj('Tag','pli_thetaband'),'FontSize',font_size)
set(findobj('Tag','pli_gammaband'),'FontSize',font_size)
set(findobj('Tag','Output'),'FontSize',font_size)
set(findobj('Tag','continue_tag'),'FontSize',font_size)


% --------------------------------------------------------------------
function customize_plot_Callback(hObject, eventdata, handles)
% hObject    handle to customize_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InterfaceObj=findobj(gcf,'Enable','on');
set(InterfaceObj,'Enable','off');%disabling the current window
run('customize_plot.m'); %running the program (Reorder)
uiwait(gcf); %wait for it to be done

set(InterfaceObj,'Enable','on');%re-enabling the window