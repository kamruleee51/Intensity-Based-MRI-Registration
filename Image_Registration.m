%% This code is modified and written by Md. Kamrul Hasan
% Reference of this code is given below-

%% Reference of the code
%Example of 2D affine registration
%   Robert Martí  (robert.marti@udg.edu)
%   Based on the files from  D.Kroon University of Twente 

%% clean
tic;
clear all;
close all; 
clc;

%% Read two imges 
% For brain1.png and brain2.png, rigid transformation is enough.
% For brain3.png and brain2.png, rigid transformation is not enough. And in
% this case, affine transformation is the better.

Imoving=im2double(rgb2gray(imread('brain4.png'))); 
Ifixed=im2double(rgb2gray(imread('brain2.png')));

%% Select the metric type and transformation type
% metric type: sd: ssd; gcc: gradient correlation; cc: cross-correlation
% For the Image brain4.png use gcc_2: gradient correlation instead of gcc which describe in the
% report.
mtype = 'gcc_2'; 
% rigid registration, options: r: rigid, a: affine
ttype = 'a'; 
% if you put Level_of_G_Pyramid=0, it will for original Image only.
% if you put Level_of_G_Pyramid=1, meaning one time downsampling and so on....
% Level_of_G_Pyramid can be maximum 8. After 8 times, it will only 2x2 image. 

Level_of_G_Pyramid=6;

%% Parameters Initilalization
% Parameter scaling of the Translation and Rotation if rigid
% Parameter scaling of the Translation, Rotation, Scalling, and Shearing if
% affine

switch ttype
case 'r'
x=[0 0 0];
scale = [0.1 0.1 1]; % 3-DOF
case 'a'
x=[0 0 0 1 1 0 0]; % 7-DOF
scale = [1 1 0.1 1 1 0.0001 0.0001];
end
x=x./scale;

%% Gaussian Pyramid for the Multiresulation.
% In the image cell, I will store image for the Optimizer. If Level_of_G_Pyramid=0
% I will have one image (original only) in the cell. if Level_of_G_Pyramid=1,
% I will have 2 images in the cell one is original and another one is from
% the Gaussian pyramid. And so on..........
Total_Image=Level_of_G_Pyramid+1;
I_ff=Ifixed;
I_mv=Imoving;
my_im_cell_1 = cell(Total_Image,1);
my_im_cell_2 = cell(Total_Image,1);
for i=1:1:Total_Image
my_im_cell_1{i}=I_ff;
I_ff = Down_Sampler_Gaussian_Pyramid(I_ff);
my_im_cell_2{i}=I_mv;
I_mv = Down_Sampler_Gaussian_Pyramid(I_mv);
end

%% Optimization
for k=Total_Image:-1:1
Im=my_im_cell_2{k};
If=my_im_cell_1{k};
[x]=fminsearch(@(x)affine_registration_function(x,scale,Im,If,mtype,ttype),x,optimset('Display','iter','FunValCheck','on','MaxIter',1500, 'TolFun', 1.000000e-30,'TolX',1.000000e-30, 'MaxFunEvals', 2000*length(x),'PlotFcns',@optimplotfval));
switch ttype
    case 'a'
    scaleTxTy = [2 2 1 1 1 1 1]; % Only doubling the Tx and Ty, others kept constant.
    x=x.*scaleTxTy;
    case 'r'
    scaleTxTy = [2 2 1]; % Only doubling the Tx and Ty, others kept constant.
    x=x.*scaleTxTy;
end
end

%% Parameters rescalling to get actual parameters
x=x./scaleTxTy;
x=x.*scale;

%% Getting the registrated Image
switch ttype
case 'r'
% Make the affine transformation matrix
 M=[ cos(x(3)) sin(x(3)) x(1);
    -sin(x(3)) cos(x(3)) x(2);
   0 0 1];
case 'a'
    M_rigid_Scalled=[ x(4)*cos(x(3)) sin(x(3)) x(1);
    -sin(x(3)) x(5)*cos(x(3)) x(2);
    0 0 1];
    M_shearing=[1 x(6) 0;
    x(7) 1 0;
    0 0 1];
    M=M_rigid_Scalled*M_shearing;
end
% Transform the image 
Icor=affine_transform_2d_double(double(Im),double(M),0); % 3 stands for cubic interpolation

switch mtype
    case 'sd'
        Best_metric=sum((Icor(:)-Ifixed(:)).^2)/numel(Icor);
    case 'cc' % Normalized Cross-corelation
        Best_metric=Calculate_NCC(Ifixed,Icor);
    case 'gcc' % Gradient Cross-corelation
        Best_metric=Gradient_cc(Ifixed,Icor);
    case 'gcc_2' % Gradient Cross-corelation for brain4.png
        Best_metric=Gradient_cc_2(Ifixed,Icor);
end
%% Parameters Findings and Printing/Displaying 
switch ttype
    case 'r'
    fprintf('\n -------------Rigid Parameters------------ \n \n ');
    fprintf('Translation in X dirrection is %.4f \n \n',x(1));
    fprintf('Translation in Y dirrection is %.4f \n \n',x(2));
    fprintf('Rotation about M/2 and N/2 is %.4f \n \n',x(3));
    fprintf('Best quantative metric (%s) is %.4f \n \n',mtype,Best_metric);
    
    case 'a'
    fprintf('\n -------------Affine Parameters------------ \n \n ');
    fprintf('Translation in X dirrection is %.4f \n \n ',x(1));
    fprintf('Translation in Y dirrection is %.4f \n \n',x(2));
    fprintf('Rotation about M/2 and N/2 is %.4f \n \n',x(3));
    fprintf('Scaling in X direction is %.4f \n \n',x(4));
    fprintf('Scaling in Y direction is %.4f \n \n',x(5));
    fprintf('Horizontal Shearing is %.4f \n \n',x(6));
    fprintf('Vertical Shearing is %d \n \n',x(7));
    fprintf('Best quantative metric (%s) is %.4f \n \n',mtype,Best_metric);
end

%% Show the registration results
figure,
subplot(2,2,1), imshow(If), title('Fixed Image');
subplot(2,2,2), imshow(Im), title('Moving Image');
subplot(2,2,3), imshow(Icor), title('Corrected Image');
subplot(2,2,4), imshow(abs(If-Icor)), title('(Fixed-Corrected) Image');
toc;

%% -------------------------THE END------------------------------