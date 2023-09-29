source('~/Downloads/GenomeTools/DataAnalyses19/
       Geno_2.0_Neo_MT19/extractMt.v7.0.R')

neo.fmt.data <- list.files(pattern = '[0-9].neo.ftd.txt')

for (i in 1:length(neo.fmt.data)) {
  extractMt(neo.fmt.data[i])
}
