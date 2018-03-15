function varargout = Directed_Phase_Lag_Index(varargin)
% DIRECTED_PHASE_LAG_INDEX MATLAB code for Directed_Phase_Lag_Index.fig
%      DIRECTED_PHASE_LAG_INDEX, by itself, creates a new DIRECTED_PHASE_LAG_INDEX or raises the existing
%      singleton*.
%
%      H = DIRECTED_PHASE_LAG_INDEX returns the handle to a new DIRECTED_PHASE_LAG_INDEX or the handle to
%      the existing singleton*.
%
%      DIRECTED_PHASE_LAG_INDEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIRECTED_PHASE_LAG_INDEX.M with the given input arguments.
%
%      DIRECTED_PHASE_LAG_INDEX('Property','Value',...) creates a new DIRECTED_PHASE_LAG_INDEX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Directed_Phase_Lag_Index_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Directed_Phase_Lag_Index_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Directed_Phase_Lag_Index

% Last Modified by GUIDE v2.5 15-Mar-2018 15:25:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Directed_Phase_Lag_Index_OpeningFcn, ...
                   'gui_OutputFcn',  @Directed_Phase_Lag_Index_OutputFcn, ...
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


% --- Executes just before Directed_Phase_Lag_Index is made visible.
function Directed_Phase_Lag_Index_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Directed_Phase_Lag_Index (see VARARGIN)

% Choose default command line output for Directed_Phase_Lag_Index
handles.output = hObject;

%Intialize a variable that will be used to test if all input are legal
assignin('base','all_good',0); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Directed_Phase_Lag_Index wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Directed_Phase_Lag_Index_OutputFcn(hObject, eventdata, handles) 
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

print_dpli = get(findobj('Tag','print_dpli'),'Value');
save_dpli = get(findobj('Tag','save_dpli'),'Value');

fullband_dpli = get(findobj('Tag','dpli_fullband'),'Value');
delta_dpli = get(findobj('Tag','dpli_deltaband'),'Value');
theta_dpli = get(findobj('Tag','dpli_thetaband'),'Value');
alpha_dpli = get(findobj('Tag','dpli_alphaband'),'Value');
beta_dpli = get(findobj('Tag','dpli_betaband'),'Value');
gamma_dpli = get(findobj('Tag','dpli_gammaband'),'Value');

%Test for possible illegal inputs and output a warning
if print_dpli == 0 && save_dpli == 0
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
elseif fullband_dpli == 0 && delta_dpli == 0 && theta_dpli == 0 && alpha_dpli == 0 ...
        && beta_dpli == 0 && gamma_dpli == 0
    textLabel = sprintf('Please select at least one of the bandpass for the filtering.');
    set(findobj('Tag','Output'), 'String',textLabel);
else
    %If no illegal input then everything is good and we can save and close
    %this window
    textLabel = sprintf('All good');
    set(findobj('Tag','Output'), 'String',textLabel);
    
        
    dpli_prp = struct('data_length',data_length,'permutation',permutation,...
    'p_value',p_value,'full',fullband_dpli,'delta',delta_dpli,...
    'theta',theta_dpli,'alpha',alpha_dpli,'beta',beta_dpli,'gamma',gamma_dpli,...
    'print',print_dpli,'save',save_dpli);
    assignin('base','dpli_prp',dpli_prp);

    assignin('base', 'all_good', 1);
    close
end


% --- Executes on button press in dpli_fullband.
function dpli_fullband_Callback(hObject, eventdata, handles)
% hObject    handle to dpli_fullband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dpli_fullband


% --- Executes on button press in dpli_thetaband.
function dpli_thetaband_Callback(hObject, eventdata, handles)
% hObject    handle to dpli_thetaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dpli_thetaband


% --- Executes on button press in dpli_deltaband.
function dpli_deltaband_Callback(hObject, eventdata, handles)
% hObject    handle to dpli_deltaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dpli_deltaband


% --- Executes on button press in dpli_gammaband.
function dpli_gammaband_Callback(hObject, eventdata, handles)
% hObject    handle to dpli_gammaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dpli_gammaband


% --- Executes on button press in dpli_alphaband.
function dpli_alphaband_Callback(hObject, eventdata, handles)
% hObject    handle to dpli_alphaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dpli_alphaband


% --- Executes on button press in dpli_betaband.
function dpli_betaband_Callback(hObject, eventdata, handles)
% hObject    handle to dpli_betaband (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dpli_betaband


% --- Executes on button press in print_dpli.
function print_dpli_Callback(hObject, eventdata, handles)
% hObject    handle to print_dpli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_dpli


% --- Executes on button press in save_dpli.
function save_dpli_Callback(hObject, eventdata, handles)
% hObject    handle to save_dpli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_dpli



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
    assignin('base', 'premature_close_dpli', 0);
else
    assignin('base','premature_close_dpli',1);
end

evalin('base', 'clear all_good'); %The value is no longer needed so we remove it

delete(hObject);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

assignin('base','all_good',0); %We initialize this variable to 0
%Here we check if there was already a reordering done in the pli 
if strcmp(evalin('base','orderType'),'custom') == 1
    set(findobj('Tag','Reorder'),'Value',1);
end

font_size = evalin('base','font_size');

set(findobj('Tag','uipanel1'),'FontSize',font_size)
set(findobj('Tag','uipanel2'),'FontSize',font_size)
set(findobj('Tag','uipanel3'),'FontSize',font_size)
set(findobj('Tag','text2'),'FontSize',font_size)
set(findobj('Tag','text3'),'FontSize',font_size)
set(findobj('Tag','text4'),'FontSize',font_size)
set(findobj('Tag','text6'),'FontSize',font_size)
set(findobj('Tag','data_length'),'FontSize',font_size)
set(findobj('Tag','permutation'),'FontSize',font_size)
set(findobj('Tag','p_value'),'FontSize',font_size)
set(findobj('Tag','print_dpli'),'FontSize',font_size)
set(findobj('Tag','save_dpli'),'FontSize',font_size)
set(findobj('Tag','Reorder'),'FontSize',font_size)
set(findobj('Tag','dpli_fullband'),'FontSize',font_size)
set(findobj('Tag','dpli_alphaband'),'FontSize',font_size)
set(findobj('Tag','dpli_betaband'),'FontSize',font_size)
set(findobj('Tag','dpli_deltaband'),'FontSize',font_size)
set(findobj('Tag','dpli_thetaband'),'FontSize',font_size)
set(findobj('Tag','dpli_gammaband'),'FontSize',font_size)
set(findobj('Tag','Output'),'FontSize',font_size)
set(findobj('Tag','continue_tag'),'FontSize',font_size)


% --- Executes on button press in Reorder.
function Reorder_Callback(hObject, eventdata, handles)
% hObject    handle to Reorder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Reorder

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
    run('reorder.m'); %running the program (Reorder)
    uiwait(gcf); %wait for it to be done
        
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


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Documentation.pdf') % This will need to change when the documentation will be done


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