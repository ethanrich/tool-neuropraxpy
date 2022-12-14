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

function writeGraph(nodes, edges, fileName)
%WRITEGRAPH Write a graph to an ascii file.
%
%   writeGraph(NODES, EDGES, FILENAME)
%
%   Example
%     % create a basic graph and save it to a file
%     nodes = [10 10;20 10;10 20;20 20;27 15];
%     edges = [1 2;1 3;2 4;2 5;3 4;4 5];
%     writeGraph(nodes, edges, 'simpleGraph.txt');
%
%   See also
%     readGraph
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-01-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.


%% File creation and init

% extract "sizes" of the graph
nNodes = size(nodes, 1);
nEdges = size(edges, 1);
nDims  = size(nodes, 2);

% file opening
f = fopen(fileName, 'wt');
if f == -1
    error(['could not open file for writing: ' fileName]);
end

% write header
fprintf(f, '# graph\n');


%% write nodes info

fprintf(f, '# nodes\n');
fprintf(f, '%d %d\n', nNodes, nDims);
format = ['%g' repmat(' %g', 1, nDims-1) '\n'];
for iNode = 1:nNodes
    fprintf(f, format, nodes(iNode, :));
end

%% write edges info

fprintf(f, '# edges\n');
fprintf(f, '%d\n', nEdges);

format = '%d %d\n';
for iEdge = 1:nEdges
    fprintf(f, format, edges(iEdge, :));
end

% close file
fclose(f);
