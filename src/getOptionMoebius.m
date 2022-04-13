% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function opt = getOptionMoebius()
    % opt = getOption()
    % returns a structure that contains the options chosen by the user to run
    % slice timing correction, pre-processing, FFX, RFX.

    if nargin < 1
        opt = [];
    end

    % group of subjects to analyze
    opt.groups = {''};
    % suject to run in each group
    opt.subjects = {'pil004'};
    
    
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
    opt.taskName = 'mototopy'; 
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
                              'model', 'model-mototopy_pil004_smdl.json');

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
