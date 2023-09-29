library(data.table)
library(tibble)
library(factoextra)
library(ggpubr)
library(ggplot2)
library(ape)
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
mt_freq = mtDataFreq[ , which(apply(mtDataFreq, 2, var) != 0)]

# for changing a column name;
mtG_Freq[1,1]
colnames(mtG_Freq)
# adding the popID column again;
popID <- mtDataFreq$popID
mt_freq <- add_column(mt_freq, popID, .before = 1)
mt_freq[1:3, 1:3]
dim(mt_freq)

#write.csv(mtG_Freq, file = 'mtG_Freq_k_Pol_flt.csv', row.names = FALSE, quote = FALSE)

# MDS analysis:

# Generate a distance data;
mt_dist <- dist(mt_freq)

dim(mt_dist)
summary(mt_dist)
mt_mds <- pcoa(mt_dist)
dim(mt_mds)
summary(mt_mds)

mt_mds$vectors[1:3, 1:3]

x <- mt_mds$vectors[,1]
y <- mt_mds$vectors[,2]

plot(mt_mds$vectors[,1], mt_mds$vectors[,2], type = "n", xlab = "", ylab = "",
     axes = FALSE, main = "pcoa (ape)")

text(mt_mds$vectors[,1], mt_mds$vectors[,2], labels(mt_dist), 
     cex = 0.9, xpd = TRUE)

mdspoints <- data.frame(mt_mds)

mt_mds %>% head()

mt_mds %>% plot()
colnames(mt_mds)

# classical MDS scaling

mt_cmds <- cmdscale(mt_dist, eig=TRUE, k=2)

x <- mt_cmds$points[,1]
y <- mt_cmds$points[,2]

plot(x, y, xlab="Coordinate 1", ylab="Coordinate 2",
     main="Metric MDS", type="n")
text(x, y, labels = mt_freq$popID, cex=.7)


help("cmdscale")

#fviz_pca_ind(): Graph of individuals

fviz_pca_ind(mt_mds,
             axes = c(mt_mds$vectors[,1], mt_mds$vectors[,2]),
             pointsize = 1.5, 
             fill.ind = mt_freq$popID,
             label="none", #New
             habillage=mt_freq$popID, #New
             palette = get_palette("npg", 23),
             col.ind = "black", 
             col.var = "black",
             repel = FALSE,
             legend.title = "Populations") +
  labs(x = "C01", y = "C02") +
  ggtitle("mtDNA Haplogroup Frequency based MDS") +
  theme(plot.title = element_text(hjust = 0.5))


