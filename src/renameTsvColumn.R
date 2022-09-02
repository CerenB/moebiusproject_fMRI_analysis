rm(list=ls())

library(tidyverse)

# let's read tsv files and reorganize the trial_type with for loop to 
# make auditory cue in the trial_type to be modeled in GLM

# NOTE: we make modifications in derivatives folder ! ! ! 

pathToFunc <- '/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/RhythmBlock/code/rhythmBlock_fMRI_analysis/lib/bids-R/bidsr_queryEvents.R'
source(pathToFunc)


bidsRoot <- '/Users/battal/Cerens_files/fMRI/Processed/MoebiusProject/derivatives/cpp_spm/sub-pil009' 
# taskName <- 'somatotopy' 
taskName <- 'mototopy'

taskEventsFiles <- bidsr_queryEvents(bidsRoot = bidsRoot, 
                                     taskName = taskName)


# for loop to make auditory cue in the trial_type to be modeled in GLM
for (i in 1:length(taskEventsFiles)) {
  
  tsv <- read.table(paste(bidsRoot, taskEventsFiles[i], sep = '/'), header = TRUE)
  
  # trial_type as subCueOnset label
  # duration as subCueDuration
  # onset as subCueOnset value
  
  # control point = subjectCue already in the column, then do not do it again
  if (length(grep('block_subjectCue', tsv$trial_type)) ==0){
    print('...in progress')
    
    # 1. subset the data 
    data<- tsv[grep('block', tsv$trial_type), ]
    
    # # # # 
    # add if condition, if mototopy, data$cueOnset and data$cueDuration
    
    # # # # 
    if(taskName =='mototopy') {
      # 2. reassign the values
      data$onset <- data$cueOnset
      data$duration <- data$cueDuration
      
    } else{
      # 2. reassign the values
      data$onset <- data$subCueOnset
      data$duration <- data$subCueDuration
    }
    
    data$trial_type<-'block_subjectCue'
  
    # 3. combine with tav and order
    tsv <- rbind(tsv,data)
  
    write.table(tsv,
                paste(bidsRoot, taskEventsFiles[i], sep = '/'),
                row.names = FALSE,
                sep = '\t',
                quote = FALSE)
  } else {
    print('nothing to do here')
  }
  
}

