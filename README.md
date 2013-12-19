## Arabic Calligraphy Style Classification

This MATLAB code was developed as a project for the course Statistical Learning - Classification (STAT 841) at University of Waterloo. 

Steps to run: 

1.  Download Husni Al-Muhtaseb's PATS-A01 dataset from [here](http://goo.gl/JE9vY1). 
    This code has been tested for classfication of Akhbar, Thuluth, Naskh, and Andalus. 
    About 200 images of each style for the training set is sufficient. Put these in the ./\*/train/ folders   
    Put rest of the images in the ./\*/test/ folders
	
2.  Run extract.m. This extracts the feature set for each image into a .dat file.

3.  Run train_nn.m. This fits a single layer neural network to the training data. 

4.  Run test_nn.m. This displays the test error, and summary of misclassifications. 


Also, run testing.m to understand how features are being are extracted. 

Thanks to  Alessandro Mannini for his [Freeman Chain Code MATLAB function](http://www.mathworks.com/matlabcentral/fileexchange/29518-freeman-chain-code)