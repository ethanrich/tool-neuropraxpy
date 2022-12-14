% STK_BOUNDINGBOX [overload STK function]

% Copyright Notice
%
%    Copyright (C) 2015, 2018 CentraleSupelec
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

function box = stk_boundingbox (x)

% An stk_hrect object is its own bounding box
box = x;

end % function


%!shared x, y
%! lb = rand (1, 5);
%! ub = lb + 1;
%! cn = {'a', 'b', 'c', 'd', 'e'};
%! x = stk_hrect ([lb; ub], cn);

%!error  y = stk_boundingbox ();
%!test   y = stk_boundingbox (x);

%!assert (isequal (y, x));
