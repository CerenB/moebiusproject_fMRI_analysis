

% we add all the subfunctions that are in the sub directories
opt = getOptionMoebius();

%re-write model file
opt.model.file = 

iSub = 1;

subLabel = opt.subjects{iSub};
funcFWHM = 6;

ffxDir = getFFXdir(subLabel, funcFWHM, opt);

spmMatFile = cellstr(fullfile(ffxDir, 'SPM.mat'));

load(spmMatFile{1}, 'SPM');

% read condition names from model and clean them
model = spm_jsonread(opt.model.file);
conditionNamesModel = model.Steps{1,1}.AutoContrasts;
erasePattern = 'trial_type.';
for i= 1:length(conditionNamesModel)   
    temp = conditionNamesModel{i};
    condition{i} = erase(temp,erasePattern);
end


% Create Contrasts and save the names
contrastsSPM = specifyContrasts(SPM, opt.taskName, model);
for i = 1:size(contrastsSPM, 2)
    conditionNamesSPM{i} = contrastsSPM(i).name;
end

% now get the index of the betas corresponding to your auto.contrasts
for iCond = 1:length(conditionNamesModel)
    for i =1:size(conditionNamesSPM, 2)
        idxConditions(iCond) = find(strcmp(conditionNamesSPM,condition{iCond}));
    end
end

% load those now
zero_padding = '00';
if min(idxConditions) < 10
    zero_padding = '000';
end

% we need contrasts images (con*.nii)
% they contain mean values of betas per condition
contrastImg = [];
for iCon = 1:length(idxConditions)

    conName = ['con_', zero_padding, num2str(idxConditions(iCon)), '.nii'];
    conFiles{iCon} = fullfile(ffxDir,conName);
    
    % while loading, save contrast images in 4th dimension
    contrast = load_nii(conFiles{iCon});
    contrastImg = cat(4, contrastImg, contrast.img);
    
    % save into a struct
    con{1,iCon} = contrast;
end

temp = contrast;
temp.fileprefix = 'contrast';
temp.img = [];

[Y, I] = max(contrastImg,[],4);

[Y2, I2] = squeeze(max(contrastImg,[],4));

% COMBINED = [BETA1; BETA2]
% [Y, I] = max(COMBINED, [], 1)


%   for icon = 1:size(contrasts, 2)
%     consess{icon}.tcon.name = contrasts(icon).name; %#ok<*AGROW>
%     consess{icon}.tcon.convec = contrasts(icon).C;
%     consess{icon}.tcon.sessrep = 'none';
%   end
  
  
        for iParcel = 1:parcelNb:(length(parcelCodes))

          parcelImg = [];

          % load the parcels in 1 hemisphere
          for i = iParcel:iParcel + (parcelNb - 1)

            parcelName = [parcelLabels{i}, '.nii'];
            parcel = load_untouch_nii(fullfile(parcelPath, subID, parcelName));
            parcelImg = cat(4, parcelImg, parcel.img);

          end

          % open a template to save these parcels into 1 image
          temp = parcel;
          temp.fileprefix = 'parcel';
          temp.img = [];

          % sum all the parcels
          temp.img = squeeze(sum(parcelImg, 4));
          % make binary mask
          temp.img(temp.img == parcelNb) = 1;
          
        end
        
        
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
          % Empty matrix of 4 dimensions (first 3 dimensions are the brain image,
  % the fourth dimention is the subject number)
  z = [];

  % first subject Number
  subjectNb = 1;

  % loop for each subject
  while subjectNb <= numSubjects

    % load the searchlight map
    temp = load_nii(subjFullfile{subjectNb});
    fprintf('Loading of Map %.0f finished. \n', subjectNb);

    % multiply by 100 to get number in percent
    k = temp.img * 100;

    % concatenate each subject to the 4th dimension
    z = cat(4, z, k);

    % increase the counter
    subjectNb = subjectNb + 1;
  end

  %% Mean Accuracy
  % calcuate mean accuracy maps
  % copy structure of one map
  meanMap = temp;

  % erase the values in the image
  meanMap.img = [];

  means = [];

  % Calculate mean of each voxel across subjects (4th dimension)
  means = mean(z, 4);

  meanMap.img = means;

  % save mean accuracy map as nifti map
  save_nii(meanMap, ...
           fullfile(resultFolder, ...
                    ['AverageAcc_', ...
                     prefixSmooth, ...
                     midFilePattern(1:end - 5), ...
                     '_subNb-', num2str(numSubjects), ...
                     '.nii']));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
