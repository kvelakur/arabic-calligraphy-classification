% Function to train a neural net with a single hidden layer.
% input layer dx1, hidden layer nodesx1, output layer kx1
% Inputs:
%   Xtrain - dxn matrix, training set of n samples of d dimensional data
%   Ytrain - nx1 vector, ground truth. Class labels 1 to k.
%   nodes  - number of nodes in hidden layer
%   iterations - number of epochs in training
%   rho - learning rate
%   lambda - weight decay rate
% Outputs:
%   w1,w2,b1,b2 - weights and biases for layers
%   error - mean squared error
% Reference used - http://ufldl.stanford.edu/wiki/index.php/Backpropagation_Algorithm
function [w1,b1,w2,b2,labels,error] = SingleLayerNeuralNetFit(Xtrain,Ytrain,nodes,iterations,rho,lambda)

[d,n] = size(Xtrain);

% randomize order of data in Xtrain
random_order = randperm(n);
Xtrain = Xtrain(:,random_order);
Ytrain = Ytrain(random_order);

% labels, and number of classes k
labels = sort(unique(Ytrain))';
k = size(labels,2);

% indicator vector
indicator = zeros(size(labels,1),n);
for ii = 1:k
    indicator(ii,Ytrain==labels(ii)) = 1;
end

% activation function
f = @(x) 1./(1+exp(-x));

% weight matricies
w1 = rand(nodes,d);
w2 = rand(k,nodes);

% bias vectors
b1 = rand(nodes,1); b2 = rand(k,1);

% train for epochs
epoch = 0;
while epoch < iterations
    del_w2 = zeros(size(w2));
    del_w1 = zeros(size(w1));
    del_b1 = zeros(size(b1));
    del_b2 = zeros(size(b2));
    all_errors = zeros(k,n);
    for ii = 1:n
        % calculate output using forward propagation
        y0 = Xtrain(:,ii);
        y1 = f(w1*y0 + b1);
        y2 = f(w2*y1 + b2);
        error = indicator(:,ii) - y2;
        all_errors(:,ii) = error;
        
        % backpropagate
        sigma2 = -error .* y2 .* (1 - y2);
        sigma1 = (w2' * sigma2) .* y1 .* (1 - y1);
        
        % update weights and biases
        del_w2 = del_w2 + sigma2 * y1';
        del_w1 = del_w1 + sigma1 * y0';
        del_b2 = del_b2 + sigma2;
        del_b1 = del_b1 + sigma1;
    end
    w1 = w1 - rho.*(del_w1 + 2*lambda.*w1);
    w2 = w2 - rho.*(del_w2 + 2*lambda.*w2);
    b1 = b1 - rho.*(del_b1);
    b2 = b2 - rho.*(del_b2);
    
    epoch = epoch + 1;
end

% mean squared sum of errors
mss = sum(sum(all_errors.^2).^0.5);
error = mss/n;

end
