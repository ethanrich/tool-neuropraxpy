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

function pos = linePosition(point, line, varargin)
%LINEPOSITION Position of a point on a line.
%
%   POS = linePosition(POINT, LINE);
%   Computes position of point POINT on the line LINE, relative to origin
%   point and direction vector of the line.
%   LINE has the form [x0 y0 dx dy],
%   POINT has the form [x y], and is assumed to belong to line.
%
%   POS = linePosition(POINT, LINES);
%   If LINES is an array of NL lines, return NL positions, corresponding to
%   each line.
%
%   POS = linePosition(POINTS, LINE);
%   If POINTS is an array of NP points, return NP positions, corresponding
%   to each point.
%
%   POS = linePosition(POINTS, LINES);
%   If POINTS is an array of NP points and LINES is an array of NL lines,
%   return an array of [NP NL] position, corresponding to each couple
%   point-line.
%
%   POS = linePosition(POINTS, LINES, 'diag');
%   When POINTS and LINES have the same number of rows, computes positions
%   only for couples POINTS(i,:) and LINES(i,:). The result POS is a column
%   vector with as many rows as the number of points/lines.
%
%
%   Example
%   line = createLine([10 30], [30 90]);
%   linePosition([20 60], line)
%   ans =
%       .5
%
%   See also:
%   lines2d, createLine, projPointOnLine, isPointOnLine
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/05/2004.
%

%   HISTORY
%   2005-07-07 manage multiple input
%   2011-06-15 avoid the use of repmat when possible
%   2012-10-24 rewrite using bsxfun
%   2012-11-22 add support for the diag option

% if diag is true, we need only to compute position of i-th point with i-th
% line.
diag = ~isempty(varargin) && ischar(varargin{1}) && strcmpi(varargin{1}, 'diag');

if diag
    % In the case of 'diag' option, use direct correspondence between
    % points and lines
    
    % check input have same size
    np = size(point, 1);
    nl = size(line, 1);
    if np ~= nl
        error('matGeom:linePosition', ...
            'Using diag option, number of points and lines should be the same');
    end
    
    % direction vector of the lines
    vx = line(:, 3);
    vy = line(:, 4);
    
    % difference of coordinates between point and line origins
    dx = point(:, 1) - line(:, 1);
    dy = point(:, 2) - line(:, 2);
    
else
    % General case -> return NP-by-NL array
    
    % direction vector of the lines
    vx = line(:, 3)';
    vy = line(:, 4)';
    
    % difference of coordinates between point and line origins
    dx = bsxfun(@minus, point(:, 1), line(:, 1)');
    dy = bsxfun(@minus, point(:, 2), line(:, 2)');

end

% squared norm of direction vector, with a check of validity 
delta = vx .* vx + vy .* vy;
invalidLine = delta < eps;
delta(invalidLine) = 1; 

% compute position of points projected on the line, by using normalised dot
% product (NP-by-NL array) 
pos = bsxfun(@rdivide, bsxfun(@times, dx, vx) + bsxfun(@times, dy, vy), delta);

% ensure degenerated edges are correclty processed (consider the first
% vertex is the closest one)
if diag
    pos(invalidLine) = 0;
else
    pos(:, invalidLine) = 0;
end
