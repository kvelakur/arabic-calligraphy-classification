% script for classifying test data
% run extract.m and train_nn.m before running this

clear;
load('test_feature.mat')

[d,n] = size(Xtest);

load('run1_train_data.mat')

[Ytrain_classified] = SingleLayerNeuralNetClassify(w1,b1,w2,b2, Xtest, [1 2 3 4]);
train_err = 1 - size(find(Ytrain_classified-Ytest == 0),1)/n;
disp(strcat('training error = ',num2str(train_err)))

for ii=labels
    for jj=labels
        disp(strcat([num2str(ii), ' classified as ', num2str(jj), ' = ', num2str(size(find(Ytest==ii & Ytrain_classified==jj),1))]))
    end
end