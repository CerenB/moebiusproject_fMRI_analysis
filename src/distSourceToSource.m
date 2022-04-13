function distSourceToSource
% % % BUTCHERED script - need reorganisation for Moebius project
% it assumes all the relevent raw folder is set! 

% previously for Rhythmateg project:
  % this function dsitributes the 3 different fMRI exp source data into their
  % relevant raw folders
  % then .tsv _.json files un func will be carried to raw folder

  % add bids repo
  bidsPath = fullfile(fileparts(mfilename('fullpath')), ...
                       '..', 'lib', 'CPP_BIDS');
  addpath(genpath(fullfile(bidsPath, 'src')));
  addpath(genpath(fullfile(bidsPath, 'lib')));

  % run getOptions to get cp_spm repo

  % define task names
  subject = 'sub-pil004';
  session = 'ses-001';

  cfg.dir.output = fullfile(fileparts(mfilename('fullpath')), ...
                       '..', '..', '..');
                   
   sourceDir = fullfile(cfg.dir.output, 'source');
   rawDir = fullfile(cfg.dir.output, 'raw');
                   
%   convertSourceToRaw(cfg);
  
%     

BIDS = bids.layout(rawDir,  'use_schema', false);

    data = bids.query(BIDS, 'data');
    metadata = bids.query(BIDS, 'metadata');

    for i = 1:size(data, 1)
        bf = bids.File(data{i});
        if isfield(bf.entities, 'date')
            % TODO probably JSON renaming should be passed to bids-matlab
            sourceJson = fullfile(fileparts(bf.path), bf.json_filename);
            bf.entities.date = '';
            bf.rename('dry_run', false, 'force', true);
            bids.util.jsonencode(fullfile(fileparts(bf.path), bf.json_filename), metadata{i});
            delete(sourceJson);
        end
    end

    BIDS = bids.layout(rawDir,  'use_schema', false);
    data = bids.query(BIDS, 'data', 'suffix', {'stim', 'physio' }, 'ext', '.tsv');

    for i = 1:size(data, 1)
        gzip(data{i});
        if exist(data{i}, 'file')
            delete(data{i});
        end
    end
    
    
%   rawDir = fullfile(fileparts(mfilename('fullpath')), ...
%                        '..', '..', '..', 'raw');
%   
%   % remove suffix
%   removeAllDateSuffix(rawDir, subject, session);
%     
    

end
