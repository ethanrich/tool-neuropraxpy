% STK_EXAMPLE_KB01  Ordinary kriging in 1D, with noiseless data
%
% This example shows how to compute ordinary kriging predictions on a
% one-dimensional noiseless dataset.
%
% The word 'ordinary' indicates that the mean function of the GP prior is
% assumed to be constant and unknown.
%
% A Matern covariance function is used for the Gaussian Process (GP) prior.
% The parameters of this covariance function are assumed to be known (i.e.,
% no parameter estimation is performed here).
%
% Note that the kriging predictor, which is the posterior mean of the GP,
% interpolates the data in this noiseless example.
%
% See also: stk_example_kb01n, stk_example_kb02

% Copyright Notice
%
%    Copyright (C) 2015, 2016, 2018 CentraleSupelec
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

stk_disp_examplewelcome


%% Dataset

% Load a 1D noiseless dataset
[xi, zi, ref] = stk_dataset_twobumps ('noiseless');

% The grid where predictions must be made
xt = ref.xt;

% Reference values on the grid
zt = ref.zt;

stk_figure ('stk_example_kb01 (a)');
stk_plot1d (xi, zi, xt, zt);  stk_legend;
stk_title  ('True function and observed data');
stk_labels ('input variable x', 'response z');


%% Specification of the model
%
% We choose a Matern covariance with "fixed parameters" (in other  words, the
% parameters of the covariance function are provided by the user rather than
% estimated from data).
%

% The following line defines a model with a constant but unknown mean (ordinary
% kriging) and a Matern covariance function. (Some default parameters are also
% set, but we override them below.)
model = stk_model (@stk_materncov_iso);

% NOTE: the suffix '_iso' indicates an ISOTROPIC covariance function, but the
% distinction isotropic / anisotropic is irrelevant here since DIM = 1.

% Parameters for the Matern covariance function
% ("help stk_materncov_iso" for more information)
SIGMA2 = 0.5;  % variance parameter
NU     = 4.0;  % regularity parameter
RHO1   = 0.4;  % scale (range) parameter
model.param = log ([SIGMA2; NU; 1/RHO1]);

model


%% Carry out the kriging prediction and display the result
%
% The result of a kriging predicition is provided by stk_predict() in an object
% zp of type stk_dataframe, with two columns: "zp.mean" (the kriging mean) and
% "zp.var" (the kriging variance).
%

% Carry out the kriging prediction at points xt
zp = stk_predict (model, xi, zi, xt);

% Display the result
stk_figure ('stk_example_kb01 (b)');
stk_plot1d (xi, zi, xt, zt, zp);  stk_legend;
stk_title  ('Kriging prediction based on noiseless observations');
stk_labels ('input variable x', 'response z');


%#ok<*NOPTS>

%!test stk_example_kb01;  close all;
