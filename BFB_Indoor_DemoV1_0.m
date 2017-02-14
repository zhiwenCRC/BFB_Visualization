function varargout = BFB_Indoor_DemoV1_0(varargin)
%BFB_INDOOR_DEMOV1_0 M-filemenu for BFB_Indoor_DemoV1_0.fig
%      BFB_INDOOR_DEMOV1_0, by itself, creates a new BFB_INDOOR_DEMOV1_0 or raises the existing
%      singleton*.
%
%      H = BFB_INDOOR_DEMOV1_0 returns the handle to a new BFB_INDOOR_DEMOV1_0 or the handle to
%      the existing singleton*.
%
%      BFB_INDOOR_DEMOV1_0('Property','Value',...) creates a new BFB_INDOOR_DEMOV1_0 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to BFB_Indoor_DemoV1_0_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      BFB_INDOOR_DEMOV1_0('CALLBACK') and BFB_INDOOR_DEMOV1_0('CALLBACK',hObject,...) call the
%      local function named CALLBACK in BFB_INDOOR_DEMOV1_0.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to resetbutton (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BFB_Indoor_DemoV1_0

% Last Modified by GUIDE v2.5 08-Feb-2017 09:40:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BFB_Indoor_DemoV1_0_OpeningFcn, ...
                   'gui_OutputFcn',  @BFB_Indoor_DemoV1_0_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

return;

% --- Executes just before BFB_Indoor_DemoV1_0 is made visible.
function BFB_Indoor_DemoV1_0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for BFB_Indoor_DemoV1_0
handles.output = hObject;

handles.App.TxAntSpace = str2double(get(handles.TxAntSpace,'string'));
handles.App.TxAntNum   = str2double(get(handles.TxAntNum,'string'));
handles.App.TxPower    = str2double(get(handles.TxPow,'string'));

handles.App.RxAntSpace = str2double(get(handles.RxAntSpace,'string'));
handles.App.RxAntNum   = str2double(get(handles.RxAntNum,'string'));

handles.App.NoisePower = str2double(get(handles.NoisePower,'string'));

IndexSelected = get(handles.PolarizationSelect,'Value');
MetricsList   = get(handles.PolarizationSelect,'String');
handles.App.Polarization = MetricsList{IndexSelected};

IndexSelected = get(handles.HMMSelect,'Value');
MetricsList = get(handles.HMMSelect,'String');
handles.App.Metrics = MetricsList{IndexSelected};

handles.App.ImprovementCheckbox = 0;
%handles.App.FloorPlanFile = 'C:\UserApplications\Research\WT\BFB\Visual\CRC2C2FloorPlan.png';
%handles.App.DataFile = 'C:\UserApplications\Research\WT\BFB\Visual\CRC2C2Floor26GHz.mat';

handles.App.ColorMapType      = 'cool';
handles.App.TransparentFactor = 0.5;

%set(handles.RunButton,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BFB_Indoor_DemoV1_0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
return;

% --- Outputs from this function are returned to the command line.
function varargout = BFB_Indoor_DemoV1_0_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

set(handles.figure1, 'units','normalized','outerposition',[0 0.03 1 0.97]);
handles.MainAxes = axes('units','normalized','position',[0 0 1 1]);
uistack(handles.MainAxes,'bottom');
img = imread('Ottawa.jpg');
hi = imagesc([0 1],[0 1],img);
set(handles.MainAxes,'handlevisibility','off','visible','off');
set(hi,'alphadata',0.5)

handles.ProjectTitle = text(0.5,0.05, ...
    {'BFB / Spatial Agility Capability Assessment'}, ...
    'Parent',handles.MainAxes, ...
    'HorizontalAlignment', 'center', ...
    'fontname','elephant',...
    'Color','blue','fontunit','normalized','FontSize',0.04);

%set(handles.ProjectTitle,'BackgroundColor',get(gcf,'BackgroundColor'));

set(handles.TxAntNum,'enable', 'off');
set(handles.TxAntSpace,'enable', 'off');
set(handles.TxPow,'enable', 'off');
set(handles.RxAntNum,'enable', 'off');
set(handles.RxAntSpace,'enable', 'off');
set(handles.NoisePower,'enable', 'off');
set(handles.PolarizationSelect,'enable', 'off');
set(handles.HMMSelect,'enable', 'off');
set(handles.MultipathCheckbox,'enable', 'off');
set(handles.ImprovementCheckbox,'enable', 'off');

img = imread('logo_CRC.jpg');
axes(handles.CRCLogoAxis);
imagesc([0 1],[0 1],img)
set(handles.CRCLogoAxis,'xtick',[],'ytick',[],'XColor',[1 1 1],'YColor',[1 1 1],'ZColor',[1 1 1]);

axes(handles.HeatMapAxis)
set(handles.HeatMapAxis,'units','normalized');
axis('off');
set(gca,'Ydir','reverse');
set(gca,'xlim',[0 1],'ylim',[0 1]);
hold('on');

handles.ReminderText = text(0.2,0.5, ...
    {'Please Select:'
    '               '
    '                Floor plan and measurement data files'}, ...
    'Parent',handles.HeatMapAxis, ...
    'HorizontalAlignment', 'left', ...
    'fontname','elephant',...
    'Color','red','fontunit','normalized','FontSize',0.06);


for Idx = 1:4
    set(handles.ReminderText,'color','yellow');
    pause(0.1);
    set(handles.ReminderText,'color','red');
    pause(0.1)
end
guidata(hObject, handles);

return;

% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closeGUI    = handles.figure1; %handles.figure1 is the GUI figure
guiPosition = get(handles.figure1,'Position'); %get the position of the GUI
guiName     = get(handles.figure1,'Name'); %get the name of the GUI
eval(guiName) %call the GUI again
close(closeGUI); %close the old GUI
set(gcf,'Position',guiPosition); %set the position for the new GUI

return;

function TxAntNum_Callback(hObject, eventdata, handles)
% hObject    handle to TxAntNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxAntNum as text
%        str2double(get(hObject,'String')) returns contents of TxAntNum as a double

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.TxAntNum = str2double(get(hObject,'string'));

guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function TxAntNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxAntNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TxAntSpace_Callback(hObject, eventdata, handles)
% hObject    handle to TxAntSpace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxAntSpace as text
%        str2double(get(hObject,'String')) returns contents of TxAntSpace as a double

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.TxAntSpace = str2double(get(hObject,'string'));

% Update handles structure
guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function TxAntSpace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxAntSpace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TxPow_Callback(hObject, eventdata, handles)
% hObject    handle to TxPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.TxPower = str2double(get(hObject,'string'));

guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function TxPow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function RxAntNum_Callback(hObject, eventdata, handles)
% hObject    handle to RxAntNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.RxAntNum   = str2double(get(hObject,'string'));

guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function RxAntNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxAntNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function RxAntSpace_Callback(hObject, eventdata, handles)
% hObject    handle to RxAntSpace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.RxAntSpace = str2double(get(hObject,'string'));

guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function RxAntSpace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxAntSpace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in HMMSelect.
function HMMSelect_Callback(hObject, eventdata, handles)
% hObject    handle to HMMSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

IndexSelected = get(hObject,'Value');
MetricsList = get(hObject,'String');
if strcmp(handles.App.Metrics,MetricsList{IndexSelected}) == 1
    return;
end

handles.App.Metrics = MetricsList{IndexSelected};
if IndexSelected < 3
    set(handles.TxAntNum,'string','1');
    handles.App.TxAntNum = 1;
    set(handles.RxAntNum,'string','1');
    handles.App.RxAntNum = 1;
    set(handles.ImprovementCheckbox,'visible','off');
else
    set(handles.ImprovementCheckbox,'visible','on');
end    
guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function HMMSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HMMSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ResultsWindow_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ResultsWindow as text
%        str2double(get(hObject,'String')) returns contents of ResultsWindow as a double
return;

% --- Executes during object creation, after setting all properties.
function ResultsWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ResultsWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
return;

% --------------------------------------------------------------------
function FloorPlanSelect_Callback(hObject, eventdata, handles)
% hObject    handle to FloorPlanSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

while 1
    [FileStr,PathStr] = uigetfile(...
        { '*.gif;*.;*.png;*.tif;*.bmp;**.jpg','Figure (*.gif,*.png,*.tif ...)'; ...
          '*.*',  'All Files (*.*)'}, ...
          'Select Floor Plan ');

    if FileStr == 0
        return;
    else
        break;
    end
end

img = imread(strcat(PathStr,FileStr));
[PathStr,FileNameStr,~] = fileparts(strcat(PathStr,FileStr));

cla(handles.HeatMapAxis);
axes(handles.HeatMapAxis);
handles.App.CBhandle = colorbar;
set(handles.App.CBhandle,'visible','off')

handles.App.FloorMapHandle = imagesc([0 1],[0 1],img, ...
    'ButtonDownFcn',@(Src, Evt)AppResultDisplayCallback(Src,Evt,hObject,handles));
set(handles.App.FloorMapHandle,'alphadata',0.8)
drawnow
hold on


% t2 = get(handles.HeatMapAxis,'position');
% axis square
% 
% [y1,x1,~] = size(img);
% t1 = get(0,'screensize');
% 
% RatioAxis = y1/x1;
% 
% if RatioAxis > 1
%     set(handles.HeatMapAxis,'position',[t2(1) t2(2) t2(3)/RatioAxis t2(4)]);
% else
%     set(handles.HeatMapAxis,'position',[t2(1) t2(2) t2(3) t2(4)*RatioAxis]);
% end
% t21 = get(handles.HeatMapAxis,'position');
%     set(handles.HeatMapAxis,'position',[t2(1) t2(2) t21(3)*t1(3)/t1(4) t21(4)]);

handles.App.FloorPlanFile = fullfile(PathStr,FileStr);
handles.App.FloorMaskFile = fullfile(PathStr, [FileNameStr '.mat']);

set(handles.HeatMapAxis,'xtick',[],'ytick',[], ...
    'XColor',[1 1 1],'YColor',[1 1 1],'ZColor',[1 1 1]);

while 1
    [FileStr,PathStr] = uigetfile(...
        { '*.mat','MAT -file (*.mat)'; ...
        '*.*',  'All Files (*.*)'}, ...
        'Select Measurement Data File');

    if FileStr == 0
        return;
    else
        break;
    end
end

handles.App.DataFile = fullfile(PathStr,FileStr);
handles.App = MIMOperformanceAnalyzer(handles.App);
%handles.App.CapacityBenchMark = handles.App.SiteCapacity;

set(handles.TxAntNum,'enable', 'on');
set(handles.TxAntSpace,'enable', 'on');
set(handles.TxPow,'enable', 'on');
set(handles.RxAntNum,'enable', 'on');
set(handles.RxAntSpace,'enable', 'on');
set(handles.NoisePower,'enable', 'on');
set(handles.PolarizationSelect,'enable', 'on');
set(handles.HMMSelect,'enable', 'on');
set(handles.MultipathCheckbox,'enable', 'on');
set(handles.ImprovementCheckbox,'enable', 'on');

guidata(hObject, handles);
AppDisplayMultipath(hObject);
handles = guidata(hObject);

set(handles.RunButton,'Enable','on');
delete(handles.ReminderText);

guidata(hObject, handles);

return;

% --- Executes on selection change in PolarizationSelect.
function PolarizationSelect_Callback(hObject, eventdata, handles)
% hObject    handle to PolarizationSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

IndexSelected = get(hObject,'Value');
MetricsList = get(hObject,'String');
if strcmp(handles.App.Polarization,MetricsList{IndexSelected}) == 1
    return;
end

handles.App.Polarization = MetricsList{IndexSelected};

% Update handles structure
guidata(hObject, handles);

return;

% --- Executes during object creation, after setting all properties.
function PolarizationSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PolarizationSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function NoisePower_Callback(hObject, eventdata, handles)
% hObject    handle to NoisePower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.NoisePower = str2double(get(hObject,'string'));
guidata(hObject, handles);
return;

% --- Executes during object creation, after setting all properties.
function NoisePower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoisePower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in RunButton.
function RunButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppDisableGUI(hObject);
AppCleanPlot(hObject);
AppMetricCal(hObject);
AppHeatMapPlot(hObject);
AppEnableGUI(hObject);
return;

% --------------------------------------------------------------------
function ConfigurationMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ConfigurationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

return;

% --------------------------------------------------------------------
function TransparentFactorSubMenu_Callback(hObject, eventdata, handles)
% hObject    handle to TransparentFactorSubMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% TFList = {'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'};
% [SelectedIdx,Flag] = listdlg('PromptString','Select tramsparent factor:',...
%                 'SelectionMode','single',...
%                 'ListString',TFList);

prompt={'Enter Transparent Factor [0 1]:'};
dlg_title = 'Transparent Factor';
num_lines = 1;
def = {'0.5'};
TF = inputdlg(prompt,dlg_title,num_lines,def);

if ~isempty(TF)
    TF = str2double(TF);
    if TF >= 0 && TF <= 1
        handles.App.TransparentFactor = TF;
        guidata(hObject,handles);
        AppCleanPlot(hObject);
        handles = guidata(hObject);
    end
end

guidata(hObject, handles);
return;

% --- Executes on button press in ImprovementCheckbox.
function ImprovementCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to ImprovementCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ImprovementCheckbox

AppCleanPlot(hObject);
handles = guidata(hObject);

handles.App.ImprovementCheckbox = get(hObject,'Value');
guidata(hObject, handles);

return;

function AppMetricCal(hObject)

handles = guidata(hObject);

load(handles.App.FloorMaskFile);
[Xq,Yq] = meshgrid(0.0005:0.001:1, 0.001:0.002:1);
[Ynm,Xnm] = size(CRCMapping);
[Xg,Yg] = meshgrid((0:Xnm-1)/(Xnm-1), (0:Ynm-1)/Ynm);
CRCMapping(CRCMapping == 0) = NaN;
FloorPlanMasking = interp2(Xg,Yg,CRCMapping,Xq,Yq,'linear');

handles.App = MIMOperformanceAnalyzer(handles.App);
MeasureMetrics = [handles.App.SitePowerdensity handles.App.SiteSNR handles.App.SiteCapacity];
for Idx = 1:3
    F1 = scatteredInterpolant(handles.App.Rxpositions(:,1),handles.App.Rxpositions(:,2),MeasureMetrics(:,Idx));
    handles.App.PlotMetricData(:,:,Idx) = F1(Xq,Yq).*FloorPlanMasking;
end

if handles.App.ImprovementCheckbox == 1 && strcmpi(handles.App.Metrics,'capacity') == 1
    F1 = scatteredInterpolant(handles.App.Rxpositions(:,1),handles.App.Rxpositions(:,2),... 
        MeasureMetrics(:,3) - handles.App.CapacityBenchMark);
    handles.App.PlotDeltaMetricData = F1(Xq,Yq).*FloorPlanMasking;
end
guidata(hObject,handles);
return;

function AppHeatMapPlot(hObject)

handles = guidata(hObject);
axes(handles.HeatMapAxis);
switch(lower(handles.App.Metrics))
    case 'power'
        MetricData = handles.App.PlotMetricData(:,:,1);
        handles.App.ColorMapType = 'hot';
        set(handles.HeatMapText,'visible','on')
        set(handles.HeatMapText,'string','Power Density (dBm/Hz)');
    case 'snr'
        MetricData = handles.App.PlotMetricData(:,:,2);
        handles.App.ColorMapType = 'cool';
        set(handles.HeatMapText,'visible','on')
        set(handles.HeatMapText,'string','SNR (dB)');
    case 'capacity'
        if handles.App.ImprovementCheckbox == 0
            MetricData = handles.App.PlotMetricData(:,:,3);
            handles.App.ColorMapType = 'parula';
            set(handles.HeatMapText,'visible','on')
            set(handles.HeatMapText,'string','Capacity (bps/Hz)');
        else
            MetricData = handles.App.PlotDeltaMetricData;
            handles.App.ColorMapType = 'autumn';
            set(handles.HeatMapText,'visible','on')
            set(handles.HeatMapText,'string','Capacity Improvement (bps/Hz)');
        end
end

TransparentFactor = handles.App.TransparentFactor;
colormap(handles.HeatMapAxis,handles.App.ColorMapType);

set(handles.HeatMapAxis,'color','none','xtick',[],'ytick',[], ...
    'XColor',[1 1 1],'YColor',[1 1 1],'ZColor',[1 1 1]);

CBhandle = handles.App.CBhandle;

set(CBhandle,'visible','on')
HMHandle = imagesc([0 1],[0 1],MetricData, ...
    'ButtonDownFcn',@(Src, Evt)AppResultDisplayCallback(Src,Evt,hObject,handles));

set(HMHandle,'alphadata',~isnan(MetricData)*TransparentFactor)
drawnow

% Make the colorbar transparent
cdata = CBhandle.Face.Texture.CData;
cdata(end,:) = uint8(TransparentFactor*cdata(end,:));
CBhandle.Face.Texture.ColorType = 'truecoloralpha';
CBhandle.Face.Texture.CData = cdata;

handles.App.HMHandle = HMHandle;
handles.App.CBhandle = CBhandle;
guidata(hObject, handles);
return;

function AppResultDisplayCallback(Src,Evt,hObject,handles)

handles = guidata(hObject);
try
    delete(handles.App.LocMarker);
end

set(handles.ResultsWindow,'string',' ');
set(handles.MultipathCheckbox,'Value',0);
try
    for Idx = 1:numel(handles.App.MPPatchhdl)
        set(handles.App.MPPatchhdl(Idx),'visible','off');
    end
end

switch get(gcf,'SelectionType')
    case 'extend'  % shift left or bith left and right
        if get(handles.TxAntennaSweep,'Value') == 1 
            try
                uistack(handles.App.HMHandle,'bottom');
            end
            try
                uistack(handles.App.FloorMapHandle,'bottom');
            end
            
            PauseReminder = text(0.5,0.85, ...
                {'Press Key OR Click Mouse Button to Continue'}, ...
                'Parent',handles.MainAxes, ...
                'HorizontalAlignment', 'center', ...
                'fontname','elephant',...
                'Color','blue','fontunit','normalized','FontSize',0.03);
            
            for Idx = 1:4
                set(PauseReminder,'color','yellow');
                pause(0.1);
                set(PauseReminder,'color','blue');
                pause(0.1)
            end
            
            waitforbuttonpress;
            delete(PauseReminder);
        end
    case 'open'  % double click
        axes(handles.HeatMapAxis);
        
        CPoint = get(gca,'CurrentPoint');
        CPoint = CPoint(1,1:2,1);
        dist = kron(CPoint,ones(size(handles.App.Rxpositions,1),1)) ...
            - handles.App.Rxpositions;
        [~,ClosestIdx] = min(sum(dist.^2,2));

    	axes(handles.App.MPAxehdl);
        
        for Idx = 1:12
            set(handles.App.MPPatchhdl((ClosestIdx-1)*12+Idx),'visible','on');
        end
        tStrongpaths = handles.App.Strongpaths(:,:,ClosestIdx).';
        tStrongpaths(2,:)=20*log10(abs(tStrongpaths(2,:)));
        tStrongpaths = tStrongpaths([1,4,3,5,2],:);
                
        set(handles.ResultsWindow,'string',{sprintf('DoA[m,s]  / DoD[m,s]  / Gain(dB)')
            sprintf('%6.1f,%5.1f/%6.1f,%5.1f/%6.1f\n',tStrongpaths)},...
            'HorizontalAlignment','left');
        
    case 'alt'  % click right
        axes(handles.HeatMapAxis);
        if isfield(handles.App,'PlotMetricData') == 0
           return;
        end
        [Nx,Ny] = size(handles.App.PlotMetricData(:,:,1));
        CPoint = get(gca,'CurrentPoint');
        [X,Y]   = meshgrid(1/2/Ny:1/Ny:1,1/2/Nx:1/Nx:1);
        [Xq,Yq] = meshgrid(CPoint(1,1),CPoint(1,2));

        handles.App.LocMarker = text(CPoint(1,1),CPoint(1,2),...
            'x','fontsize',14,'color','r');

        Mpow = interp2(X,Y,handles.App.PlotMetricData(:,:,1),Xq,Yq);
        Msnr = interp2(X,Y,handles.App.PlotMetricData(:,:,2),Xq,Yq);
        Mcap = interp2(X,Y,handles.App.PlotMetricData(:,:,3),Xq,Yq);
        if handles.App.ImprovementCheckbox == 1
            Mdlt = interp2(X,Y,handles.App.PlotDeltaMetricData,Xq,Yq);
        end
        
        switch(lower(handles.App.Metrics))
            case 'power'
                set(handles.ResultsWindow,'string',{sprintf('Pathloss = %.2f dB', handles.App.TxPower-Mpow), ...
                    ' ', ...
                    sprintf('Power = %.2f dBm/Hz', Mpow)},...
                    'HorizontalAlignment','left');
            case 'snr'
                set(handles.ResultsWindow,'string',{...
                    sprintf('Pathloss = %.2f dB', handles.App.TxPower-Mpow), ...
                    ' ', ...
                    sprintf('SNR = %.2f dB', Msnr)},...
                    'HorizontalAlignment','left');
            case 'capacity'
                if handles.App.ImprovementCheckbox == 0
                    set(handles.ResultsWindow,'string',{...
                        sprintf('Pathloss = %.2f dB', handles.App.TxPower-Mpow), ...
                        ' ', ...
                        sprintf('SNR = %.2f dB', Msnr), ...
                        ' ', ...
                        sprintf('Capacity = %.2f bps/Hz', Mcap)},...
                        'HorizontalAlignment','left');
                else
                    set(handles.ResultsWindow,'string',{...
                        sprintf('Pathloss = %.2f dB', handles.App.TxPower-Mpow), ...
                        sprintf('SNR = %.2f dB', Msnr), ...
                        sprintf('Capacity = %.2f bps/Hz', Mcap),...
                        sprintf('Capacity Improvement = %.2f bps/Hz', Mdlt)},...
                        'HorizontalAlignment','left');
                end
                    
        end
end
guidata(hObject, handles);
return

function AppCleanPlot(hObject)

handles = guidata(hObject);
axes(handles.HeatMapAxis);
set(handles.MultipathCheckbox,'Value',0);

try    
    for MPIdx = 1:handles.App.MPPatchNum
        set(handles.App.MPPatchhdl(MPIdx),'visible','off')
    end
    delete(handles.App.HMHandle);
    set(handles.App.CBhandle,'visible','off');
end
try
    delete(handles.App.LocMarker);
end

set(handles.HeatMapText,'visible','off')
set(handles.ResultsWindow,'string','');
guidata(hObject, handles);
return;

function Parameter = MIMOperformanceAnalyzer(Parameter)
%
%  To analyze the MIMO system performance
%   Input:
%       Parameter = Structure
%                   .TxAntNum
%                   .TxAntSpace, in wavelength
%                   .TxPower, in dBm/Hz
%                   .RxAntNum
%                   .RxAntSpace, in wavelength
%                   .NoisePower, in dBm/Hz
%                   .Polarization, either "Vertical" or "Horizontal"
%                   .Metrics
%                   .Datafile, string
%
%   Output: 
%       Add .Txposition  (x,y)
%           .Rxpositions (x,y,sites)
%           .Strongpaths ([dod gain doa], [top 6 multipaths], sites)
%           .SitePowerdensity (dBm/hz)
%           .SiteSNR   (dB)
%           .SiteCapacity(bps/Hz)]
%

load(Parameter.DataFile);

Parameter.Txposition  = [0.046721	0.30566];
Parameter.Rxpositions = [0.937705	0.39434
0.877869	0.656604
0.930328	0.628302
0.868852	0.120755
0.790984	0.396226
0.590984	0.14717
0.540984	0.450943
0.455738	0.15283
0.669672	0.281132
0.722131	0.526415
0.792623	0.254717
0.729508	0.166038
0.54918     0.666038
0.309016	0.462264
0.361475	0.639623
0.22377     0.632075
0.120492	0.643396
0.236885	0.460377
0.104098	0.445283
0.219672	0.173585
0.308197	0.111321
0.155738	0.126415
0.069672	0.122642
0.27541     0.318868
0.417213	0.311321
0.420492	0.5
0.286066	0.564151
0.372131	0.403774
0.481148	0.650943
0.552459	0.230189
0.731148	0.828302
0.641803	0.409434
0.32377	    0.249057
0.116393	0.20566
0.045082	0.396226];

lambda = 1;

TxArray = (1:Parameter.TxAntNum)*Parameter.TxAntSpace;
RxArray = (1:Parameter.RxAntNum)*Parameter.RxAntSpace;

TxSNR = 10^(0.1*(Parameter.TxPower-Parameter.NoisePower)); %dB to linear

ChannelCapacityBenchMark = zeros(35,1);
ChannelCapacity = zeros(35,1);
PowerDensity = zeros(35,1);
SNR = zeros(35,1);

for site = 1:35
    switch lower(Parameter.Polarization)
        case 'vertical'
            eval(['MPC = V',int2str(site),';'])
        case 'horizontal'
            eval(['MPC = H',int2str(site),';'])
        otherwise
            return
    end
    theta = MPC(:,1);
    gain = MPC(:,2);
    phi = MPC(:,3);
    K = length(gain);
    pathgain = abs(sum(gain))^2;
    SNR(site) = TxSNR*pathgain;
    PowerDensity(site) = Parameter.TxPower + 10*log10(pathgain);
    
    H = MIMOChannelModel(Parameter.TxAntNum,Parameter.RxAntNum,K,lambda,TxArray,RxArray,theta,gain,phi);
    ChannelCapacity(site) = log2(abs(det(eye(Parameter.RxAntNum)+TxSNR*(H*H'))));
    ChannelCapacityBenchMark(site) = log2(abs(det(eye(Parameter.RxAntNum)+TxSNR*(H(1,1)*H(1,1)'))));
    
    Parameter.Strongpaths(:,:,site) = [theta(1:6),gain(1:6),phi(1:6),MPC(1:6,4:5)];
    
end

Parameter.SitePowerdensity = PowerDensity; %dBm/Hz
Parameter.SiteSNR = 10*log10(SNR); %dB
Parameter.SiteCapacity = ChannelCapacity; %bps/Hz
Parameter.CapacityBenchMark = ChannelCapacityBenchMark;
return

function H = MIMOChannelModel(M,N,K,lambda,dTx,dRx,theta,gain,phi)

%   Construct MIMO channel from propagation and antenna characteristics
H = zeros(N,M);

for n=1:N
    for m=1:M
        for k=1:K
            H(n,m) = H(n,m) + ...
                exp(2i*pi/lambda*dTx(m)*sin(theta(k)/180*pi))*gain(k)* ...
                exp(2i*pi/lambda*dRx(n)*sin(phi(k)/180*pi));
        end
    end
    
end

H = H/sqrt(M);
return

% --- Executes on button press in MultipathCheckbox.
function MultipathCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to MultipathCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppDisableGUI(hObject);
handles = guidata(hObject);

try 
    if get(handles.MultipathCheckbox,'Value') == 1
        axes(handles.App.MPAxehdl);
        
        for MPIdx = 1:handles.App.MPPatchNum
            set(handles.App.MPPatchhdl(MPIdx),'visible','on')
        end
    else
        for MPIdx = 1:handles.App.MPPatchNum
            set(handles.App.MPPatchhdl(MPIdx),'visible','off')
        end
    end
end
guidata(hObject,handles);
AppEnableGUI(hObject);

guidata(hObject, handles);
return;

function AppDisableGUI(hObject)

handles = guidata(hObject);

set(handles.FileMenu,'enable', 'off');
set(handles.ConfigurationMenu,'enable', 'off');

set(handles.RunButton,'enable', 'off');
set(handles.ResetButton,'enable', 'off');

set(handles.TxAntNum,'enable', 'off');
set(handles.TxAntSpace,'enable', 'off');
set(handles.TxPow,'enable', 'off');
set(handles.RxAntNum,'enable', 'off');
set(handles.RxAntSpace,'enable', 'off');
set(handles.NoisePower,'enable', 'off');
set(handles.PolarizationSelect,'enable', 'off');
set(handles.HMMSelect,'enable', 'off');
set(handles.MultipathCheckbox,'enable', 'off');
set(handles.ImprovementCheckbox,'enable', 'off');
set(handles.TxAntennaSweep,'enable', 'off');
try
    delete(handles.App.LocMarker)
end

guidata(hObject, handles);
return;

function AppEnableGUI(hObject)

handles = guidata(hObject);

set(handles.FileMenu,'enable', 'on');
set(handles.ConfigurationMenu,'enable', 'on');

set(handles.RunButton,'enable', 'on');
set(handles.ResetButton,'enable', 'on');

set(handles.TxAntNum,'enable', 'on');
set(handles.TxAntSpace,'enable', 'on');
set(handles.TxPow,'enable', 'on');
set(handles.RxAntNum,'enable', 'on');
set(handles.RxAntSpace,'enable', 'on');
set(handles.NoisePower,'enable', 'on');
set(handles.PolarizationSelect,'enable', 'on');
set(handles.HMMSelect,'enable', 'on');
set(handles.MultipathCheckbox,'enable', 'on');
set(handles.ImprovementCheckbox,'enable', 'on');
set(handles.TxAntennaSweep,'enable', 'on');

guidata(hObject, handles);
return;

function AppDisplayMultipath(hObject)

AppDisableGUI(hObject);
handles = guidata(hObject);

ColorList = {'r','k','m','c','b','g'};

handles.App.MPAxehdl = axes('position',get(handles.HeatMapAxis,'position'),...
    'xlim',get(handles.HeatMapAxis,'xlim'),...
    'ylim',get(handles.HeatMapAxis,'ylim'),...
    'Ydir',get(handles.HeatMapAxis,'Ydir')...
    );
axis('off')
colormap(handles.App.MPAxehdl,jet);
YRatio = get(handles.App.MPAxehdl,'PlotBoxAspectRatio');
YRatio = 1/YRatio(2);
PlotLen = 0.05;
MeasureNum = numel(handles.App.Rxpositions(:,1));
TxPos      = handles.App.Txposition;

tGain = max(abs(squeeze(handles.App.Strongpaths(:,2,:))));
Lmax = max(tGain);
Lmin = min(tGain);

PIdx = 0;
for MPIdx = 1:MeasureNum
    Strongpaths = handles.App.Strongpaths(:,:,MPIdx);
    Strongpaths(:,2) = abs(Strongpaths(:,2));

    MeasurePos = handles.App.Rxpositions(MPIdx,:);
    
    for tIdx = 1:min(size(Strongpaths,1),6)
        SegCenter = Strongpaths(tIdx,1)';
        Delta = Strongpaths(tIdx,4)';
        XLen = PlotLen*(0.4+(Strongpaths(tIdx,2)'-Lmin)/(Lmax-Lmin)*0.6);
%        XLen = PlotLen*Strongpaths(tIdx,2)';
        YLen = XLen*YRatio;
        X = TxPos(1)+[zeros(1,1)
            XLen.*cosd(SegCenter-Delta/2)
            XLen.*cosd(SegCenter+Delta/2)];
        Y = TxPos(2)+[zeros(1,1)
            YLen.*sind(SegCenter-Delta/2)
            YLen.*sind(SegCenter+Delta/2)];
        
        Color = [zeros(1,1); XLen; XLen];
        PIdx = PIdx + 1;
        handles.App.MPPatchhdl(PIdx) = patch(X,Y,Color,'FaceAlpha',0.8, ...
            'EdgeColor',ColorList{tIdx},'linewidth',1);        

        SegCenter = Strongpaths(tIdx,3)';
        Delta     = Strongpaths(tIdx,5)';

        X = MeasurePos(1)+[zeros(1,1)
            XLen.*cosd(SegCenter-Delta/2)
            XLen.*cosd(SegCenter+Delta/2)];
        Y = MeasurePos(2)+[zeros(1,1)
            YLen.*sind(SegCenter-Delta/2)
            YLen.*sind(SegCenter+Delta/2)];
        
        Color = [zeros(1,1); XLen; XLen];
        
        PIdx = PIdx + 1;
        handles.App.MPPatchhdl(PIdx) = patch(X,Y,Color,'FaceAlpha',0.8,...
            'EdgeColor',ColorList{tIdx},'linewidth',1);
    end
    drawnow
end
handles.App.MPPatchNum = PIdx;
set(handles.MultipathCheckbox,'Value',1);

guidata(hObject,handles);
AppEnableGUI(hObject);
handles = guidata(hObject);
guidata(hObject, handles);
return;

% --- Executes on button press in TxAntennaSweep.
function TxAntennaSweep_Callback(hObject, eventdata, handles)
% hObject    handle to TxAntennaSweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AppDisableGUI(hObject);
handles = guidata(hObject);

try
    for Idx = 1:numel(handles.App.MPPatchhdl)
        set(handles.App.MPPatchhdl(Idx),'visible','off');
    end
end
set(handles.MultipathCheckbox,'Value',0);
try
    set(handles.App.HMHandle,'visible','off');
    set(handles.App.CBhandle,'visible','off');
end

handles.App.MPTxAxehdl = axes('position',get(handles.HeatMapAxis,'position'),...
    'xlim',get(handles.HeatMapAxis,'xlim'),...
    'ylim',get(handles.HeatMapAxis,'ylim'),...
    'Ydir',get(handles.HeatMapAxis,'Ydir'),...
    'ButtonDownFcn',@(Src, Evt)AppResultDisplayCallback(Src,Evt,hObject,handles) ...
    );
axes(handles.App.MPTxAxehdl);
axis('off')

YRatio = get(handles.App.MPTxAxehdl,'PlotBoxAspectRatio');
YRatio = 1/YRatio(2);
PlotLen = 0.05;
MeasureNum = numel(handles.App.Rxpositions(:,1));
TxPos      = handles.App.Txposition;

SegCenterC = 0:10:360;
TxDelta    = 30;

tGain = max(abs(squeeze(handles.App.Strongpaths(:,2,:))));
Lmax = max(tGain);
Lmin = min(tGain);

for TxDir = 1:length(SegCenterC);
    TxSegCenter = SegCenterC(TxDir);
    XLen = PlotLen;
    YLen = XLen*YRatio;
    
    Xt = TxPos(1)+[zeros(1,1)
        XLen.*cosd(TxSegCenter-TxDelta/2)        
        XLen*1.15.*cosd(TxSegCenter-TxDelta/4)
        XLen*1.2.*cosd(TxSegCenter)        
        XLen*1.15.*cosd(TxSegCenter+TxDelta/4)
        XLen.*cosd(TxSegCenter+TxDelta/2)];
    Yt = TxPos(2)+[zeros(1,1)
        YLen.*sind(TxSegCenter-TxDelta/2)
        YLen*1.15.*sind(TxSegCenter-TxDelta/4)
        YLen*1.2.*sind(TxSegCenter)
        YLen*1.15.*sind(TxSegCenter+TxDelta/4)
        YLen.*sind(TxSegCenter+TxDelta/2)];
    
    Colort = [zeros(1,1); XLen; XLen; XLen; XLen; XLen];

    X = []; Y = []; Color = [];
    
    for MPIdx = 1:MeasureNum
        Strongpaths = handles.App.Strongpaths(:,:,MPIdx);
        Strongpaths(:,2) = abs(Strongpaths(:,2));
              
        MeasurePos = handles.App.Rxpositions(MPIdx,:);
        
        tDiff = abs(Strongpaths(:,1) - TxSegCenter);
        tDiff(tDiff>180) = 360 - tDiff(tDiff>180);
        IdxC = (tDiff <=TxDelta/2);
        
        XLen = PlotLen*(0.3+(Strongpaths(IdxC,2)'-Lmin)/(Lmax-Lmin)*0.7);
        YLen = XLen*YRatio;

        nCluster = sum(IdxC);
        if nCluster == 1
            continue;
        end
        SegCenter = Strongpaths(IdxC,3)';
        Delta     = Strongpaths(IdxC,5)';
        
        X = [X ...
            MeasurePos(1)+[zeros(1,nCluster)
            XLen.*cosd(SegCenter-Delta/2)
            XLen.*cosd(SegCenter+Delta/2)]];
        Y = [Y ... 
            MeasurePos(2)+[zeros(1,nCluster)
            YLen.*sind(SegCenter-Delta/2)
            YLen.*sind(SegCenter+Delta/2)]];
        
%        Color = [Color repmat([zeros(1,1); XLen; XLen],[1,nCluster])];
        Color = [Color [zeros(1,nCluster); XLen; XLen]];
    end
    try
        delete(handles.App.MPTxPatchhdl1)
        delete(handles.App.MPTxPatchhdl2)
    end
    uistack(handles.App.FloorMapHandle,'bottom')
    axes(handles.App.MPTxAxehdl);
    colormap(handles.App.MPTxAxehdl,jet);
    handles.App.MPTxPatchhdl1 = patch(Xt,Yt,Colort,'FaceAlpha',1, ...
        'EdgeColor','r','linewidth',1);
    handles.App.MPTxPatchhdl2 = patch(X,Y,Color,'FaceAlpha',1,...
            'EdgeColor','r','linewidth',1);
    pause(0.2)
    drawnow
end

PauseReminder = text(0.5,0.85, ...
    {'Press Key OR Click Mouse Button to Continue'}, ...
    'Parent',handles.MainAxes, ...
    'HorizontalAlignment', 'center', ...
    'fontname','elephant',...
    'Color','blue','fontunit','normalized','FontSize',0.03);

for Idx = 1:4
    set(PauseReminder,'color','yellow');
    pause(0.1);
    set(PauseReminder,'color','blue');
    pause(0.1)
end

waitforbuttonpress;
delete(PauseReminder);
try
   delete(handles.App.MPTxPatchhdl1)
   delete(handles.App.MPTxPatchhdl2)
end
try
    set(handles.App.HMHandle,'visible','on');
    set(handles.App.CBhandle,'visible','on');
end

guidata(hObject,handles);
AppEnableGUI(hObject);
handles = guidata(hObject);
guidata(hObject, handles);

return;
