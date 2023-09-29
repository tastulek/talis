library(data.table)
getwd()
list.files()

#The data file should not have empty cells or cells with 'N";
mtDataFreq <- read.csv("Jetisuu_mtDNA_HgFreq_ReadyForPCA_v2.2_sorted_Mar30_20.csv")
mtDataFreq[1:3, 1:9]
dim(mtDataFreq)

# PCA analysis:
mtData.pr <- prcomp(mtDataFreq[c(2:52)], center = TRUE, scale = TRUE)
summary(mtData.pr)

#However, the PCA results are not written in a file:
list.files()

# Plotting the results (last modified on Feb 19, 2020):

library("factoextra")
library("ggpubr")
library("ggplot2")
help(package = ggplot2)

#fviz_pca_ind(): Graph of individuals

fviz_pca_ind(mtData.pr,
             axes = c(1, 2),
             pointsize = 1.5, 
             fill.ind = mtDataFreq$X.1,
             label="none", #New
             habillage=mtDataFreq$X.1, #New
             palette = get_palette("npg", 23),
             col.ind = "black", 
             col.var = "black",
             repel = TRUE,
             legend.title = "Populations") +
  labs(x = "PC1", y = "PC2") +
  ggtitle("mtDNA Haplogroup Frequency based PCA") +
  theme(plot.title = element_text(hjust = 0.5))



#fviz_pca_biplot(): Biplot of individuals and variables

fviz_pca_biplot(mtData.pr,
                axes = c(1, 2),
                pointsize = 1.5,
                fill.ind = mtDataFreq$X.1,
                label="all", #New
                habillage=mtDataFreq$X.1, #New
                palette = get_palette("npg", 22),
                col.ind = "black", 
                col.var = "black",
                repel = TRUE,
                legend.title = "Populations") +
    labs(x = "PC1", y = "PC2") +
    ggtitle("mtDNA Haplogroup Frequency based PCA (biplot)") +
    theme(plot.title = element_text(hjust = 0.5))


