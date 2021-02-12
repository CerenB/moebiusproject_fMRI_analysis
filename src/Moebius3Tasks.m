clear;
clc;

cd(fileparts(mfilename('fullpath')));

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
% spm fmri
initEnv();

% we add all the subfunctions that are in the sub directories
opt = getOptionMoebius();

checkDependencies();

%% Run batches
reportBIDS(opt);
bidsCopyRawFolder(opt, 0);
%
% %
bidsSTC(opt);
% % %
bidsSpatialPrepro(opt);
%
% % Quality control
% % anatomicalQA(opt);
% % bidsResliceTpmToFunc(opt);
% % functionalQA(opt);
%
% % smoothing
% funcFWHM = 8;
% bidsSmoothing(funcFWHM, opt);

% % smoothing
% funcFWHM = 3;
% bidsSmoothing(funcFWHM, opt);
