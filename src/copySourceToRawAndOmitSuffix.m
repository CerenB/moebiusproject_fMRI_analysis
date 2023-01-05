function copySourceToRawAndOmitSuffix(subject)

% remove date suffix + copy source to raw 
% add bids repo
run ../lib/CPP_BIDS/checkCppBidsDependencies.m;

% remove data suffix
filter = struct('sub', subject);

% copy source to raw + remove date suffix in raw folder
cfg.dir.output = '/Users/battal/Cerens_files/fMRI/Processed/MoebiusProject/';
convertSourceToRaw(cfg, 'filter', filter)

% remove cpp-bids repo now to prevent repos compatibility issues
rmpath(genpath('../lib/CPP_BIDS/'));

end