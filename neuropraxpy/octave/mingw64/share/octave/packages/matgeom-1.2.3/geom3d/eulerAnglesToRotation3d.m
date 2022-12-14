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

function mat = eulerAnglesToRotation3d(phi, theta, psi, varargin)
%EULERANGLESTOROTATION3D Convert 3D Euler angles to 3D rotation matrix.
%
%   MAT = eulerAnglesToRotation3d(PHI, THETA, PSI)
%   Creates a rotation matrix from the 3 euler angles PHI THETA and PSI,
%   given in degrees, using the 'XYZ' convention (local basis), or the
%   'ZYX' convention (global basis). The result MAT is a 4-by-4 rotation
%   matrix in homogeneous coordinates.
%
%   PHI:    rotation angle around Z-axis, in degrees, corresponding to the
%       'Yaw'. PHI is between -180 and +180.
%   THETA:  rotation angle around Y-axis, in degrees, corresponding to the
%       'Pitch'. THETA is between -90 and +90.
%   PSI:    rotation angle around X-axis, in degrees, corresponding to the
%       'Roll'. PSI is between -180 and +180.
%   These angles correspond to the "Yaw-Pitch-Roll" convention, also known
%   as "Tait-Bryan angles".
%
%   The resulting rotation is equivalent to a rotation around X-axis by an
%   angle PSI, followed by a rotation around the Y-axis by an angle THETA,
%   followed by a rotation around the Z-axis by an angle PHI.
%   That is:
%       ROT = Rz * Ry * Rx;
%
%   MAT = eulerAnglesToRotation3d(ANGLES)
%   Concatenates all angles in a single 1-by-3 array.
%   
%   ... = eulerAnglesToRotation3d(ANGLES, CONVENTION)
%   CONVENTION specifies the axis rotation sequence. Default is 'ZYX'.
%   Supported conventions are: 
%       'ZYX','ZXY','YXZ','YZX','XYZ','XZY'
%       'ZYZ','ZXZ','YZY','YXY','XZX','XYX'
%
%   Example
%   [n e f] = createCube;
%   phi     = 20;
%   theta   = 30;
%   psi     = 10;
%   rot = eulerAnglesToRotation3d(phi, theta, psi);
%   n2 = transformPoint3d(n, rot);
%   drawPolyhedron(n2, f);
%
%   See also
%   transforms3d, createRotationOx, createRotationOy, createRotationOz
%   rotation3dAxisAndAngle
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-07-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   2011-06-20 rename and use degrees

% Process input arguments
if size(phi, 2) == 3
    if nargin > 1
        varargin{1} = theta;
    end
    % manages arguments given as one array
    psi     = phi(:, 3);
    theta   = phi(:, 2);
    phi     = phi(:, 1);
end

p = inputParser;
validStrings = {...
    'ZYX','ZXY','YXZ','YZX','XYZ','XZY',...
    'ZYZ','ZXZ','YZY','YXY','XZX','XYX'};
addOptional(p,'convention','ZYX',@(x) any(validatestring(x,validStrings)));
parse(p,varargin{:});
convention=p.Results.convention;

% create individual rotation matrices
k = pi / 180;

switch convention
    case 'ZYX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'ZXY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'YXZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'YZX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'XYZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOx(phi * k);
    case 'XZY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOx(phi * k);
    case 'ZYZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'ZXZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'YZY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'YXY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'XZX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOx(phi * k);
    case 'XYX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOx(phi * k);
end

% concatenate matrices
mat = rot3 * rot2 * rot1;
