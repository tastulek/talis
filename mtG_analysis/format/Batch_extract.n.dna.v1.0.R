source('~/Downloads/GenomeTools/DataAnalyses19/
       Geno_2.0_Neo_WG19/extract.n.dna.v1.0.R')

neo.ftd.txt <- list.files(pattern = '[0-9].neo.ftd.txt')

for (i in 1:length(neo.ftd.txt)) {
  extract.n.dna(neo.ftd.txt[i])
}

