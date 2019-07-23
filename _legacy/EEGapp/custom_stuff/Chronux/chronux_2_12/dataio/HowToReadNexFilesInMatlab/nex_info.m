function [nvar, names, types] = nex_info(filename)
% nex_info(filename) -- read and display .nex file info
%
% [nvar, names, types] = nex_info(filename)
%
% INPUT:
%   filename - if empty string, will use File Open dialog
% OUTPUT:
%   nvar - number of variables in the file
%   names - [nvar 64] array of variable names
%   types - [1 nvar] array of variable types
%           Interpretation of type values: 0-neuron, 1-event, 2-interval, 3-waveform, 
%                        4-population vector, 5-continuous variable, 6 - marker

if(nargin ~= 1)
   disp('1 input arguments are required')
   return
end

if(isempty(filename))
   [fname, pathname] = uigetfile('*.nex', 'Select a Nex file');
	filename = strcat(pathname, fname);
end

fid = fopen(filename, 'r');
if(fid == -1)
	disp('cannot open file');
   return
end

disp(strcat('file = ', filename));
magic = fread(fid, 1, 'int32');
version = fread(fid, 1, 'int32');
comment = fread(fid, 256, 'char');
freq = fread(fid, 1, 'double');
tbeg = fread(fid, 1, 'int32');
tend = fread(fid, 1, 'int32');
nvar = fread(fid, 1, 'int32');
fseek(fid, 260, 'cof');
disp(strcat('version = ', num2str(version)));
disp(strcat('frequency = ', num2str(freq)));
disp(strcat('duration (sec) = ', num2str((tend - tbeg)/freq)));
disp(strcat('number of variables = ', num2str(nvar)));
names = zeros(1, 64);
types=zeros(nvar);
for i=1:nvar
	types(i) = fread(fid, 1, 'int32');
	var_version = fread(fid, 1, 'int32');
	names(i, :) = fread(fid, [1 64], 'char');
	dummy = fread(fid, 128+8, 'char');
end
names = char(names);
fclose(fid);
