#Nov 10, 2020
#This R script is for retrieving BAM format MSA data and save it as dataframe.


library(data.table)
library(Rsamtools)
getwd()
list.files()

#Read the SAM file which contains binary alignment of 2274 mtGenomes;



  #mtData <- scanBam("Jeti_CentEurAsia_mtG_N2274_bwa_aln_sorted_Mar16_20.bam", 
                  #index = "Jeti_CentEurAsia_mtG_N2274_bwa_aln_sorted_Mar16_20.bai")

#Retrieve MSA file in BAM format:
mtData <- scanBam("Jeti_CentEurAsia_mtG_N2274_bwa_aln_sorted_Mar16_20.bam")

#Names of BAM fields:

names(mtData[[1]])

#Distribution of BAM flags:

table(mtData[[1]]$flag)

#Converting the list of lists into a single list, as per described in Rsamtools:
.unlist <- function (x){
  ## do.call(c, ...) coerces factor to integer, which is undesired
  x1 <- x[[1L]]
  if (is.factor(x1)){
    structure(unlist(x), class = "factor", levels = levels(x1))
  } else {
    do.call(c, x)
  }
}

#Record the names of BAM fields:

fieldName <- names(mtData[[1]])

#Unlist each of the BAM fields:

katar <- lapply(fieldName, function(y) .unlist(lapply(mtData, "[[", y)))

#Convert the list into dataframe:

mtData_df <- do.call("DataFrame", katar)
names(mtData_df) <- fieldName

dim(mtData_df)

mtData_df[1:3, 1:7]
mtData_df[1:3, 8:13]

help("Rsamtools")

class(mtData_df)
class(mtDataIndex)
dim(mtDataIndex)


head(mtData_df)
scanBamWhat()
mtData_df
seqinfo(mtData_df)
class(mtData)
class(mtDataCount)
dim(mtDataCount)
mtDataCount[1, 1:7]
names(mtData)
length(mtData[["qname"]])

dim(mtData)

sapply(names(mtData[[1]]), class)

dim(mtData)

help("scanBam")

head(mtData)

# PCA analysis:

mtData.pr <- prcomp("Jeti_CentEurAsia_mtG_N2274_bwa_aln_sorted_Mar16_20.bam", 
                    center = TRUE, scale = TRUE)

mtData.pr <- prcomp(mtData_df, center = TRUE, scale = TRUE)
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


