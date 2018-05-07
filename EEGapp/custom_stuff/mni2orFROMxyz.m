%% Convert MNI coords to Voxel XYZ (3D matrix) coordinates
%Written by Michael T Rubens, June 4 2008, UC San Francisco, Gazzaley Lab
function [x y z outtype] = mni2orFROMxyz(x, y, z,vs,coordef)
%x  = x coord to convert, OR, 1D index (voxel position, i.e., from find(n))
%y  = y coord to convert, OR, dimensions of matrix (i.e., [91 109 91])
%z  = z coord to convert
%vs = voxel size in mm (default is 2mm)
%       pass in empty z (i.e., z=[]) to use 1D index and custom voxel size
%
% coordef = 'mini' or 'xyz' (string, case-insensitive). Type of input coordinates. (default is 'xyz')
%       pass in empty vs (i.e., vs[]) to use default voxel size and still specify coordinate type

if nargin<3 || isempty(z)
    [x y z] = ind2sub(y,x);
end

if nargin<4 || isempty(vs)
    vs = 2;%2mm
end

if nargin<5
    coordef = 'mni';
end

% MNI origin in voxel coordinates (Anterior Commisure)
% origin = 352852; (origin index)
origin = [45 63 36]; % [X Y Z]

switch lower(coordef)
        case 'mni'
            x=origin(1)- x/vs;
            y=y/vs + origin(2);
            z=z/vs + origin(3);
            
            outtype = 'XYZ';
    case 'xyz'
            x = (origin(1)-x)*vs;
            y = (y-origin(2))*vs;
            z = (z-origin(3))*vs;
            
            outtype = 'MNI';
    otherwise
        error('unknown coordinate definition. Input EITHER ''mni'' or ''xyz''');
end

fprintf('Outputting %s coordinates\n',outtype);

end