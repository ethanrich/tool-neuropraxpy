## Copyright (C) 2006 Peter V. Lanspeary <pvl@mecheng.adelaide.edu.au>
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING. If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {[@var{Pxx}, @var{freq}]} = cohere(@var{x},@var{y},@var{Nfft},@var{Fs},@var{window},@var{overlap},@var{range},@var{plot_type},@var{detrend})
## Estimate (mean square) coherence of signals "x" and "y".
##
## Use the Welch (1967) periodogram/FFT method.
##
## Compatible with Matlab R11 cohere and earlier.
##
## See "help pwelch" for description of arguments, hints and references
## --- especially hint (7) for Matlab R11 defaults.
## @end deftypefn

function varargout = cohere(varargin)

##
  if ( nargin<2 )
    error( 'cohere: Need at least 2 args. Use help cohere.' );
  endif
  nvarargin = length(varargin);
  ## remove any pwelch RESULT args and add 'trans'
  for iarg=1:nvarargin
    arg = varargin{iarg};
    if ( ~isempty(arg) && ischar(arg) && ( strcmp(arg,'power') || ...
           strcmp(arg,'cross') || strcmp(arg,'trans') || ...
           strcmp(arg,'coher') || strcmp(arg,'ypower') ))
      varargin{iarg} = [];
    endif
  endfor
  varargin{nvarargin+1} = 'coher';
  ##
  saved_compatib = pwelch('R11-');
  if ( nargout==0 )
    pwelch(varargin{:});
  elseif ( nargout==1 )
    Pxx = pwelch(varargin{:});
    varargout{1} = Pxx;
  elseif ( nargout>=2 )
    [Pxx,f] = pwelch(varargin{:});
    varargout{1} = Pxx;
    varargout{2} = f;
  endif
  pwelch(saved_compatib);
  saved_compatib = 0;

endfunction
