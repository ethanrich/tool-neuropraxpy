## Copyright 2015 Oliver Heimlich
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @documentencoding UTF-8
## @defmethod {@@infsup} issquare (@var{A})
##
## Return true if @var{A} is a square interval matrix.
##
## @seealso{@@infsup/isvector, @@infsup/isscalar}
## @end defmethod

## Author: Oliver Heimlich
## Keywords: interval
## Created: 2015-04-18

## FIXME: One happy day this function can be removed, because bug #44498 has
## been solved with GNU Octave 5.1.0. Move tests to size.m.
function result = issquare (A)

  if (nargin ~= 1)
    print_usage ();
    return
  endif

  result = issquare (A.inf);

endfunction

%!assert (issquare (infsup ([])));
%!assert (issquare (infsup (0)));
%!assert (not (issquare (infsup (zeros (1, 2)))));
%!assert (not (issquare (infsup (zeros (2, 1)))));
%!assert (issquare (infsup (zeros (5))));
