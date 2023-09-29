# May 26, 2022

# This script is for calculating Fst values and performing PCA;

getwd()
list.files()
# The following packages were installed;

#install.packages("apex", dependencies = TRUE)
#install.packages("mmod", dependencies = TRUE)

library("apex")
library("adegenet")
library("pegas")
library("mmod")
library("poppr")
library("hierfstat")

# creating multiDNA object;
mtGseq_bin <- read.multiFASTA("mtG_N2074.fasta")
dim(mtGseq_bin)
summary(mtGseq_bin)

# info on the samples;
getNumInd(mtGseq_bin)
getNumLoci(mtGseq_bin)
getNumSequences(mtGseq_bin)
# for writing seqID in a CSV file;
#mtG_id <- getSequenceNames(mtGseq_bin)

#write.csv(mtG_id, file = "mtG_N2073_seqID.csv", sep = "\t", col.names = "seqID" )

help(multidna2genind)

# creating genid object, this should not be used for mtG;
#mtG_genid_mlst <- multidna2genind(mtGseq_bin, mlst = TRUE)

# for checking the genotypes;
#mtG_genid_mlst_matrix <- mtG_genid_mlst@tab

#dim(mtG_genid_mlst_matrix)

#mtG_genid_mlst_matrix[100:107, 100:107]

# creating genid object with mlst = False;
mtG_genid <- multidna2genind(mtGseq_bin, mlst = FALSE)


# for checking genotypes;
mtG_genid_matrix <- mtG_genid@tab

dim(mtG_genid_matrix)

mtG_genid_matrix[1:7, 1:7]

# for assigning popID;
popID <- read.csv("mtG_N2074_seqID_popID.csv", header = TRUE, sep = ",")

strata(mtG_genid) <- popID
setPop(mtG_genid) <- ~popID

mtG_genid

popNames(mtG_genid)

basic.stats(mtG_genid, diploid = FALSE)

#for converting genid object into hierfstat dataframe;
mtG_hierstat_data <- genind2hierfstat(mtG_genid)

dim(mtG_hierstat_data)

mtG_hierstat_data[200:213,]

basic.stats(mtG_hierstat_data, diploid = FALSE)

# for writing the mtG hierstat data into a file;

#write.table(mtG_hierstat_data, file = "mtG_hierstat_data_N2074.csv", sep = '\t')



# for isolating a pop from other pops;

jeti <- mtG_genid[pop = "Kazak"]

sherpa <- mtG_genid[pop = "Sherpa"]

# get pop name;
popNames(jeti)
popNames(sherpa)

# get number of indi in the dataset;
nInd(jeti)
nInd(sherpa)

# get names of the indi;

indNames(jeti)

indNames(sherpa)
indNames(mtG_genid[pop = "Tibetan"])

  ## This block is for Fst through pairwise_Gst_Nei:
# calculation of pairwise_Gst_Nei;

mtG_genid_Fst_Nei <- pairwise_Gst_Nei(mtG_genid, linearized = FALSE)

help(mmod)


# Converting the distance matrix into a dataframe;
mtG_genid_Fst_Nei_df<-as.data.frame(as.matrix(mtG_genid_Fst_Nei))

print(dim(mtG_genid_Fst_Nei_df))

write.csv(mtG_genid_Fst_Nei_df, file = "mtG_N2074_Fst_Nei.csv")



# for calculating genetic distance;

mtG_dist_Dch <- genet.dist(mtG_hierstat_data, diploid=FALSE, method="Dch")

# Converting the distance matrix into a dataframe;
mtG_dist_Dch_df<-as.data.frame(as.matrix(mtG_dist_Dch))

# for writing the distance matrix into a csv file;
write.csv(mtG_dist_Dch_df, file = "mtG_N2074_dist_Dch.csv", sep = "\t")

dim(mtG_dist_Dch_df)
