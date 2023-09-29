library(data.table)
library(tibble)
library(factoextra)
library(ggpubr)
library(ggplot2)

getwd()
list.files()
R.version.string


# opening the Ht freq data file;
mtDataFreq <- read.csv("Jetisuu_mtDNA_HgFreq_ReadyForPCA_v5.1_May27_22.csv" )
mtDataFreq[1:3, 1:4]
dim(mtDataFreq)

colnames(mtDataFreq)[1] <- "popID"

# finding zero/constant columns;
#noVar_Ht <- which(apply(mtDataFreq, 2, var) == 0)
#length(noVar_Ht)

# saving the list of haplotypes, which do not occur in the sample set;
#write.csv(noVar_Ht, file = 'Ht_noVar.csv')

# removing zero/constant columns;
mtG_Freq = mtDataFreq[ , which(apply(mtDataFreq, 2, var) != 0)]

# for changing a column name;
mtG_Freq[1,1]
colnames(mtG_Freq)
# adding the popID column again;
popID <- mtDataFreq$popID
mtG_Freq <- add_column(mtG_Freq, popID, .before = 1)
mtG_Freq[1:3, 1:3]
dim(mtG_Freq)

#write.csv(mtG_Freq, file = 'mtG_Freq_k_Pol_flt.csv', row.names = FALSE, quote = FALSE)

# PCA analysis:
mtG_pr <- prcomp(mtG_Freq[ ,c(2:52)], center = TRUE, scale. = TRUE)
summary(mtG_pr)

# for viewing different PCs;
screeplot(mtG_pr, type = "l", npcs = 10, main = "Screeplot for the 10 PCs")
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Eigenvalue = 1"),
       col=c("red"), lty=5, cex=0.6)

fviz_eig(mtG_pr, addlabels = TRUE, ylim = c(0, 20))

# Plotting the PCA results (last modified on Apr 3, 2022):
#fviz_pca_ind(): Graph of individuals

#length(gen_dist_for_pca)
mtG_pr

eigen_val <- get_eigenvalue(mtG_pr)
eigen_val

mtG_Freq$popID
# Plotting the PCA results (last modified on Jun 15, 2021):

#fviz_pca_ind(): Graph of individuals

fviz_pca_ind(mtG_pr,
             axes = c(1, 2),
             pointsize = 1.5, 
             fill.ind = mtG_Freq$popID,
             label="none", #New
             habillage=mtG_Freq$popID, #New
             palette = get_palette("npg", 23),
             col.ind = "black", 
             col.var = "black",
             repel = FALSE,
             legend.title = "Populations") +
  labs(x = "PC1 [15.7%]", y = "PC2 [10.3%]") +
  ggtitle(NULL) +
  theme(plot.title = element_text(hjust = 0.5))


