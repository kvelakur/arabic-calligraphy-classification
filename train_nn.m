% script for training neural network
% run extract.m before running this

% load training data generated by extract.m
clear;
load('train_feature.mat')

[d,n] = size(Xtrain);

% fitting neural net with single hidden layer with 6 nodes, run for 4000
% iterations. learning rate 5e-2 and weight decay 1e-4
[w1,b1,w2,b2,labels,err] = SingleLayerNeuralNetFit(Xtrain,Ytrain, 6, 4000, 5e-2, 1e-4);
save('run1_train_data.mat', 'w1', 'b1', 'w2', 'b2','labels', 'err')