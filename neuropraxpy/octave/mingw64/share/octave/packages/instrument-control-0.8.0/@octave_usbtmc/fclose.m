## Copyright (C) 2013 Stefan Mahr <dac922@gmx.de>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {@var{res} =} fclose (@var{obj})
## Closes USBTMC connection @var{obj} 
##
## @subsubheading Inputs
## @var{obj} is a usbtmc object.@*
## @end deftypefn

function fclose(fd)

usbtmc_close(fd);

end
