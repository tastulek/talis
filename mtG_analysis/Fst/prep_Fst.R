# Mar 31, 2022

# This script is for calculating Fst values and performing PCA on genetic
# distance matrix;

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

# creating multiDNA object;
mtGseq_bin <- read.multiFASTA("mtG_N2073.fasta")
dim(mtGseq_bin)
summary(mtGseq_bin)

# info on the samples;
getNumInd(mtGseq_bin)

# for writing seqID in a CSV file;
mtG_id <- getSequenceNames(mtGseq_bin)

write.csv(mtG_id, file = "mtG_N2073_seqID.csv", sep = "\t", col.names = "seqID" )



# creating genid object;
mtG_genid <- multidna2genind(mtGseq_bin, mlst = TRUE)


# for assigning popID;
popID <- read.csv("mtG_N2073_seqID_popID.csv", header = TRUE, sep = ",")

strata(mtG_genid) <- popID
setPop(mtG_genid) <- ~popID

mtG_genid

popNames(mtG_genid)

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

# calculation of Fst;

mtG_genid_Fst_Nei <- pairwise_Gst_Nei(mtG_genid, linearized = TRUE)

# Converting the distance matrix into a dataframe;
mtG_genid_Fst_Nei_df<-as.data.frame(as.matrix(mtG_genid_Fst_Nei))


dim(mtG_genid_Fst_Nei_df)

write.csv(mtG_genid_Fst_Nei_df, file = "mtG_N2073_Fst_Nei_linear.csv", sep = "\t")

