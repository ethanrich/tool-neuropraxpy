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

function [vertices, faces] = removeInvalidBorderFaces(varargin)
%REMOVEINVALIDBORDERFACES Remove faces whose edges are connected to 3, 3, and 1 faces.
%
%   [V2, F2] = removeInvalidBorderFaces(V, F)
%
%   Example
%   removeInvalidBorderFaces
%
%   See also
%     isManifoldMesh, collapseEdgesWithManyFaces
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-31,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.

vertices = varargin{1};
faces = varargin{2};

% compute edge to vertex array
if nargin == 3
    edges = faces;
    faces = varargin{3};
else
    % compute edge to vertex array
    edges = meshEdges(faces);
end

% compute face to edge indices array
% as a nFaces-by-3 array (each face connected to exactly three edges)
faceEdgeInds = meshFaceEdges(vertices, edges, faces);

% compute number of faces incident each edge
edgeFaces = trimeshEdgeFaces(faces);
edgeFaceDegrees = sum(edgeFaces > 0, 2);

% for each face, concatenate the face degree of each edge
faceEdgeDegrees = zeros(size(faces, 1), 3);
for iFace = 1:size(faces, 1)
    edgeInds = faceEdgeInds{iFace};
    faceEdgeDegrees(iFace, :) = edgeFaceDegrees(edgeInds);
end

% remove faces containing edges connected to 1 face and edges connected to
% 3 faces
inds = sum(faceEdgeDegrees == 1, 2) > 0 & sum(faceEdgeDegrees == 3, 2);
% inds = sum(ismember(faceEdgeDegrees, [1 3 4]), 2) == 3;
faces(inds, :) = [];