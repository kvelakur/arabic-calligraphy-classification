% script for extracting training and testing data. 

clear;
work_dir = pwd;

% Add paths of the train/test/validate set images here
% Images of each style have a separate directory
% About 200 images of each styles works best
train_dir = {strcat(work_dir,'\A01_Akhbar_dest\train\'), strcat(work_dir,'\A01_Andalus_dest\train\'),strcat(work_dir,'\A01_Naskh_dest\train\'),strcat(work_dir,'\A01_Thuluth_dest\train\')};
test_dir = {strcat(work_dir,'\A01_Akhbar_dest\test\'), strcat(work_dir,'\A01_Andalus_dest\test\'),strcat(work_dir,'\A01_Naskh_dest\test\'),strcat(work_dir,'\A01_Thuluth_dest\test\')};


disp('extracting train features')
[Xtrain,Ytrain] = extract_features_bulk(train_dir);
save('train_feature.mat','Xtrain','Ytrain')

disp('extracting test features')
[Xtest,Ytest] = extract_features_bulk(test_dir);
save('test_feature.mat','Xtest','Ytest')

