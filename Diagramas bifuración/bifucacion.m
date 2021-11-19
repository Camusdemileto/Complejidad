function varargout = bifucacionlyapunov(varargin)
% BIFUCACIONLYAPUNOV MATLAB code for bifucacionlyapunov.fig
%      BIFUCACIONLYAPUNOV, by itself, creates a new BIFUCACIONLYAPUNOV or raises the existing
%      singleton*.
%
%      H = BIFUCACIONLYAPUNOV returns the handle to a new BIFUCACIONLYAPUNOV or the handle to
%      the existing singleton*.
%
%      BIFUCACIONLYAPUNOV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIFUCACIONLYAPUNOV.M with the given input arguments.
%
%      BIFUCACIONLYAPUNOV('Property','Value',...) creates a new BIFUCACIONLYAPUNOV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bifucacionlyapunov_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bifucacionlyapunov_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bifucacionlyapunov

% Last Modified by GUIDE v2.5 09-Aug-2018 15:40:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bifucacionlyapunov_OpeningFcn, ...
                   'gui_OutputFcn',  @bifucacionlyapunov_OutputFcn, ...
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


% --- Executes just before bifucacionlyapunov is made visible.
function bifucacionlyapunov_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bifucacionlyapunov (see VARARGIN)

% Choose default command line output for bifucacionlyapunov
handles.output = hObject;

% Update handles structure
% guidata(hObject, handles);
% f=varargin(1);
% f=f{1};
% xmin=cell2mat(varargin(2));
% xmin=cell2mat(varargin(3));


%z=[xmin:0.01:xmax];
%plot(handles.axes1,z,y)
%axes(handles.axes1);
%plot(handles.axes1,z,y)
% UIWAIT makes bifucacionlyapunov wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bifucacionlyapunov_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;


% --- Executes on button press in graficar.
function graficar_Callback(hObject, eventdata, handles)
% hObject    handle to graficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=get(handles.funcion,'string')
v=extraer (get(handles.variables,'string'))
p=extraer (get(handles.parametros,'string'))
rp=extraerlimites (get(handles.rangosp,'string')) 
sp=extraer (get(handles.saltosp,'string')) 
vi=extraer (get(handles.valoresini,'string')) 
ni=extraer (get(handles.iteraciones,'string')) 
pe=extraer (get(handles.paraestaticos,'string')) 
vpe=extraer (get(handles.valorpestaticos,'string')) 
gv=extraer (get(handles.variablegraficada,'string')) 

f=ajustar(f)
saux=repmat([','],1,length(v)-1);
saux2=repmat([','],1,length(v)+length(saux));
saux2(1:2:length(v)+length(saux))=v;
saux2(2:2:length(v)+length(saux)-1)=saux;
v=saux2;
saux=repmat([','],1,length(p)-1);
saux2=repmat([','],1,length(p)+length(saux));
saux2(1:2:length(p)+length(saux))=p;
saux2(2:2:length(p)+length(saux)-1)=saux;
p=saux2;
saux=strcat('@(',v,',',p,')')
f=str2func(strcat(saux,f))
k=reshape(rp,2,length(rp)/2)'
K= @(i,s,f)i:s:f;
if sp
sp=strsplit(sp,',');
sp=char(sp)
sp=str2num(sp)'
end
H=arrayfun(@(i,s,f)K(i,s,f),k(:,1)',sp,k(:,2)','UniformOutput',false)
if vi
vi=strsplit(vi,',');
vi=char(vi);
vi=str2num(vi)';
end
ni=str2num(ni);

if vpe
vpe=strsplit(vpe,',');
vpe=char(vpe);
vpe=str2num(vpe)';
end


X=arrayfun (@(i)[zeros(length(cell2mat(H(i))),1)+vi(1),zeros(length(cell2mat(H(i))),ni-1)],[1:length(H)],'UniformOutput',false)

X(j,i+1)=K(j)*X(j,i)*(1-X(j,i));


function funcion_Callback(hObject, eventdata, handles)jfgh
% hObject    handle to funcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funcion as text
%        str2double(get(hObject,'String')) returns contents of funcion as a double


% --- Executes during object creation, after setting all properties.
function funcion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function variables_Callback(hObject, eventdata, handles)
% hObject    handle to variables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of variables as text
%        str2double(get(hObject,'String')) returns contents of variables as a double


% --- Executes during object creation, after setting all properties.
function variables_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function paraestaticos_Callback(hObject, eventdata, handles)
% hObject    handle to parametros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parametros as text
%        str2double(get(hObject,'String')) returns contents of parametros as a double


% --- Executes during object creation, after setting all properties.
function paraestaticos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parametros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function parametros_Callback(hObject, eventdata, handles)
% hObject    handle to parametros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parametros as text
%        str2double(get(hObject,'String')) returns contents of parametros as a double


% --- Executes during object creation, after setting all properties.
function parametros_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parametros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rangosp_Callback(hObject, eventdata, handles)
% hObject    handle to rangosp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rangosp as text
%        str2double(get(hObject,'String')) returns contents of rangosp as a double


% --- Executes during object creation, after setting all properties.
function rangosp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangosp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valoresini_Callback(hObject, eventdata, handles)
% hObject    handle to valoresini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valoresini as text
%        str2double(get(hObject,'String')) returns contents of valoresini as a double


% --- Executes during object creation, after setting all properties.
function valoresini_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valoresini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iteraciones_Callback(hObject, eventdata, handles)
% hObject    handle to iteraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iteraciones as text
%        str2double(get(hObject,'String')) returns contents of iteraciones as a double


% --- Executes during object creation, after setting all properties.
function iteraciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iteraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5



function valorpestaticos_Callback(hObject, eventdata, handles)
% hObject    handle to valorpestaticos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valorpestaticos as text
%        str2double(get(hObject,'String')) returns contents of valorpestaticos as a double


% --- Executes during object creation, after setting all properties.
function valorpestaticos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valorpestaticos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function variablegraficada_Callback(hObject, eventdata, handles)
% hObject    handle to variablegraficada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of variablegraficada as text
%        str2double(get(hObject,'String')) returns contents of variablegraficada as a double


% --- Executes during object creation, after setting all properties.
function variablegraficada_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variablegraficada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saltosp_Callback(hObject, eventdata, handles)
% hObject    handle to saltosp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saltosp as text
%        str2double(get(hObject,'String')) returns contents of saltosp as a double


% --- Executes during object creation, after setting all properties.
function saltosp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saltosp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
