function [Xtrain,Ytrain] = extract_features_bulk(train_dir)

[~,num_dir] = size(train_dir);

% get list of files in traininf set directories
files = cell(size(train_dir));
num_files = zeros(num_dir,1);
for ii=1:num_dir
    files{ii} = ls(strcat(train_dir{ii},'*.tif'));
    num_files(ii) = size(files{ii},1);
end

% number of dimensions
d = 10;

Xtrain = zeros(d,sum(num_files));
Ytrain = zeros(sum(num_files),1);

kk=0;
for ii=1:num_dir    
    for jj=1:num_files(ii)
        kk=kk+1;
        disp(strcat('files1-', int2str(jj),'-of-',int2str(num_files(ii))) )
        A = imread(strcat(train_dir{ii},files{ii}(jj,:)));
        A = normalize_image(A);
        Xtrain(:,kk) = extract_features(A);
        Ytrain(kk) = ii; 
    end
end

% randomize order of data in Xtrain
[~,n] = size(Xtrain);
random_order = randperm(n);
Xtrain = Xtrain(:,random_order);
Ytrain = Ytrain(random_order);

end

