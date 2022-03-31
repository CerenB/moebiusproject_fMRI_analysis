clear;
clc;

%cd(fileparts(mfilename('fullpath')));

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));

% bspm fmri
addpath(genpath('/Users/battal/Documents/MATLAB/bspmview'));

% spm fmri
% add cpp repo
run ../lib/CPP_BIDS_SPM_pipeline/initCppSpm.m;

% we add all the subfunctions that are in the sub directories
opt = getOptionMoebius();

%% Run batches
%reportBIDS(opt);
bidsCopyRawFolder(opt, 1);
%
% %
bidsSTC(opt);
% % %
bidsSpatialPrepro(opt);
%
% % Quality control
anatomicalQA(opt);
bidsResliceTpmToFunc(opt);
functionalQA(opt);
%
% % smoothing
funcFWHM = 6;
bidsSmoothing(funcFWHM, opt);

% % % smoothing
funcFWHM = 3;
bidsSmoothing(funcFWHM, opt);

bidsFFX('specifyAndEstimate', opt, funcFWHM);
bidsFFX('contrasts', opt, funcFWHM);



