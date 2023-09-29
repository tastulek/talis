# May 28, 2022
# This R scrip is for making a heat map of mtDNA Hg freq data;

#install.packages("reshape")

library(ggplot2)
library(reshape)

list.files()

# retrieving the mtDNA freq data;
mt_freq <- read.csv("Jetisuu_mtDNA_HgFreq_ReadyForPCA_v5.1_May27_22.csv", sep = ',', header = TRUE)

dim(mt_freq)

mt_freq[1:3, 1:7]

rownames(mt_freq)

# for changing the column name of the first column, from "X.1" to "popID";
colnames(mt_freq)[1] <- "popID"


# converting the dataframe into a format which is acceptable for heat map;
# using melt() function from the reshape package;

freq_df <- melt(mt_freq, id.vars = "popID")

dim(freq_df)

freq_df[1:7,]

colnames(freq_df) <- c("Population", "Haplogroup", "Frequency")

freq_df[1:3, 1:3]

# heat map in ggplot2

ggplot(freq_df, aes(x = Population, y = Haplogroup , fill = Frequency)) +
  # setting tile and grid color as black;
  geom_tile(color = "black") + 
  #for changing tile color
  scale_fill_gradient(low = "white", high = "cyan4") +
  # for fixing tile size to be squre
  coord_fixed() +
  #for editing the theme
  theme(axis.text.x = element_text(angle = 60, vjust = 1, 
                                   size = 8, hjust = 1)) +
                            
  #theme(axis.ticks = element_blank(),
         #legend.justification = c(1, 0),
         #legend.position = c(0.6, 0.7),
         #legend.direction = "horizontal") +
  #for chaning the legend bar size and position
  guides(fill = guide_colourbar(barwidth = 1,
                                barheight = 9, 
                                title.position = "top", 
                                title.hjust = 0.5))




