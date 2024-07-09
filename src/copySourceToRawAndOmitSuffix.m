function copySourceToRawAndOmitSuffix(opt)

% remove date suffix + copy source to raw 
% add bids repo
run ../lib/CPP_BIDS/checkCppBidsDependencies.m;

% % % NOTE : this way does not copy/paste the anatomy scan


taskName = opt.taskName; 

for iSub = 1:length(opt.subjects)
    
    subject = opt.subjects{iSub};
    
    % remove data suffix
    filter = struct('sub', subject, ...
                'task', taskName);

    % copy source to raw + remove date suffix in raw folder
    cfg.dir.output = '/Users/battal/Cerens_files/fMRI/Processed/MoebiusProject/';
    convertSourceToRaw(cfg, 'filter', filter)

end
% remove cpp-bids repo now to prevent repos compatibility issues
% rmpath(genpath('../lib/CPP_BIDS/'));

end