function varargout = cobwebinterfaz(varargin)
% COBWEBINTERFAZ MATLAB code for cobwebinterfaz.fig
%      COBWEBINTERFAZ, by itself, creates a new COBWEBINTERFAZ or raises the existing
%      singleton*.
%
%      H = COBWEBINTERFAZ returns the handle to a new COBWEBINTERFAZ or the handle to
%      the existing singleton*.
%
%      COBWEBINTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COBWEBINTERFAZ.M with the given input arguments.
%
%      COBWEBINTERFAZ('Property','Value',...) creates a new COBWEBINTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cobwebinterfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cobwebinterfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cobwebinterfaz

% Last Modified by GUIDE v2.5 08-Aug-2018 10:21:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cobwebinterfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @cobwebinterfaz_OutputFcn, ...
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


% --- Executes just before cobwebinterfaz is made visible.
function cobwebinterfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cobwebinterfaz (see VARARGIN)
s='cobwebinterfaz.m';
w=which(s);
w=w(1:end-length(s));
set(handles.dir,'string',w)
% Choose default command line output for cobwebinterfaz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes cobwebinterfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cobwebinterfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calcular.
function calcular_Callback(hObject, eventdata, handles)
% hObject    handle to calcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


cla(handles.axes1,'reset')
f=get(handles.funcion,'string')
v=get(handles.variable,'string')
itera=str2num(get(handles.iteraciones,'string'));
xmin=str2num(get(handles.xminimo,'string'));
xmax=str2num(get(handles.xmaximo,'string'));
f=ajustar(f)
saux=strcat('@(',v,')')
f=str2func(strcat(saux,f))
z=xmin:0.1:xmax
y=f(z); % mapa logistico, a los operadores * y / se les coloca un punto antes .* y ./
axes(handles.axes1);
plot(handles.axes1,z,y)
hold on
plot(z,z)
z=str2num(get(handles.valorini,'string'));
aux=0;
fin=itera; %Cantidad de Iteraciones
while (aux~=z ) 
   aux=z;

plot( [z z], [z f(z)], 'k') %linea vertical

plot( [z f(z)], [f(z) f(z)], 'k') 

z=f(z);
fin=fin-1;
if fin==0
break;
end

end
s='cobweb.m';
w=which(s);
w=w(1:end-length(s));



xlabel('Eje x'),ylabel('Eje y');
% s='cobwebinterfaz.m';
% w=which(s);
% w=w(1:end-length(s));
% 
% save(strcat(w,'funcion.mat'),'xmin','xmax')
%graficas(f,xmin,xmax)

% --- Executes during object creation, after setting all properties.
function funcion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function variable_Callback(hObject, eventdata, handles)
% hObject    handle to variable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of variable as text
%        str2double(get(hObject,'String')) returns contents of variable as a double


% --- Executes during object creation, after setting all properties.
function variable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dir_Callback(hObject, eventdata, handles)
% hObject    handle to dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dir as text
%        str2double(get(hObject,'String')) returns contents of dir as a double


% --- Executes during object creation, after setting all properties.
function dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nomb_Callback(hObject, eventdata, handles)
% hObject    handle to nomb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nomb as text
%        str2double(get(hObject,'String')) returns contents of nomb as a double


% --- Executes during object creation, after setting all properties.
function nomb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nomb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function exten_Callback(hObject, eventdata, handles)
% hObject    handle to exten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exten as text
%        str2double(get(hObject,'String')) returns contents of exten as a double


% --- Executes during object creation, after setting all properties.
function exten_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in guardar.
function guardar_Callback(hObject, eventdata, handles)
cla(handles.axes1,'reset')
f=get(handles.funcion,'string')
v=get(handles.variable,'string')
itera=str2num(get(handles.iteraciones,'string'));
xmin=str2num(get(handles.xminimo,'string'));
xmax=str2num(get(handles.xmaximo,'string'));
f=ajustar(f)
saux=strcat('@(',v,')')
f=str2func(strcat(saux,f))
z=xmin:0.1:xmax
y=f(z); % mapa logistico, a los operadores * y / se les coloca un punto antes .* y ./
F=figure;
plot(z,y)
hold on
plot(z,z)
z=str2num(get(handles.valorini,'string'));
aux=0;
fin=itera; %Cantidad de Iteraciones
while (aux~=z ) 
   aux=z;

plot( [z z], [z f(z)], 'k') %linea vertical

plot( [z f(z)], [f(z) f(z)], 'k') 

z=f(z);
fin=fin-1;
if fin==0
break;
end

end




xlabel('Eje x'),ylabel('Eje y');

saveas(F, strcat( get(handles.dir,'string'),'\',get(handles.nomb,'string'),'.',get(handles.exten,'string')));



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



function xminimo_Callback(hObject, eventdata, handles)
% hObject    handle to xminimo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xminimo as text
%        str2double(get(hObject,'String')) returns contents of xminimo as a double


% --- Executes during object creation, after setting all properties.
function xminimo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xminimo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmaximo_Callback(hObject, eventdata, handles)
% hObject    handle to xmaximo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmaximo as text
%        str2double(get(hObject,'String')) returns contents of xmaximo as a double


% --- Executes during object creation, after setting all properties.
function xmaximo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmaximo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function funcion_Callback(hObject, eventdata, handles)
% hObject    handle to funcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funcion as text
%        str2double(get(hObject,'String')) returns contents of funcion as a double



function valorini_Callback(hObject, eventdata, handles)
% hObject    handle to valorini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valorini as text
%        str2double(get(hObject,'String')) returns contents of valorini as a double


% --- Executes during object creation, after setting all properties.
function valorini_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valorini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in funciontrozos.
function funciontrozos_Callback(hObject, eventdata, handles)
% hObject    handle to funciontrozos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ft
if get(handles.funciontrozos,'Value')
   ft= get(handles.funcion,'String')
    set(handles.funcion,'String','1.5*(x),x<0.5,1.5*((1-x)),0.5<=x')
else
    set(handles.funcion,'String',ft)
    ft= get(handles.funcion,'String')
end


% Hint: get(hObject,'Value') returns toggle state of funciontrozos
