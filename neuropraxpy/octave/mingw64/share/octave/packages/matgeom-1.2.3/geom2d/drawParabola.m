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

function varargout = drawParabola(varargin)
%DRAWPARABOLA Draw a parabola on the current axis.
%
%   drawParabola(PARABOLA);
%   Draws a vertical parabola, defined by its vertex and its parameter.
%   Such a parabola admits a vertical axis of symetry.
%
%   The algebraic equation of parabola is given by:
%      (Y - YV) = A * (X - VX)^2
%   Where XV and YV are vertex coordinates and A is parabola parameter.
%
%   A parametric equation of parabola is given by:
%      x(t) = t + VX;
%      y(t) = A * t^2 + VY;
%
%   PARABOLA can also be defined by [XV YV A THETA], with theta being the
%   angle of rotation of the parabola (in degrees and Counter-Clockwise).
%
%   drawParabola(PARABOLA, T);
%   Specifies which range of 't' are used for drawing parabola. If T is an
%   array with only two values, the first and the last values are used as
%   interval bounds, and several values are distributed within this
%   interval.
%
%   drawParabola(..., NAME, VALUE);
%   Can specify one or several graphical options using parameter name-value
%   pairs.
%
%   drawParabola(AX, ...);
%   Specifies handle of the axis to draw on.
%
%   H = drawParabola(...);
%   Returns an handle to the created graphical object.
%
%
%   Example:
%     figure(1); clf; hold on;
%     axis equal; axis([0 100 0 100])
%     % draw parabola with default parameterization bounds 
%     drawParabola([50 50 .2 30]);
%     % draw parabola with more specific bounds and drawing style
%     drawParabola([50 50 .2 30], [-3 3], 'color', 'r', 'linewidth', 2);
%   
%
%   See Also:
%   drawCircle, drawEllipse
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 02/06/2006.
%

%   HISTORY
%   2010-11-17 rewrite, change parametrisation, update doc
%   2011-03-30 use degrees for angle
%   2011-10-11 add management of axes handle

% Extract parabola
if nargin < 1
    error('geom2d:drawParabola:IllegalArgument', ...
        'Please specify parabola representation');
end

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% input parabola is given as a packed array
parabola = varargin{1};
varargin(1) = [];
x0 = parabola(:,1);
y0 = parabola(:,2);
a  = parabola(:,3);

% check if parabola orientation is specified
if size(parabola, 2) > 3
    theta = parabola(:, 4);
else
    theta = zeros(length(a), 1);
end

% extract parametrisation bounds
bounds = [-100 100];
if ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var)
        bounds = var;
        varargin(1) = [];
    end
end

% create parametrisation array
if length(bounds) > 2
    t = bounds;
else
    t = linspace(bounds(1), bounds(end), 100);
end

% create handle array (in the case of several parabola)
h = zeros(size(x0));

% draw each parabola
for i = 1:length(x0)
    % compute transformation
    trans = ...
        createTranslation(x0(i), y0(i)) * ...
        createRotation(deg2rad(theta(i))) * ...
        createScaling(1, a);
    
	% compute points on the parabola
    [xt, yt] = transformPoint(t(:), t(:).^2, trans);

    % draw it
    h(i) = plot(ax, xt, yt, varargin{:});
end

% process output arguments
if nargout > 0
    varargout = {h};
end

