# WB-PETnet
Minimum Matlab implementation of "individual whole-body graph build-up in Sun, T., Wang, Z., Wu, Y. et al. Identifying the individual metabolic abnormities from a systemic perspective using whole-body PET imaging". Eur J Nucl Med Mol Imaging 49, 2994–3004 (2022).

# Before you use
1. Make sure Matlab 2018b or above version is installed.
2. Make sure Brain connectivity toolbox (https://sites.google.com/site/bctnet/) is in your Matlab path.
3. The default visualization script is edited from https://github.com/okomarov/schemaball.
4. (Optional) Install Brainnet viewer or connectomeviewer if you want to visualize the network.
   
# How to use
1. Prepare a list of organ SULs or SUVs for each subject as structured in the "subjects" folder.
2. Run example.m to have a basic idea of how it works.
3. Substitute your datapath and generate an individual network for your purpose.

# More information
The original paper can be found here https://doi.org/10.1007/s00259-022-05832-7.
The related publications have used this method so far
* Sun et al, Identifying the individual metabolic abnormalities from a systemic perspective using whole-body PET imaging. European Journal of Nuclear Medicine and Molecular Imaging. 2022;49:2994–3004.
* Lu et al, Metabolic interactions between organs in overweight and obesity using total-body positron emission tomography. International Journal of Obesity 2024.
* Lu et al,Individual-specific metabolic network based on 18F-FDG PET revealing multi-level aberrant metabolisms in Parkinson's disease. Human Brain Mapping, 2024.
* Ding et al, Tau-PET abnormality as a biomarker for Alzheimer's disease staging and early detection: a topological perspective. Cerebral Cortex. 2023.
* Chen et al,IG-GCN: Empowering e-Health Services for Alzheimer's Disease Prediction. IEEE Transactions on Consumer Electronics. 2024.
* Wang et al, Organs and Systems Glucose Metabolism Analysis in Different Smoking Groups for Lung Cancer Patients using Total-body PET/CT, IEEE Nuclear Science Symposium (NSS), Medical Imaging Conference (MIC) and Room Temperature Semiconductor Detector Conference (RTSD), Tampa, USA, 2024.
* Sun et al. The Brain-White Adipose Tissue Axis May Play a Crucial Role in Diabetes Mellitus: A Metabolic Network Analysis Using Total-Body PET/CT Imaging, European Journal of Nuclear Medicine and Molecular Imaging, 2025.
* Chen et al, MR-guided graph learning of 18F-florbetapir PET enables accurate and interpretable Alzheimer’s disease staging. Neuroimage. 2025.
* Tao X, Wang H, Hu Zhanli et al. Exploring the metabolic landscape of lung adenocarcinoma and squamous cell carcinoma: a total-body [18F]FDG PET/CT approach. European Journal of Nuclear Medicine and Molecular Imaging, 2025.
* Tao X, Guan Z, Hu Zhanli et al. Mapping systemic inter-organ metabolic networks across the glycemic continuum using whole-body [¹⁸F]FDG PET/CT and machine learning. European Journal of Nuclear Medicine and Molecular Imaging, 2025.
* Wang H, Guan Z, Hu Zhanli et al. Metabolic network analysis of lung adenocarcinoma and squamous cell carcinoma via static and dynamic total-body PET/CT imaging. Medical Physics, 2025.
