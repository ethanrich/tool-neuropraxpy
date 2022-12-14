% STK_ZLABEL [STK internal]
%
% STK_ZLABEL is a replacement for 'zlabel' for use in STK's examples.

% Copyright Notice
%
%    Copyright (C) 2016 CentraleSupelec
%    Copyright (C) 2014 SUPELEC
%
%    Author:  Julien Bect  <julien.bect@centralesupelec.fr>

% Copying Permission Statement
%
%    This file is part of
%
%            STK: a Small (Matlab/Octave) Toolbox for Kriging
%               (https://github.com/stk-kriging/stk/)
%
%    STK is free software: you can redistribute it and/or modify it under
%    the terms of the GNU General Public License as published by the Free
%    Software Foundation,  either version 3  of the License, or  (at your
%    option) any later version.
%
%    STK is distributed  in the hope that it will  be useful, but WITHOUT
%    ANY WARRANTY;  without even the implied  warranty of MERCHANTABILITY
%    or FITNESS  FOR A  PARTICULAR PURPOSE.  See  the GNU  General Public
%    License for more details.
%
%    You should  have received a copy  of the GNU  General Public License
%    along with STK.  If not, see <http://www.gnu.org/licenses/>.

function h_label = stk_zlabel (varargin)

[h_axes, varargin] = stk_plot_getaxesarg (varargin{:});
zlab = varargin{1};

% Get global STK options
stk_options = stk_options_get ('stk_zlabel', 'properties');
user_options = varargin(2:end);

% Set z-label and apply STK options
h_label = zlabel (h_axes, zlab, stk_options{:});

% Apply user-provided options
if ~ isempty (user_options)
    set (h_label, user_options{:});
end

end % function
