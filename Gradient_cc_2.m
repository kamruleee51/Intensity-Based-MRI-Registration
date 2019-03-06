function grad_cc=Gradient_cc_2(Imoving,Ifixed)
%% This code is written by Md. Kamrul Hasan
[r_moving,c_moving]=size(Imoving);
[r_fixed,c_fixed]=size(Ifixed);
if r_moving==r_fixed && c_moving==c_fixed
    [movving_Grad_X,movving_Grad_Y]=imgradientxy(Imoving,'sobel');
    [fixed_Grad_X,fixed_Grad_Y]=imgradientxy(Ifixed,'sobel');
    movving_Grad_X=-movving_Grad_X;
    movving_Grad_Y=-movving_Grad_Y;
    cor=sum(sum((movving_Grad_X.*fixed_Grad_X)+(movving_Grad_Y.*fixed_Grad_Y)));
    d1=sum(sum((movving_Grad_X).^2+(movving_Grad_Y).^2));
    d2=sum(sum((fixed_Grad_X).^2+(fixed_Grad_Y).^2));
    grad_cc=cor/sqrt(d1*d2);
else
    disp('Moving and fixed Image supposed to have same dimension!!!')
end
end