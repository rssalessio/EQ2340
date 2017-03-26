function varargout = Live_demonstration(varargin)
% LIVE_DEMONSTRATION MATLAB code for Live_demonstration.fig
%      LIVE_DEMONSTRATION, by itself, creates a new LIVE_DEMONSTRATION or raises the existing
%      singleton*.
%
%      H = LIVE_DEMONSTRATION returns the handle to a new LIVE_DEMONSTRATION or the handle to
%      the existing singleton*.
%
%      LIVE_DEMONSTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIVE_DEMONSTRATION.M with the given input arguments.
%
%      LIVE_DEMONSTRATION('Property','Value',...) creates a new LIVE_DEMONSTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Live_demonstration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Live_demonstration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Live_demonstration

% Last Modified by GUIDE v2.5 02-Nov-2015 15:08:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Live_demonstration_OpeningFcn, ...
                   'gui_OutputFcn',  @Live_demonstration_OutputFcn, ...
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

global Parameters
Parameters.fs = 22050;
Parameters.nWords = 14;
Parameters.lWord = 2;
Parameters.windowLength = 0.03;
Parameters.nCepstral = 13;

% End initialization code - DO NOT EDIT


% --- Executes just before Live_demonstration is made visible.
function Live_demonstration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Live_demonstration (see VARARGIN)

% Choose default command line output for Live_demonstration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


p = bar(ones(14,1));
set(p,'Parent', handles.figure)
% UIWAIT makes Live_demonstration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Live_demonstration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Parameters

a=tic;
handles.textbox.String = 'Start speaking in 3 seconds!';
disp('Start speaking in 3 seconds!')
pause(1);
handles.textbox.String = 'Start speaking in 2 seconds!';
disp('Start speaking in 2 seconds!')
pause(1);
handles.textbox.String = 'Start speaking in 1 seconds!';
disp('Start speaking in 1 seconds!')
pause(1);
handles.textbox.String = 'Speak now!';
disp('Speak now!')
recObj = audiorecorder(22050,16,1);
recordblocking(recObj,Parameters.lWord)
disp('Recording ended!')
handles.textbox.String = 'Recording ended!';
play(recObj)
Parameters.rec = recObj;
Parameters.data = getaudiodata(recObj);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Parameters
play(Parameters.rec)
pause(Parameters.lWord)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Parameters
addpath('GetSpeechFeatures');
load('hmm4');
load('hmms4');


hmm(1) = convert_objback(hmm(1),in1);
hmm(2) = convert_objback(hmm(2),in2);
hmm(3) = convert_objback(hmm(3),in3);
hmm(4) = convert_objback(hmm(4),in4);
hmm(5) = convert_objback(hmm(5),in5);
hmm(6) = convert_objback(hmm(6),in6);
hmm(7) = convert_objback(hmm(7),in7);
hmm(8) = convert_objback(hmm(8),in8);
hmm(9) = convert_objback(hmm(9),in9);
hmm(10) = convert_objback(hmm(10),in10);
hmm(11) = convert_objback(hmm(11),in11);
hmm(12) = convert_objback(hmm(12),in12);
hmm(13) = convert_objback(hmm(13),in13);
hmm(14) = convert_objback(hmm(14),in14); 

features   = mfcc_dyn(Parameters.data,Parameters.fs,Parameters.windowLength,Parameters.nCepstral);
[~,a] = max(logprob(hmm,features));
disp(a)
if a==1
    result = [num2str(a) '== recognition'];
elseif a==2
    result = [num2str(a) '== environment'];
elseif a==3
    result = [num2str(a) '== affect'];
elseif a==4
    result = [num2str(a) '== effect'];
elseif a==5
    result = [num2str(a) '== I'];
elseif a==6
    result = [num2str(a) '== am'];
elseif a==7
    result = [num2str(a) '== in'];
elseif a==8
    result = [num2str(a) '== is'];
elseif a==9
    result = [num2str(a) '== Lars'];
elseif a==10
    result = [num2str(a) '== Alessio'];
elseif a==11
    result = [num2str(a) '== hand'];
elseif a==12
    result = [num2str(a) '== chair'];
elseif a==13
    result = [num2str(a) '== markov'];
elseif a==14
    result = [num2str(a) '== Stockholm'];
end
handles.textbox.String = result;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Parameters
addpath('GetSpeechFeatures');

load('hmm4');
load('hmms4');


hmm(1) = convert_objback(hmm(1),in1);
hmm(2) = convert_objback(hmm(2),in2);
hmm(3) = convert_objback(hmm(3),in3);
hmm(4) = convert_objback(hmm(4),in4);
hmm(5) = convert_objback(hmm(5),in5);
hmm(6) = convert_objback(hmm(6),in6);
hmm(7) = convert_objback(hmm(7),in7);
hmm(8) = convert_objback(hmm(8),in8);
hmm(9) = convert_objback(hmm(9),in9);
hmm(10) = convert_objback(hmm(10),in10);
hmm(11) = convert_objback(hmm(11),in11);
hmm(12) = convert_objback(hmm(12),in12);
hmm(13) = convert_objback(hmm(13),in13);
hmm(14) = convert_objback(hmm(14),in14); 

features   = mfcc_dyn(Parameters.data,Parameters.fs,Parameters.windowLength,Parameters.nCepstral);
for j=1:Parameters.nWords
    a(j) = logprob(hmm(j),features);
end

p = bar(a);
set(p,'Parent', handles.figure);
hold on
[val,pos] = max(a);
p = line([0 15],[val val],'Color','r');
set(p,'Parent', handles.figure);
hold off;
