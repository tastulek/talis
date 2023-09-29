extractMt <- function(genodata, datatype='txtfile')
{
  if (datatype == 'txtfile') {
    #To retrieve the formatted Geno 2.0 data file:
    X <- read.table(genodata,skip=0)
   
    #Extract the mtDNA portion of the Geno 2.0 data:
    mtDNA <- subset(X, V2 == 'MT') 
    
    #To change double letter genotypes into single letter genotypes:
    splitGeno <- strsplit((as.character(mtDNA$V4)), split = '')
    splitMt <- do.call(rbind, splitGeno)
    Mt <- data.frame(mtDNA, splitMt)
    Mt2 <- Mt[,c(1,2,3,5)]
  
    #To update column names:
    colnames(Mt2) <- c('rsID', 'Chr', 'Position', 'Genotype')
    
    #To remove '.txt' extention from the file name:
    notxtgeno <- gsub('.txt', '', genodata)
  }
  
  #To change the genotype of an mtDNA marker, if it is called 
  #from the Reverse Strand, e.g. [2SNP64RC_T  MT   64   G] 
  #should be converted to [2SNP64RC_T  MT   64   C].
  #To make an index of the mtDNA markers which are called from
  #the Reverse Strand:
  index <- grep(pattern = '[0-9]R', Mt2$rsID, value = TRUE)
  
  #To create row names from the first column, i.e. rsID:
  row.names(Mt2) <- Mt2$rsID

  #To generate a dataframe for the Reverse Strand calls:
  mtDNA.R <- Mt2[index, ]
  
  #Try to use loops and idices, and replace nucleotides with 
  #corresponding nucleotides:
  all.mtSNPs.R <- length(mtDNA.R$Genotype)
  count.all.mtSNPs <- numeric(all.mtSNPs.R)
  snp <- seq_along(mtDNA.R$Genotype)
  
  for (i in seq_along(mtDNA.R$Genotype)) {
    count.all.mtSNPs[i] <- switch(as.character(mtDNA.R$Genotype[i]), 
                               A = 'T', T = 'A', 
                               C = 'G', G = 'C', '-')
  }
  
  #To incorporate the changed SNPs into the dataframe:
  mtDNA.R[4] <- count.all.mtSNPs
  mtDNA.R.ed <- mtDNA.R[, c(1,2,3,4)]
  
  #To select mtDNA rsIDs with genotype calls from the Forward Strand:
  mtDNA.F.rsID <- setdiff(rownames(Mt2), rownames(mtDNA.R.ed))
  mtDNA.F <- Mt2[mtDNA.F.rsID, ]
  mtDNA.F.R.ed <- rbind(mtDNA.F, mtDNA.R.ed)
  
  #To create a mtDNA genotype file with rows ordered by the position
  #of the SNPs (i.e. the column 3).
  write.table(mtDNA.F.R.ed[order(mtDNA.F.R.ed[,3]),], file=sprintf('%s.neo.mt.txt', 
                                       substr(notxtgeno, 
                                              start = 1, stop = 5)),
              quote=F,sep = '\t', row.names=FALSE,col.names=TRUE)
}
