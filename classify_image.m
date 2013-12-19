function [class_name] = classify_image(img_name)

A = imread(img_name);
A = normalize_image(A);

load('run1_train_data.mat')
labels = [1 2 3 4];
class_names = char('Akhbar', 'Andalus', 'Naskh', 'Tutluth');
features = extract_features(A);
classified_label = SingleLayerNeuralNetClassify(w1,b1,w2,b2, features, labels);

class_name = class_names(classified_label,:);
end
