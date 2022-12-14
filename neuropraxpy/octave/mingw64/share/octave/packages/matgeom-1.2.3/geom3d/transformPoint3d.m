## Copyright (C) 2021 David Legland
## All rights reserved.
## 
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are met:
## 
##     1 Redistributions of source code must retain the above copyright notice,
##       this list of conditions and the following disclaimer.
##     2 Redistributions in binary form must reproduce the above copyright
##       notice, this list of conditions and the following disclaimer in the
##       documentation and/or other materials provided with the distribution.
## 
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ''AS IS''
## AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
## ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR
## ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
## DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
## SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
## CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
## OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
## 
## The views and conclusions contained in the software and documentation are
## those of the authors and should not be interpreted as representing official
## policies, either expressed or implied, of the copyright holders.

function varargout = transformPoint3d(pts, transfo, varargin)
%TRANSFORMPOINT3D Transform a point with a 3D affine transform.
%
%   PT2 = transformPoint3d(PT1, TRANS);
%   PT2 = transformPoint3d(X1, Y1, Z1, TRANS);
%   where PT1 has the form [xp yp zp], and TRANS is a 3-by-3, 3-by-4, or
%   4-by-4 matrix, returns the point transformed according to the affine
%   transform specified by TRANS.
%
%   The function accepts transforms given using the following formats:
%   [a b c]   ,   [a b c j] , or [a b c j]
%   [d e f]       [d e f k]      [d e f k]
%   [g h i]       [g h i l]      [g h i l]
%                                [0 0 0 1]
%
%   PT2 = transformPoint3d(PT1, TRANS) 
%   also work when PT1 is a N-by-3-by-M-by-P-by-ETC array of double. In
%   this case, PT2 has the same size as PT1.
%
%   PT2 = transformPoint3d(X1, Y1, Z1, TRANS);
%   also work when X1, Y1 and Z1 are 3 arrays with the same size. In this
%   case, PT2 will be a 1-by-3 cell containing {X Y Z} outputs of size(X1).
%
%   [X2, Y2, Z2] = transformPoint3d(...);
%   returns the result in 3 different arrays the same size as the input.
%   This form can be useful when used with functions like meshgrid or warp.
%   
%   MESH2 = transformPoint3d(MESH, TRANS) 
%   transforms the field 'vertices' of the struct MESH and returns the same
%   struct with the transformed vertices.
%   (It is recommended to use the function 'transformMesh', within the
%   "meshes3d" module). 
%
%   See also:
%     points3d, transforms3d, transformMesh, createTranslation3d
%     createRotationOx, createRotationOy, createRotationOz, createScaling
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   23/03/2006 add support for non vector point data
%   26/10/2006 better support for large data handling: iterate on points
%       in the case of a memory lack.
%   20/04/2007 add link to rotationXX functions
%   29/09/2010 fix bug in catch case
%   12/03/2011 slightly reduce memory usage


%% Parse input arguments

% Check special case: if first argument is a struct with a field named
% 'vertices', then the output will be the same struct, but with the
% transformed vertices.
if nargin == 2 && isstruct(pts) && isfield(pts, 'vertices')
    mesh = pts;
    mesh.vertices = transformPoint3d(mesh.vertices, transfo);
    varargout = {mesh};
    return;
end

% Parse x, y, and z coordinates of input points from input arguments
if nargin == 2
    % Point coordinates are given in a single N-by-3-by-M-by-etc argument.
    % Preallocate x, y, and z to size N-by-1-by-M-by-etc, then fill them in
    dim = size(pts);
    dim(2) = 1;
    [x, y, z] = deal(zeros(dim, class(pts)));
    x(:) = pts(:,1,:);
    y(:) = pts(:,2,:);
    z(:) = pts(:,3,:);
    
elseif nargin == 4
    % Point coordinates are given in 3 different arrays
    x = pts;
    y = transfo;
    z = varargin{1};
    transfo = varargin{2};
    dim = size(x);
    
else
    error('MatGeom:geom3d:WrongInputArgumentNumber', ...
        'Requires number of input arguments to be either 2 or 4');
end


%% Process transformation matrix

% extract the linear and the translation parts of the matrix
linear = transfo(1:3, 1:3)';
trans = [0 0 0];
if size(transfo, 2) > 3
    trans = transfo(1:3, 4)';
end


%% Main processing

% convert coordinates
try
    % vectorial processing, if there is enough memory.
    % same as: 
    % res = (transfo * [x(:) y(:) z(:) ones(NP, 1)]')';
    res = bsxfun(@plus, [x(:) y(:) z(:)] * linear, trans);
    
    % Back-fill x,y,z with new result (saves calling costly reshape())
    x(:) = res(:,1);
    y(:) = res(:,2);
    z(:) = res(:,3);
    
catch ME
    disp(ME.message)
    % process each point one by one, writing in existing array
    NP = numel(x);
    for i = 1:NP
        res = [x(i) y(i) z(i)] * linear + trans;
        x(i) = res(1);
        y(i) = res(2);
        z(i) = res(3);
    end
end

% process output arguments
if nargout <= 1
    % results are stored in a unique array
    if length(dim) > 2 && dim(2) > 1
        warning('geom3d:shapeMismatch',...
            'Shape mismatch: Non-vector xyz input should have multiple x,y,z output arguments. Cell {x,y,z} returned instead.')
        varargout{1} = {x,y,z};
    else
        varargout{1} = [x y z];
    end
    
elseif nargout == 3
    % results are returned in three array with same size.
    varargout = {x, y, z};
end
