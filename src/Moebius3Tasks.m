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
% copySourceToRawAndOmitSuffix('sub-mbs004');

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
% % % smoothing
% 8mm for univariate, 3mm for Mortiz decoding
% funcFWHM = 3;
% bidsSmoothing(funcFWHM, opt);

% % % smoothing, 2mm or 6mm for somatotopy/mototopy
funcFWHM = 6;
bidsSmoothing(funcFWHM, opt);

bidsFFX('specifyAndEstimate', opt, funcFWHM);

% does not work for sequence testing
bidsFFX('contrasts', opt, funcFWHM);
bidsResults(opt, funcFWHM);


opt = getOptionMoebius();
bidsResults(opt, funcFWHM);


% % load bspmview
% cd(getFFXdir('pil006', 6, opt));
% bspmview('spmT_0041.nii')

%% visualisation via workbench

ffxDir = getFFXdir(opt.subjects{1}, funcFWHM, opt);
% condition = 'Hand_gt_All';
% pvalue = 
% fileName = 


outputFiles = spm_select('FPList', ffxDir, '^sub-.*.GtAll_.*spmT.nii$');
opennii(outputFiles);
opennii

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












