% STK_NOISECOV [deprecated]
%
% See also: stk_covmat_noise

% Copyright Notice
%
%    Copyright (C) 2018 CentraleSupelec
%    Copyright (C) 2011-2014 SUPELEC
%
%    Authors:  Julien Bect       <julien.bect@centralesupelec.fr>
%              Emmanuel Vazquez  <emmanuel.vazquez@centralesupelec.fr>

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

function K = stk_noisecov (ni, lognoisevariance, diff, pairwise)

if (nargin < 3) || (isempty (diff))
    diff = -1;  % Default: compute the value (not a derivative)
end

if nargin < 4
    pairwise = false;  % Default: matrix
end

if isscalar (lognoisevariance)  % Homoscedastic
    % Remark: the result does not depend on diff
    
    if pairwise
        if lognoisevariance == -inf
            K = zeros (ni, 1);
        else
            K = (exp (lognoisevariance)) * (ones (ni, 1));
        end
    else
        if lognoisevariance == -inf
            K = zeros (ni);
        else
            K = (exp (lognoisevariance)) * (eye (ni));
        end
    end
    
else  % Heteroscedastic
    
    s = size (lognoisevariance);
    if ~ ((isequal (s, [1, ni])) || (isequal (s, [ni, 1])))
        fprintf ('lognoisevariance has size:\n');  display (s);
        stk_error (sprintf (['lognoisevariance was expected to be either a ' ...
            'scalar or a vector of length %d\n'], ni), 'IncorrectSize');
    end
    
    if diff ~= -1
        error ('diff ~= -1 is not allowed in the heteroscedastic case');
    end
    
    if pairwise
        K = exp (lognoisevariance(:));
    else
        K = diag (exp (lognoisevariance));
    end
    
end

end % function


%!shared ni, lognoisevariance, diff
%!  ni = 5;
%!  lognoisevariance = 0.0;
%!  diff = -1;

%!error K = stk_noisecov ();
%!error K = stk_noisecov (ni);
%!test  K = stk_noisecov (ni, lognoisevariance);
%!test  K = stk_noisecov (ni, lognoisevariance, diff);
%!test  K = stk_noisecov (ni, lognoisevariance, diff, true);
