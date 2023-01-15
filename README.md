# Data
1. Parcellations
	
    * Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm.nii

    * Schaefer2018_400Parcels_7Networks_order_FSLMNI152_2mm.nii

    * Schaefer2018_200Parcels_7Networks_order_FSLMNI152_2mm.nii
	
2. Spatial maps of leading eigenmodes

    * Folder HCP 

    * Folder Sleep-deprivation

    * Folder Beijing_Zang 
  
>Note: Each folder contains leading eigenmodes obtained from R-fMRI data of the corresponding dataset. For the HCP dataset, leading eigenmodes for REST1 are provided at three spatial resolutions (i.e., 1000, 400 and 200 regions). For sleep-deprivation data, leading eigenmodes of two states (i.e., rested wakefulness and post-sleep deprivation) are provided.
	
3. Functional connectivity
	
    * FC_group_original.mat

    * FC_group_reconst.mat
>Note: This fold contains the original and reconstructed functional connectivity matrices at the group level. These functional connectivity patterns were obtained from the R-fMRI data of REST1 in the HCP dataset. The reconstructed functional connectivity pattern was obtained based on the five leading eigenmodes.


# Codes
1. Eigenmode identification
 
    * eigenmode_extract.m

2. Identification of leading eigenmodes
	
    * calc_leading_eigenmode_number.m

3. Functional connectivity reconstruction
	 
     * reconst_FC.m


# References
1. Schaefer A, et al. (2018) Local-Global Parcellation of the Human Cerebral Cortex from Intrinsic Functional Connectivity MRI. Cereb Cortex 28(9):3095-3114.
2. Wang J, Wang X, Xia M, Liao X, Evans A, He Y. GRETNA: a graph theoretical network analysis toolbox for imaging connectomics. Front Hum Neurosci. 2015;9:386.
3. Sun Y, et al. (2021) Eigen microstates and their evolutions in complex systems. Communications in Theoretical Physics 73(6).
