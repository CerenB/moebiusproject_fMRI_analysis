% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function opt = getOptionMoebius()
    % opt = getOption()
    % returns a structure that contains the options chosen by the user to run
    % slice timing correction, pre-processing, FFX, RFX.

    if nargin < 1
        opt = [];
    end

    % group of subjects to analyze
%     opt.groups = {'mbs'};
    % suject to run in each group
    opt.subjects = {'mbs004'}; %, 
    
    
    % Uncomment the lines below to run preprocessing
    % - don't use realign and unwarp
    opt.realign.useUnwarp = true;

    % we stay in native space (that of the T1)
    % - in "native" space: don't do normalization
    opt.space = 'MNI'; % 'individual', 'MNI'

    % The directory where the data are located
    opt.dataDir = fullfile(fileparts(mfilename('fullpath')), ...
                           '..', '..', '..',  'raw');
    opt.derivativesDir = fullfile(opt.dataDir, '..');

    % task to analyze
    % FEexe, FEobserv, LipReading, somatotopy, mototopy
%     opt.taskName = 'mototopy';
%     opt.taskName = 'FEobserv';
    opt.taskName = 'somatotopy';
    
%     opt.taskName = 'somatotopyres2p3tr1p5mb3sl68'; 
%     opt.taskName = 'somatotopyres2tr2p1mb2arc2sl68';
%     opt.taskName = 'somatotopyres2p6tr1p75mb2sl58';
%     opt.taskName = 'somatotopyres2p3tr1p75mb2sl52';

    % analysing runs differently?
    % opt.query = struct('acq', 'res2p6tr1p75mb2sl58'); 'res2p6tr1p75mb2sl58'; 'res2p3tr1p75mb2sl52'; 'res2p3tr1p5mb3sl68'; 'res2tr2p1mb2arc2sl68'; 

    % Suffix output directory for the saved jobs
    opt.jobsDir = fullfile( ...
                           opt.dataDir, '..', 'derivatives', ...
                           'cpp_spm', 'JOBS', opt.taskName);
                       
    opt.model.file = fullfile(fileparts(mfilename('fullpath')), '..', ...
                              'model', ['model-',opt.taskName,'_audCueParts_smdl.json']); 
%     opt.model.file = fullfile(fileparts(mfilename('fullpath')), '..', ...
%                               'model', 'model-somatotopy_audCueParts1ForeheadReg_smdl.json');  
%     opt.model.file = fullfile(fileparts(mfilename('fullpath')), '..', ...
%                               'model', 'model-mototopy_audCueParts2runs_smdl.json'); 
%     opt.model.file = fullfile(fileparts(mfilename('fullpath')), '..', ...
%                               'model', 'model-somatotopy_noCue_smdl.json');
%     opt.model.file = fullfile(fileparts(mfilename('fullpath')), '..', ...
%                               'model', 'model-mototopy_audCueParts_smdl.json');
                          
  opt.result.Steps(1) = returnDefaultResultsStructure();

  opt.result.Steps(1).Level = 'subject';

  clusterSize = 0; % 0 20
%   pvalue = 0.05;
%   correction = 'FWE';
  
  pvalueLow = 0.001; %0.01 0.001 0.05
  correctionLow = 'none'; %'none' 'FWE'
  
% % % for somatotopy assign pvalue to pvalueLow
  pvalue = pvalueLow;
  correction = correctionLow;
  
  
  % For each contrats, you can adapt:
  %  - voxel level (p)
  %  - cluster (k) level threshold
  %  - type of multiple comparison (MC):
  %    - 'FWE' is the defaut
  %    - 'FDR'
  %    - 'none'
  %
  
% looking at everything at once
% % 
%     opt.result.Steps(1).Contrasts(1).Name = 'AllStim'; %_gt_subjectCue
%     opt.result.Steps(1).Contrasts(1).MC =  correction;
%     opt.result.Steps(1).Contrasts(1).p = pvalue;
%     opt.result.Steps(1).Contrasts(1).k = clusterSize;
%     
% %     opt.result.Steps(1).Contrasts(2).Name = 'AllStim_gt_subjectCue';
% %     opt.result.Steps(1).Contrasts(2).MC =  'FWE';
% %     opt.result.Steps(1).Contrasts(2).p = 0.05;
% %     opt.result.Steps(1).Contrasts(2).k = 50;

   
%     opt.result.Steps(1).Contrasts(2).Name = 'Hand';
%     opt.result.Steps(1).Contrasts(2).MC =  correction;
%     opt.result.Steps(1).Contrasts(2).p = pvalue;
%     opt.result.Steps(1).Contrasts(2).k = clusterSize;
%       
%     opt.result.Steps(1).Contrasts(3).Name = 'Feet';
%     opt.result.Steps(1).Contrasts(3).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(3).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(3).k = clusterSize;
%   
%     opt.result.Steps(1).Contrasts(4).Name = 'Tongue';
%     opt.result.Steps(1).Contrasts(4).MC =  correction;
%     opt.result.Steps(1).Contrasts(4).p = pvalue;
%     opt.result.Steps(1).Contrasts(4).k = clusterSize;
    
%     opt.result.Steps(1).Contrasts(5).Name = 'Lips';
%     opt.result.Steps(1).Contrasts(5).MC =  correction;
%     opt.result.Steps(1).Contrasts(5).p = pvalue;
%     opt.result.Steps(1).Contrasts(5).k = clusterSize;
% 
%     opt.result.Steps(1).Contrasts(6).Name = 'Forehead';
%     opt.result.Steps(1).Contrasts(6).MC =  correction;
%     opt.result.Steps(1).Contrasts(6).p = pvalue;
%     opt.result.Steps(1).Contrasts(6).k = clusterSize;
%   
%     opt.result.Steps(1).Contrasts(7).Name = 'Hand_gt_Foot';
%     opt.result.Steps(1).Contrasts(7).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(7).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(7).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(8).Name = 'Foot_gt_Hand';
%     opt.result.Steps(1).Contrasts(8).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(8).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(8).k = clusterSize;
%    
%     opt.result.Steps(1).Contrasts(9).Name = 'Lips_gt_Tongue';
%     opt.result.Steps(1).Contrasts(9).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(9).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(9).k = clusterSize;
% 
%     opt.result.Steps(1).Contrasts(10).Name = 'Hand_gt_All';
%     opt.result.Steps(1).Contrasts(10).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(10).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(10).k = clusterSize;
    
%     opt.result.Steps(1).Contrasts(11).Name = 'Foot_gt_All';
%     opt.result.Steps(1).Contrasts(11).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(11).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(11).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(12).Name = 'Tongue_gt_All';
%     opt.result.Steps(1).Contrasts(12).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(12).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(12).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(13).Name = 'Lips_gt_All';
%     opt.result.Steps(1).Contrasts(13).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(13).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(13).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(14).Name = 'Forehead_gt_All';
%     opt.result.Steps(1).Contrasts(14).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(14).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(14).k = clusterSize;   
% 
%     opt.result.Steps(1).Contrasts(15).Name = 'cue_gt_Tongue';
%     opt.result.Steps(1).Contrasts(15).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(15).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(15).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(16).Name = 'Tongue_gt_cue';
%     opt.result.Steps(1).Contrasts(16).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(16).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(16).k = clusterSize;

% % looking at only Forehead
% 
%     opt.result.Steps(1).Contrasts(1).Name = 'Forehead';
%     opt.result.Steps(1).Contrasts(1).MC =  correction;
%     opt.result.Steps(1).Contrasts(1).p = pvalue;
%     opt.result.Steps(1).Contrasts(1).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(2).Name = 'Forehead_gt_All';
%     opt.result.Steps(1).Contrasts(2).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(2).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(2).k = clusterSize;  
%     
%     opt.result.Steps(1).Contrasts(3).Name = 'ForeheadDouble_gt_All';
%     opt.result.Steps(1).Contrasts(3).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(3).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(3).k = clusterSize; 
% 
% %     % weird ?
%     opt.result.Steps(1).Contrasts(4).Name = 'Forehead_gt_cueAndAll';
%     opt.result.Steps(1).Contrasts(4).MC =  correction;
%     opt.result.Steps(1).Contrasts(4).p = pvalue;
%     opt.result.Steps(1).Contrasts(4).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(5).Name = 'Forehead2';
%     opt.result.Steps(1).Contrasts(5).MC =  correction;
%     opt.result.Steps(1).Contrasts(5).p = pvalue;
%     opt.result.Steps(1).Contrasts(5).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(6).Name = 'Forehead2_gt_All';
%     opt.result.Steps(1).Contrasts(6).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(6).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(6).k = clusterSize;
%     

% looking at only at Tongue

%     opt.result.Steps(1).Contrasts(1).Name = 'Tongue_gt_All';
%     opt.result.Steps(1).Contrasts(1).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(1).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(1).k = clusterSize;
    
% % looking only at the body-part comparison
% 
    opt.result.Steps(1).Contrasts(1).Name = 'Hand_gt_All';
    opt.result.Steps(1).Contrasts(1).MC =  correctionLow;
    opt.result.Steps(1).Contrasts(1).p = pvalueLow;
    opt.result.Steps(1).Contrasts(1).k = clusterSize;
    
    opt.result.Steps(1).Contrasts(2).Name = 'Foot_gt_All';
    opt.result.Steps(1).Contrasts(2).MC =  correctionLow;
    opt.result.Steps(1).Contrasts(2).p = pvalueLow;
    opt.result.Steps(1).Contrasts(2).k = clusterSize;
    
    opt.result.Steps(1).Contrasts(3).Name = 'Tongue_gt_All';
    opt.result.Steps(1).Contrasts(3).MC =  correctionLow;
    opt.result.Steps(1).Contrasts(3).p = pvalueLow;
    opt.result.Steps(1).Contrasts(3).k = clusterSize;
    
    opt.result.Steps(1).Contrasts(4).Name = 'Lips_gt_All';
    opt.result.Steps(1).Contrasts(4).MC =  correctionLow;
    opt.result.Steps(1).Contrasts(4).p = pvalueLow;
    opt.result.Steps(1).Contrasts(4).k = clusterSize;
    
    opt.result.Steps(1).Contrasts(5).Name = 'Forehead_gt_All';
    opt.result.Steps(1).Contrasts(5).MC =  correctionLow;
    opt.result.Steps(1).Contrasts(5).p = pvalueLow;
    opt.result.Steps(1).Contrasts(5).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(6).Name = 'cue_gt_Tongue';
%     opt.result.Steps(1).Contrasts(6).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(6).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(6).k = clusterSize;
%     
%     opt.result.Steps(1).Contrasts(7).Name = 'Tongue_gt_cue';
%     opt.result.Steps(1).Contrasts(7).MC =  correctionLow;
%     opt.result.Steps(1).Contrasts(7).p = pvalueLow;
%     opt.result.Steps(1).Contrasts(7).k = clusterSize;
% %     
%   % Specify how you want your output (all the following are on false by default)
%   opt.result.Steps(1).Output.png = true();
% 
%   opt.result.Steps(1).Output.csv = true();

  opt.result.Steps(1).Output.thresh_spm = true();

  opt.result.Steps(1).Output.binary = true();

  opt.result.Steps(1).Output.montage.do = true();
  opt.result.Steps(1).Output.montage.slices = 4:4:76; % in mm -12:4:60
  % axial is default 'sagittal', 'coronal'
  opt.result.Steps(1).Output.montage.orientation = 'axial';

  % will use the MNI T1 template by default but the underlay image can be
  % changed.
  opt.result.Steps(1).Output.montage.background = ...
      fullfile(spm('dir'), 'canonical', 'avg152T1.nii,1');

    opt.sliceOrder = [];
    opt.STC_referenceSlice = [];

    % Options for normalize
    % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
    opt.funcVoxelDims = [];

    opt.parallelize.do = false;

    %% DO NOT TOUCH
    opt = checkOptions(opt);
    saveOptions(opt);

end
