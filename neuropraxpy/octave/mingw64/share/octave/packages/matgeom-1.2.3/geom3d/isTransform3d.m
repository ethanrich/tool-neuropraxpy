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

function a = isTransform3d(trans, varargin)
%ISTRANSFORM3D Check if input is a affine transformation matrix.
%
%   A = isTransform3d(TRANS) where TRANS should be a transformation matrix.
%   The function accepts transformations given using the following formats:
%   [a b c]   ,   [a b c j] , or  [a b c j]
%   [d e f]       [d e f k]       [d e f k]
%   [g h i]       [g h i l]       [g h i l]
%                                 [0 0 0 1]
%   
%   If the transformation matrix should only contain rotation and
%   translation without reflection, scaling, shearing, ... set 'rotation'
%   to true. Default is false.
%
%   Example
%     rot = ...
%         createRotationOx(rand*2*pi)*...
%         createRotationOy(rand*2*pi)*...
%         createRotationOx(rand*2*pi);
%     trans = rot*createTranslation3d(rand(1,3));
%     isTransform3d(trans, 'rot', true)
%
%   See also
%   composeTransforms3d, createBasisTransform3d, recenterTransform3d,
%   transformPoint3d
%
% ------
% Author: oqilipo
% Created: 2018-07-08
% Copyright 2018

narginchk(1,5)

p = inputParser;
logParValidFunc = @(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addParameter(p,'rotation', 0, logParValidFunc);
valTol = @(x) validateattributes(x,{'numeric'},{'scalar', '>=',eps(class(trans)), '<=',1});
addParameter(p,'tolerance', 1e-8, valTol);
parse(p,varargin{:});
rotation = p.Results.rotation;
tolerance = p.Results.tolerance;

% eventually add null translation
if size(trans, 2) == 3
    trans = [trans zeros(size(trans, 1), 1)];
elseif size(trans, 2) < 3 || size(trans, 2) > 4
    a=false;
    return
end

% eventually add normalization
if size(trans, 1) == 3
    trans = [trans;0 0 0 1];
elseif size(trans, 1) < 3 || size(trans, 1) > 4
    a=false;
    return
end

a=true;

% NaN is invalid
if any(isnan(trans(:)))
    a=false;
    return
end

% Infinity is invalid
if any(isinf(trans(:)))
    a=false;
    return
end

% trans(4,4) has to be a one
if ~isequal(1, trans(4,4))
    a = false;
    return
end

% trans(4,1:3) have to be zeros
if ~isequal(zeros(1,3), trans(4,1:3))
    a = false;
    return
end

if rotation
    % transpose(trans(1:3,1:3)) * trans(1:3,1:3) has to be eye(3)
    if any(abs(eye(3) - (trans(1:3,1:3)'*trans(1:3,1:3))) > tolerance)
        a = false;
        return;
    end
    
    % determinant of trans(1:3) has to be one
    if abs(1-det(trans)) > tolerance
        a = false;
        return
    end
end

end

