clear;
clc;

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

% spm fmri
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
% rmpath(genpath('/Users/battal/Documents/MATLAB/spm8'));

% bspm fmri - optinal
% addpath(genpath('/Users/battal/Documents/MATLAB/bspmview'));




% then add cpp repo to prevent repo version compatibility issue
run ../lib/CPP_BIDS_SPM_pipeline/initCppSpm.m;

% lastly, we add all the subfunctions that are in the sub directories
opt = getOptionMoebius();

% % first copy source subject folder into raw + omit date suffix
% copySourceToRawAndOmitSuffix(opt);

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
% % % smoothing
% 8mm for univariate, 3mm for Mortiz decoding
funcFWHM = 2;
bidsSmoothing(funcFWHM, opt);

% % % smoothing, 2mm or 6mm for somatotopy/mototopy
funcFWHM = 6;
bidsSmoothing(funcFWHM, opt);

bidsFFX('specifyAndEstimate', opt, funcFWHM);

% run cont
bidsFFX('contrasts', opt, funcFWHM);
bidsResults(opt, funcFWHM);


% wish to change the contrasts and rerun
opt = getOptionMoebius();
bidsResults(opt, funcFWHM);


% % load bspmview
% cd(getFFXdir('ctrl001', 6, opt));
% bspmview('spmT_0055.nii')

%% visualisation via workbench
% add path matworkbench
addpath(genpath('/Users/battal/Documents/GitHub/CPPLab/matworkbench'));

% define the ffx
funcFWHM = 6;
ffxDir = getFFXdir(opt.subjects{8}, funcFWHM, opt);
% condition = 'Hand_gt_All';
% pvalue = 
% fileName = 


%outputFiles = spm_select('FPList', ffxDir, '^sub-.*.GtAll_.*spmT.nii$');
% outputFiles = spm_select('FPList', ffxDir, '^sub-.*.GtAll_.*.p-0001_.*spmT.nii$');
outputFiles = spm_select('FPList', ffxDir, '^sub-.*.GtAll_.*.k-20_.*spmT.nii$');


% take one example 
%file = outputFiles(1,:);

opennii(outputFiles);
opennii

% when wb_ commands don't work/not found, open matlab via terminal


%   for iFile = 1:size(outputFiles, 1)
% 
%     source = deblank(outputFiles(iFile, :));
% 
%     basename = spm_file(source, 'basename');
%     split = strfind(basename, '_sub');
%     p = bids.internal.parse_filename(basename(split + 1:end));
%     p.label = basename(split - 4:split - 1);
%     p.use_schema = false;
%     newName = bids.create_filename(p);
% 
%     target = spm_file(source, 'basename', newName);
% 
%     movefile(source, target);
%   end












