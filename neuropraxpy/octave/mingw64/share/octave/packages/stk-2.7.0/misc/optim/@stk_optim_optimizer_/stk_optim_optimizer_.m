% STK_OPTIM_OPTIMIZER_ [STK internal]
%
% CALL: ALGO = stk_optim_optimizer_ (DOES_BOXCONSTRAINED, DOES_UNCONSTRAINED)
%
%   constructs an abstract algorithm object ALGO of class stk_optim_optimizer_.
%   The first (resp. second) input argument indicates whether the object
%   reprensents an algorithm that supports constrained (resp.
%   unconstrained) optimization.
%
% STK INTERNAL WARNING:
%
%   The class @stk_optim_optimizer_ is considered as internal.  Its
%   implementation and interface are likely to change in future releases.
%   Ordinary users should refrain from using it directly.

% Copyright Notice
%
%    Copyright (C) 2017-2019 CentraleSupelec
%
%    Authors:  Julien Bect  <julien.bect@centralesupelec.fr>

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

function algo = stk_optim_optimizer_ (does_boxconstrained, does_unconstrained)

if nargin == 0
    does_boxconstrained = false;
    does_unconstrained = false;
end

algo = struct (                                 ...
    'does_boxconstrained', does_boxconstrained, ...
    'does_unconstrained',  does_unconstrained   );

algo = class (algo, 'stk_optim_optimizer_');

end % function


%!test stk_test_class ('stk_optim_optimizer_')
