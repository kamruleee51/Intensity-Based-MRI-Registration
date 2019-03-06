function grad_cc=Gradient_cc(I_moving,I_fixed)
%% This code is written by Md. Kamrul Hasan
[r_moving,c_moving]=size(I_moving);
[r_fixed,c_fixed]=size(I_fixed);

if r_moving==r_fixed && c_moving==c_fixed
    % Calculate X and Y directional gradient of Moving and Fixed Image
    [movving_Grad_X,movving_Grad_Y]=imgradientxy(I_moving,'sobel');
    [fixed_Grad_X,fixed_Grad_Y]=imgradientxy(I_fixed,'sobel');
    
    corelation=sum(sum((movving_Grad_X.*fixed_Grad_X)+(movving_Grad_Y.*fixed_Grad_Y)));
    Variance_Moving_Image=sum(sum((movving_Grad_X).^2+(movving_Grad_Y).^2));
    Variance_fixed_Image=sum(sum((fixed_Grad_X).^2+(fixed_Grad_Y).^2));
    
    grad_cc=corelation/sqrt(Variance_Moving_Image*Variance_fixed_Image);
else
    disp('Moving and fixed Image supposed to have same dimension!!!')
end
end