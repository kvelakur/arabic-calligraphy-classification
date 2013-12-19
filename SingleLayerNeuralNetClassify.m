% Function to perform classification based on weights and biases 
% Inputs:
%   w1,w2,b1,b2 - weights and biases
%   Xtest - dxn matrix. n samples of d dimensional data
%   labels - kx1 vextor. Labels into which NN will classify
% Outputs:
%   Ytest - nx1 vextor of labels of classified data.
function [Ytest] = SingleLayerNeuralNetClassify(w1,b1,w2,b2, Xtest, labels)

% activation function
f = @(x) 1./(1+exp(-x));

[~, n_test] = size(Xtest);
Ytest = zeros(n_test,1);
for ii = 1:n_test
    y0 = Xtest(:,ii);
    y1 = f(w1*y0 + b1);
    y2 = f(w2*y1 + b2);    
    [~,index] = max(y2);
    Ytest(ii) = labels(index);
end
end