function [adfreq, n, ts, fn, d] = nex_cont(filename, varname)
% nex_cont(filename, varname): Read continuous variable from a .nex file
%
% [adfreq, n, ts, fn, d] = nex_cont(filename, varname)
%
% INPUT:
%   filename - if empty string, will use File Open dialog
%   varname - variable name
%
%           continuous (a/d) data come in fragments. Each fragment has a timestamp
%           and a number of a/d data points. The timestamp corresponds to
%           the time of recording of the first a/d value in this fragment.
%           All the data values stored in the vector d. 
% OUTPUT:
%   n - total number of data points 
%   ts - array of fragment timestamps (one timestamp for fragment, in seconds)
%   fn - number of data points in each fragment
%   d - array of a/d values (in millivolts)

n = 0;
adfreq = 0;
ts = 0;
fn = 0;
d = 0;

if(nargin ~= 2)
   disp('2 input arguments are required')
   return
end

if(ischar(filename) == 0)
   disp('input arguments should be character arrays')
   return
end

if(ischar(varname) == 0)
   disp('input arguments should be character arrays')
   return
end

if(isempty(filename))
   [fname, pathname] = uigetfile('*.nex', 'Select a Nex file');
	filename = strcat(pathname, fname);
end

fid = fopen(filename, 'r');
if(fid == 0)
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
name = zeros(1, 64);
found = 0;
for i=1:nvar
	type = fread(fid, 1, 'int32');
	var_version = fread(fid, 1, 'int32');
	name = fread(fid, [1 64], 'char');
	offset = fread(fid, 1, 'int32');
	nf = fread(fid, 1, 'int32');
	dummy = fread(fid, 32, 'char');
	adfreq = fread(fid, 1, 'double');
	adtomv = fread(fid, 1, 'double');
	n = fread(fid, 1, 'int32');
	name = char(name);
	name = deblank(name);
	k = strcmp(name, deblank(varname));
	if(k == 1)
		if type ~= 5
			disp(sprintf('%s is not a continuous variable', deblank(varname)));
			return;
		end
		found = 1;
		fseek(fid, offset, 'bof');
		ts = fread(fid, [1 nf], 'int32');
		fn = fread(fid, [1 nf], 'int32');
		d = fread(fid, [1 n], 'int16');
		break
	end
	dummy = fread(fid, 76, 'char');
end

fclose(fid);

if found == 0
	disp('did not find variable in the file');
else
	ts = ts/freq;
	d = d*adtomv;
	fn(nf+1) = n;
	fn = diff(fn);
	disp(strcat('number of data points = ', num2str(n)));
end
