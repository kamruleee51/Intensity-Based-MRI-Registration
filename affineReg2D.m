function [ Iregistered, M] = affineReg2D( Imoving, Ifixed )
%Example of 2D affine registration
%   Robert Martí  (robert.marti@udg.edu)
%   Based on the files from  D.Kroon University of Twente 
tic;
% clean
clear all; close all; clc;

% Read two imges 
Imoving=im2double(rgb2gray(imread('brain1.png'))); 
Ifixed=im2double(rgb2gray(imread('brain2.png')));

Im=Imoving;
If=Ifixed;

mtype = 'gcc'; % metric type: sd: ssd gcc: gradient correlation; cc: cross-correlation
ttype = 'r'; % rigid registration, options: r: rigid, a: affine

% Parameter scaling of the Translation and Rotation
% and initial parameters
switch ttype
    case 'r'
        x=[0 0 0];
        scale = [0.1 0.1 1];
    case 'a'
        x=[0 0 0 1 1 0 0];
        scale = [1 1 0.1 1 1 0.0001 0.0001];
end


x=x./scale;
    
    
[x]=fminsearch(@(x)affine_registration_function(x,scale,Im,If,mtype,ttype),x,optimset('Display','iter','FunValCheck','on','MaxIter',2500, 'TolFun', 1.000000e-30,'TolX',1.000000e-30, 'MaxFunEvals', 2000*length(x),'PlotFcns',@optimplotfval));

x=x.*scale;

switch ttype
	case 'r'
        % Make the affine transformation matrix
         M=[ cos(x(3)) sin(x(3)) x(1);
            -sin(x(3)) cos(x(3)) x(2);
           0 0 1];
    case 'a'
        % Make the affine transformation matrix
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

%Parameters Findings 
Translation_X=x(1);
Translation_Y=x(2);
Rotation=x(3);
disp(Translation_X)
disp(Translation_Y)
disp(Rotation)

% Show the registration results
figure,
subplot(2,2,1), imshow(If), title('Fixed Image');
subplot(2,2,2), imshow(Im), title('Moving Image');
subplot(2,2,3), imshow(Icor), title('Corrected Image');
subplot(2,2,4), imshow(abs(If-Icor)), title('(Fixed-Corrected) Image');
toc;
end

