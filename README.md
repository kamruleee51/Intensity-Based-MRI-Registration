# Intensity-Based-MRI-Registration
## Written by:
## Md. Kamrul Hasan
## E-mail: kamruleeekuet@gmail.com

Image registration is one of the prior steps for building computational model and Computer added diagnosis   (CAD) which  is the processes of transferring images into a common coordinate system,  so that corresponding pixels represents  homologous  biological  points  [1].  In  this  lab,  we  have  familiarized  with  the  concepts  and  framework  of  image  registration  based  on  two  different  transformation  techniques  namely  “rigid  transformation”  and  “affine  transformation” for brain MRI. Comparisons also have been accomplished for single-resolution and multi-resolution  registration for the same images  in both  rigid transformation  and  affine transformation. Different  quantitative and  qualitative metric performance are also been observed for all the experiments. 

![TargetImages](https://user-images.githubusercontent.com/32570071/54872670-e2c67b80-4dc7-11e9-86e9-e5a02d251e8f.PNG)

Registration framework
Fig.1 shows the typical framework for image registration which have two input images, one is termed as fixed image and another one is termed as moving image. A transform represents the spatial mapping of points from the fixed image to points in the moving image. This establishes a correspondence for every pixel in the fixed image to a position in the moving image. The metric is a key component in the registration process. It uses information from the fixed and moving image to compute a similarity value. The derivative of this value tells us in which direction we should move the moving image for better alignment. The moving image is moved in small steps, and process is repeated until a convergence-criteria has satisfied.  

![ImageRegistration](https://user-images.githubusercontent.com/32570071/54872682-16a1a100-4dc8-11e9-80ae-3b494add26c3.PNG)

Multi-resolution mean representing or analyzing image at more than one resolution. The idea is we start with the original image and shrink it half of the size, and again shrined that by the same factor, eventually at the top of the pyramid we will get 1pixel size image. All the samples image in the multi-resolution pyramid are sub-sampled or approximated version of original image. So, the advantage of multi-resolution over single-resolution is that the size of the object is smaller in sub-sampled image and it improves the capture range and robustness of the registration. Additionally, it allows parallel processing.

![Multi-Registration](https://user-images.githubusercontent.com/32570071/54872676-fa9dff80-4dc7-11e9-9cf8-53d69f56a7e2.PNG)






## Reference

1. Viergever, M., Maintz, J., Klein, S., Murphy, K., Staring, M. and Pluim, J. (2016). A survey of medical image registration – under review. Medical Image Analysis, 33, pp.140-144. <b>
2. Marti, Robert. "MIRA: Week 1: Intensity based Image registration,pp.5, 25 October 2018. <b> 
3. O'Callaghan, Robert & Haga, Tetsuji. (2007). Robust Change-Detection by Normalised Gradient-Correlation. 10.1109/CVPR.2007.383516. <b>
4. Barbara Zitová, Jan Flusser: Image registration methods: a survey. Image Vision Comput. 21(11): 977-1000 (2003).
