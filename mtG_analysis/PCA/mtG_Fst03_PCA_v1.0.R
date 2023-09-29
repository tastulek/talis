library(data.table)
library(tibble)
library(factoextra)
library(ggpubr)
library(ggplot2)

getwd()
list.files()
R.version.string

help("list.files")
# opening the Ht freq data file;
gen_dist <- read.csv( "mtG_N2074_Fst_Nei.csv", header = TRUE)

gen_dist$X
dim(gen_dist)

help("stats")

# PCA analysis:
gen_dist_for_pca <- prcomp(gen_dist[ ,c(2:13)], center = TRUE, scale. = TRUE)

prcom
# for viewing different PCs;
screeplot(gen_dist_for_pca, type = "l", npcs = 12, main = "Screeplot for the 12 PCs")
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Eigenvalue = 1"),
       col=c("red"), lty=5, cex=0.6)

# Plotting the PCA results (last modified on Apr 3, 2022):
#fviz_pca_ind(): Graph of individuals

#length(gen_dist_for_pca)
gen_dist_for_pca

eigen_val <- get_eigenvalue(gen_dist_for_pca)
eigen_val

fviz_eig(gen_dist_for_pca, addlabels = TRUE, ylim = c(0, 70))

fviz_pca_i
fviz_pca_ind(gen_dist_for_pca,
             axes = c(1, 2),
             label = "none",
             habillage = gen_dist$X,
             palette = get_palette("npg", 23),
             legend.title = "Populations") +
  labs(x = "PC1 [68.55%]", y = "PC2 [24.94%]") +
  ggtitle("mtDNA Genetic Distance based PCA") +
  theme(plot.title = element_text(hjust = 0.5))
  