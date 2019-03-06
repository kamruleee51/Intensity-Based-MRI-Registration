function Output_Image= Down_Sampler_Gaussian_Pyramid(input_Image)
%% This code is written By Md. Kamrul Hasan
%% If "Image" is m-by-n, the size of "Output_Image" is ceil(M/2)-by-ceil(N/2)

Center = 0.6; % 0.6 in the Paper
G_distribution = [0.25-Center/2 0.25 Center 0.25 0.25-Center/2]; %Logic was from orginal Paper
%Burt and Adelson, "The Laplacian Pyramid as a Compact Image Code," IEEE Transactions on 
%Communications, Vol. COM-31, no. 4, April 1983, pp. 532-540.
Gaussian_kernel = kron(G_distribution,G_distribution');
Image_Size = size(input_Image);
Output_Image = [];

for channel = 1:size(input_Image,3)
	Image_each_Channnel = input_Image(:,:,channel);
	Filtering = imfilter(Image_each_Channnel,Gaussian_kernel,'replicate','same');
	Output_Image(:,:,channel) = Filtering(1:2:Image_Size(1),1:2:Image_Size(2));
end
end