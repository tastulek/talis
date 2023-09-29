library(data.table)
getwd()
list.files()
mtData <- read.csv("Jetisuu_mtDNA_HG_Freq_Jan13_20.csv", header = TRUE)

mtData[1:7,1:3]
colnames(mtData) <- mtData[1,]
row.names(mtData) <- NULL
dim(mtData)
mtData[1,1]

dim(RowNames)
dim(mtData[1])
neoMtData <- mtData[2:63,]
neoMtData[1:7,1:3]
dim(neoMtData)
neoRows <-row.names(neoMtData)
write.csv(mtData, file = "Jetisuu_mtDNA_HG_Freq_neoFormat_Jan13_20.csv", row.names = FALSE,
          col.names = FALSE)
neoMtData <- read.csv("Jetisuu_mtDNA_HG_Freq_neoFormat_Jan13_20.csv", header = FALSE)
dim(neoMtData)
neoMtData[1:7, 1:3]
ethnic_id <- neoMtData[2,, drop = TRUE]
neoMtData[2, ]
ethnic_id <- c(neoMtData[2,, drop = TRUE])
ethnic_id[2:3]
ethnic_id_list <- c('Hg', 'Edo_Ainu',  'Hok_Jomon', 'Okh_Ainu', 'Mod_Ainu', 'Main_JP', 'Okinawans', 'Koreans', 'Han_CN', 'Ulchi',
                    'Even', 'Nivkhi',  'Udegey', 'Negidal', 'Koryak', 'Itelmen',  'Barghuts', 'Alt_Kazaks', 'Jeti_Kazaks')
dim(ethnic_id)
ethnic_id_v2.0 <- neoMtData[2,]
ethnic_id_v2.0[1:3]
ethnic_id_v2.0[2:3]
dim(ethnic_id_v2.0)

neoMtData.v2.0 <- neoMtData[3:64,]
dim(neoMtData.v2.0)
neoMtData.v2.0[1:7, 1:3]
c(ethic_id)
ethic_id[1:3]

names(neoMtData.v2.0) <- c(ethnic_id_list)

# For transposing the data:
trans_neoMtData.v2.0 <- transpose(neoMtData.v2.0)

# For changing row and column names:
colnames(trans_neoMtData.v2.0) <- rownames(neoMtData.v2.0)
rownames(trans_neoMtData.v2.0) <- colnames(neoMtData.v2.0)

# For checking the transposed data:
trans_neoMtData.v2.0[1:7, 1:3]

# For replacing the column names with the first row:
Hg <- c(trans_neoMtData.v2.0[1,, drop = TRUE])
names(trans_neoMtData.v2.0) <- Hg

# For removing the 1st row:
final_neoMtData <- trans_neoMtData.v2.0[-c(1), ]

dim(final_neoMtData)
final_neoMtData[1:7, 1:3]

# Saving the data:
write.csv(final_neoMtData, file = "Jetisuu_mtDNA_HgFre_final.csv")

mtDataFreq <- read.csv("Jetisuu_mtDNA_HgFre_final.csv", row.names = TRUE)
mtDataFreq[1, 1:7]
dim(mtDataFreq)
# PCA analysis:
mtData.pr <- prcomp(mtDataFreq[c(2:63)], center = TRUE, scale = TRUE)
summary(mtData.pr)
list.files()

# Plotting the results:

screeplot(mtData.pr, type = "l", npcs = 15, main = "Screeplot of the first 10 PCs")
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Eigenvalue = 1"),
       col=c("red"), lty=5, cex=0.6)

cumpro <- cumsum(mtData.pr$sdev^2 / sum(mtData.pr$sdev^2))
plot(cumpro[0:15], xlab = "PC #", ylab = "Amount of explained variance", main = "Cumulative variance plot")
abline(v = 6, col="blue", lty=5)
abline(h = 0.88759, col="blue", lty=5)
legend("topleft", legend=c("Cut-off @ PC6"),
       col=c("blue"), lty=5, cex=0.6)

list.files()

plot(mtData.pr$x[,1],mtData.pr$x[,2], xlab="PC1 (44.3%)", ylab = "PC2 (19%)",
     main = "PC1 / PC2 - plot")

plot(mtData.pr$x[,1],mtData.pr$x[,3], xlab="PC1", ylab = "PC3",
     main = "PC1 / PC3 - plot")

library("factoextra")
fviz_pca_ind(mtData.pr, geom.ind = "point", pointshape = 21, 
             pointsize = 2, 
             fill.ind = mtDataFreq$X, 
             col.ind = "black", 
             palette = "jco", 
             addEllipses = TRUE,
             label = "var",
             col.var = "black",
             repel = TRUE,
             legend.title = "Ethnicity") +
  ggtitle("2D PCA-plot from 30 feature dataset") +
  theme(plot.title = element_text(hjust = 0.5))

