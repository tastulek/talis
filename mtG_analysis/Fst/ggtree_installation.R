# Apr 29, 2022

# Installation of ggtree, which is not available at CRAN;

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")