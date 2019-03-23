# Intensity-Based-MRI-Registration
# Written by:
# Md. Kamrul Hasan
# E-mail: kamruleeekuet@gmail.com

Image registration is one of the prior steps for building computational model and Computer added diagnosis   (CAD) which  is the processes of transferring images into a common coordinate system,  so that corresponding pixels represents  homologous  biological  points  [1].  In  this  lab,  we  have  familiarized  with  the  concepts  and  framework  of  image  registration  based  on  two  different  transformation  techniques  namely  “rigid  transformation”  and  “affine  transformation” for brain MRI. Comparisons also have been accomplished for single-resolution and multi-resolution  registration for the same images  in both  rigid transformation  and  affine transformation. Different  quantitative and  qualitative metric performance are also been observed for all the experiments. 

Registration framework
Fig.1 shows the typical framework for image registration which have two input images, one is termed as fixed image and another one is termed as moving image. A transform represents the spatial mapping of points from the fixed image to points in the moving image. This establishes a correspondence for every pixel in the fixed image to a position in the moving image. The metric is a key component in the registration process. It uses information from the fixed and moving image to compute a similarity value. The derivative of this value tells us in which direction we should move the moving image for better alignment. The moving image is moved in small steps, and process is repeated until a convergence-criteria has satisfied.  

# Reference
[1] Viergever, M., Maintz, J., Klein, S., Murphy, K., Staring, M. and Pluim, J. (2016). A survey of medical image registration – under review. Medical Image Analysis, 33, pp.140-144.
[2] Marti,Robert. "MIRA: Week 1: Intensity based Image registration,pp.5, 25 October 2018.
[3] O'Callaghan, Robert & Haga, Tetsuji. (2007). Robust Change-Detection by Normalised Gradient-Correlation. 10.1109/CVPR.2007.383516.
[4] Barbara Zitová, Jan Flusser: Image registration methods: a survey. Image Vision Comput. 21(11): 977-1000 (2003).
