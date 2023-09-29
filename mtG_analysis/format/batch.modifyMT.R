mtDNA.data <- list.files(pattern = "*.neo.mt.txt")

for (i in 1:length(mtDNA.data)) {
  modifyMt.v3.0(mtDNA.data[i])
  }
