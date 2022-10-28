clear;
clc;

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

% spm fmri
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
% rmpath(genpath('/Users/battal/Documents/MATLAB/spm8'));

% bspm fmri - optinal
addpath(genpath('/Users/battal/Documents/MATLAB/bspmview'));

% % first copy source subject folder into raw + omit date suffix
% copySourceToRawAndOmitSuffix('sub-pil011');

% then add cpp repo to prevent repo version compatibility issue
run ../lib/CPP_BIDS_SPM_pipeline/initCppSpm.m;

% lastly, we add all the subfunctions that are in the sub directories
opt = getOptionMoebius();

%% Run batches
bidsCopyRawFolder(opt, 1);
%
% %
bidsSTC(opt);
% % %
bidsSpatialPrepro(opt);
%
% % % Quality control
% anatomicalQA(opt);
% bidsResliceTpmToFunc(opt);
% functionalQA(opt);
%
% % smoothing
funcFWHM = 6;
bidsSmoothing(funcFWHM, opt);

% % % % smoothing
% funcFWHM = 3;
% bidsSmoothing(funcFWHM, opt);

bidsFFX('specifyAndEstimate', opt, funcFWHM);

% does not work for sequence testing
bidsFFX('contrasts', opt, funcFWHM);
bidsResults(opt, funcFWHM);


opt = getOptionMoebius();
bidsResults(opt, funcFWHM);


% % load bspmview
% cd(getFFXdir('pil006', 6, opt));
% bspmview('spmT_0041.nii')
