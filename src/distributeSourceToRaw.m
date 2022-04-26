function distributeSourceToRaw(cfg)
% % % BUTCHERED script - need reorganisation for Moebius project
% it assumes all the relevent raw folder is set! 

% previously for Rhythmateg project:
  % this function dsitributes the 3 different fMRI exp source data into their
  % relevant raw folders
  % then .tsv _.json files un func will be carried to raw folder

%   % add bids repo
%   bidsPath = fullfile(fileparts(mfilename('fullpath')), ...
%                        '..', 'lib', 'CPP_BIDS');
%   addpath(genpath(fullfile(bidsPath, 'src')));
%   addpath(genpath(fullfile(bidsPath, 'lib')));
% 


  % define task names
  subLabel = cfg.subjects{1};
  subject = ['sub-',subLabel];

  cfg.dir.output = fullfile(fileparts(mfilename('fullpath')), ...
                       '..', '..', '..');
                   
   sourceDir = fullfile(cfg.dir.output, 'source');
   rawDir = fullfile(cfg.dir.output, 'raw');
   
   % copy given subject' data from source to raw 
   copyfile(fullfile(sourceDir, 'tmp',subject), fullfile(rawDir,subject))
   
   % delete file dublication
   patternToDelete = '*_date-202*_bold.json';
   filesToDelete = dir(fullfile(rawDir,subject, 'ses-001', 'func',patternToDelete));
   % delete(filesToDelete(1).name) 
   
   % read all the data in bids format
   BIDS = bids.layout(rawDir,  'use_schema', false);
 
    % construct a filter to get only the file we want
    filter = struct('sub', subject, 'task', cfg.taskName);
  
    file_to_rename = bids.query(BIDS, 'data', filter);
    
    metadata = bids.query(BIDS, 'metadata');
    bids.query(BIDS, 'metafiles');
    
    

    
    

    for i = 1:size(file_to_rename, 1)
        bf = bids.File(file_to_rename{i});
        if isfield(bf.entities, 'date')
            % TODO probably JSON renaming should be passed to bids-matlab
            sourceJson = fullfile(fileparts(bf.path), bf.json_filename);
            bf.entities.date = '';
            %bf.rename('dry_run', false, 'force', true);
            bf.rename('dry_run', true, 'verbose', true);
            bids.util.jsonencode(fullfile(fileparts(bf.path), bf.json_filename), metadata{end});
            delete(sourceJson);
        end
    end

    BIDS = bids.layout(rawDir,  'use_schema', false);
    file_to_rename = bids.query(BIDS, 'data', 'suffix', {'stim', 'physio' }, 'ext', '.tsv');

    for i = 1:size(file_to_rename, 1)
        gzip(file_to_rename{i});
        if exist(file_to_rename{i}, 'file')
            delete(file_to_rename{i});
        end
    end


end

file = bids.File(file_to_rename{2}, 'use_schema', false);
 
    % specification to remove run entity
    spec.entities.date = '';
 
    % first run with dry_run = true to make sure we will get the expected output
    file = file.rename('spec', spec, 'dry_run', true, 'verbose', true);
 
    % rename the file by setting dry_run to false
    file = file.rename('spec', spec, 'dry_run', false, 'verbose', true);    


    
