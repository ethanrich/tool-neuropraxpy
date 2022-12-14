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

function edges = knnGraph(nodes, varargin)
%KNNGRAPH Create the k-nearest neighbors graph of a set of points.
%
%   EDGES = knnGraph(NODES)
%
%   Example
%   nodes = rand(10, 2);
%   edges = knnGraph(nodes);
%   drawGraph(nodes, edges);
%
%   See also
%     graphs

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-07-28,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% get number of neighbors for each node
k = 2;
if ~isempty(varargin)
    k = varargin{1};
end

% init size of arrays
n       = size(nodes, 1);
edges   = zeros(k*n, 2);

% iterate on nodes
for i = 1:n
    dists = distancePoints(nodes(i,:), nodes);
    [dists, inds]    = sort(dists); %#ok<ASGLU>
    for j = 1:k
        edges(k*(i-1)+j, :) = [i inds(j+1)];
    end
end

% remove double edges
edges = unique(sort(edges, 2), 'rows');
