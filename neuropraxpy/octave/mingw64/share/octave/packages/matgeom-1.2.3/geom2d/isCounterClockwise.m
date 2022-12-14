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

function res = isCounterClockwise(p1, p2, p3, varargin)
% Compute the relative orientation of 3 points.
%
%   CCW = isCounterClockwise(P1, P2, P3);
%   Computes the orientation of the 3 points. The returns is:
%   +1 if the path P1->P2->P3 turns Counter-Clockwise (i.e., the point P3
%       is located "on the left" of the line P1-P2)
%   -1 if the path turns Clockwise (i.e., the point P3 lies "on the right"
%       of the line P1-P2) 
%   0  if the point P3 is located on the line segment [P1 P2].
%
%   This function can be used in more complicated algorithms: detection of
%   line segment intersections, convex hulls, point in triangle...
%
%   CCW = isCounterClockwise(P1, P2, P3, EPS);
%   Specifies the threshold used for detecting colinearity of the 3 points.
%   Default value is 1e-12 (absolute).
%
%   Example
%   isCounterClockwise([0 0], [10 0], [10 10])
%   ans = 
%       1
%   isCounterClockwise([0 0], [0 10], [10 10])
%   ans = 
%       -1
%   isCounterClockwise([0 0], [10 0], [5 0])
%   ans = 
%       0
%
%   See also
%   points2d, isPointOnLine, isPointInTriangle, polygonArea
%
%   References
%     Algorithm adapated from Sedgewick's book.
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2010-04-09
% Copyright 2011 INRAE - Cepia Software Platform.


%   HISTORY
%   2011-05-16 change variable names, add support for point arrays


% get threshold value
eps = 1e-12;
if ~isempty(varargin)
    eps = varargin{1};
end

% ensure all data have same size
np = max([size(p1, 1) size(p2, 1) size(p3,1)]);
if np > 1
    if size(p1,1) == 1
        p1 = repmat(p1, np, 1);
    end
    if size(p2,1) == 1
        p2 = repmat(p2, np, 1);
    end
    if size(p3,1) == 1
        p3 = repmat(p3, np, 1);
    end    
end

% init with 0
res = zeros(np, 1);

% extract vector coordinates
x0  = p1(:, 1);
y0  = p1(:, 2);
dx1 = p2(:, 1) - x0;
dy1 = p2(:, 2) - y0;
dx2 = p3(:, 1) - x0;
dy2 = p3(:, 2) - y0;

% check non colinear cases
res(dx1 .* dy2 > dy1 .* dx2) =  1;
res(dx1 .* dy2 < dy1 .* dx2) = -1;

% case of colinear points
ind = abs(dx1 .* dy2 - dy1 .* dx2) < eps;
res(ind( (dx1(ind) .* dx2(ind) < 0) | (dy1(ind) .* dy2(ind) < 0) )) = -1;
res(ind(  hypot(dx1(ind), dy1(ind)) <  hypot(dx2(ind), dy2(ind)) )) =  1;
