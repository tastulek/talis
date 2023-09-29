source('~/Downloads/GenomeTools/DataAnalyses19/
       Geno_2.0_Neo_yChr19/extract.y.v1.0.R')

neo.ftd.txt <- list.files(pattern = '[0-9].neo.ftd.txt')

for (i in 1:length(neo.ftd.txt)) {
  extract.y(neo.ftd.txt[i])
}

