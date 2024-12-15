# PETnet
Minimum Matlab implementation of individual whole-body graph build-up in Sun, T., Wang, Z., Wu, Y. et al. Identifying the individual metabolic abnormities from a systemic perspective using whole-body PET imaging. Eur J Nucl Med Mol Imaging 49, 2994–3004 (2022).

# Before you use
1. Make sure Matlab 2018b or above version is installed.
2. Make sure Brain connectivity toolbox (https://sites.google.com/site/bctnet/) is in your Matlab path.
3. The default visualization script is edited from https://github.com/okomarov/schemaball.
4. (Optional) Install Brainnet viewer or connectomeviewer if you want to visualize the network.
   
# How to use
1. Prepare a list of organ SULs or SUVs for each subject as structured in the "subjects" folder.
2. Run example_github.m to have a basic idea of how it works.
3. Substitute your datapath and generate an individual network for your purpose.

# More information
The original paper can be found here https://doi.org/10.1007/s00259-022-05832-7.
The related publications have used this method so far
1. Identifying the individual metabolic abnormalities from a systemic perspective using whole-body PET imaging. European Journal of Nuclear Medicine and Molecular Imaging. 2022;49:2994–3004.
2. Metabolic interactions between organs in overweight and obesity using total-body positron emission tomography. International Journal of Obesity 2024.
3. Individual-specific metabolic network based on 18F-FDG PET revealing multi-level aberrant metabolisms in Parkinson's disease. Human Brain Mapping, 2024.
4. Tau-PET abnormality as a biomarker for Alzheimer's disease staging and early detection: a topological perspective. Cereb Cortex. 2023.
5. IG-GCN: Empowering e-Health Services for Alzheimer's Disease Prediction. IEEE Transactions on Consumer Electronics. 2024.
