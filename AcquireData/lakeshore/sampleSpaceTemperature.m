%SAMPLESPACETEMPERATURE - Get temperature from LakeShore 335
%
% temp = sampleSpaceTemperature(temp) Read the temperature in the sample space.
% Temperature returned in K.
%
% Options
%
% sampleSpaceTemperature(temp) returns the value for sensor struct.sample.
%
% Todd Karin
% 10/05/2014

%% Modified by George Nelson for setting sensor

function temp = sampleSpaceTemperature(struct)

% Initialize communication to temperature controller.
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 12);
% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 12);
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Get the temperature
fopen(obj1)

sense_string = strcat('KRDG? ',struct.sample);
tempString = sn(query(obj1,sense_string));

%if nargin&&strcmpi(varargin{2},'string')
%    temp = tempString;
%else
temp = str2double(tempString);
%end

% Close communication.
fclose(obj1)
end

% Snip out certain characters
function x =sn(x)
x(x==10)=[];
x(x==13)=[];
end
