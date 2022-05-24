clear;
clc;

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

%% remove date suffix + copy source to raw 
% add bids repo
run ../lib/CPP_BIDS/checkCppBidsDependencies.m;

% remove data suffix
filter = struct('sub', 'sub-pil006');

% copy source to raw + remove date suffix
cfg.dir.output = '/Users/battal/Cerens_files/fMRI/Processed/MoebiusProject/';
convertSourceToRaw(cfg, 'filter', filter)

% consider removing the cpp-bids repo ! ! ! 
%%
% spm fmri
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));

% bspm fmri
addpath(genpath('/Users/battal/Documents/MATLAB/bspmview'));

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


% load bspmview
cd(getFFXdir('pil005', 6, opt));
bspmview('spmT_0017.nii')
