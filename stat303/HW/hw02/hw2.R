# You should replace all occurrences of "..." with your
# code. If you'd like to replace a single "..." with more
# than one line of code (using your own variables), you may
# certainly do that. Please don't remove all my comments, as they
# help orient us when we're reading your code.
#
# My solution to this homework uses information from the first two
# handouts and the Vector portion of the third handout.
#
# We'll grade your homework by running this ".R" file via
#   source("hw2.R")
# (in a directory containing the data files) and reading your code.

# Name: Ayken Askapuli
# Email: askapuli@wisc.edu

rm(list = ls()) # Remove all objects defined in workspace.

# Download WI_donations and NY_donations from the class website. (Do
# this outside of R. They are donations from Wisconsin and New York to
# the 2012 presidential candidates. I got them from files at
# www.fec.gov/disclosurep/PDownload.do, a Federal Election Commission
# website.)
#
# Read these two files into two vectors, one for each state.

# ...

# Find the sum of donations from WI and the sum of donations from NY.

# for retrieving the data:
wi_data <- scan("WI_donations.txt", what = numeric())
ny_data <- scan("NY_donations.txt", what = numeric())

WI.sum = sum(wi_data) # ... set this variable correctly
NY.sum = sum(ny_data) # ... set this variable correctly
cat(sep="", "WI sum=", WI.sum, "\n")
cat(sep="", "NY sum=", NY.sum, "\n")

# Find the sum of small donations from each state. I've set small=100
# (below). Let's say "small donation" are those such that
#   -100 <= donation <= 100.
# (Note that there are negative donations, which are refunds.)

small = 100

# for WI:
small_wi_idx <- which(- small <= wi_data & wi_data <= small)
small_wi_data <- wi_data[small_wi_idx]

# for NY:
small_ny_idx <- which(- small <= ny_data & ny_data <= small)
small_ny_data <- ny_data[small_ny_idx]


WI.sum.small = sum(small_wi_data) # ... set this variable correctly
NY.sum.small = sum(small_ny_data) # ... set this variable correctly
cat(sep="", "WI.sum.small=", WI.sum.small, "\n")
cat(sep="", "NY.sum.small=", NY.sum.small, "\n")

# Find the sum of big donations from each state. Let's say "big
# donations" are those such that
#   donation < -100 or donation > 100.

# for WI:
big_wi_idx <- which(abs(wi_data) > small)
big_wi_data <- wi_data[big_wi_idx]
#big_wi_data[1:10]

# for NY:
big_ny_idx <- which(abs(ny_data) > small)
big_ny_data <- ny_data[big_ny_idx]
#big_ny_data[1:10]

WI.sum.big = sum(big_wi_data) # ... set this variable correctly
NY.sum.big = sum(big_ny_data) # ... set this variable correctly
cat(sep="", "WI.sum.big=", WI.sum.big, "\n")
cat(sep="", "NY.sum.big=", NY.sum.big, "\n")

# Find the ratio of the sum of small donations to the sum of all
# donations from each state.
WI.small.ratio = WI.sum.small / WI.sum # ... set this variable correctly
NY.small.ratio = NY.sum.small / NY.sum # ... set this variable correctly
cat(sep="", "WI.small.ratio=", WI.small.ratio, "\n")
cat(sep="", "NY.small.ratio=", NY.small.ratio, "\n")

# Find the mean positive donation from each state. (Do not include
# zero or negative donations.)

# for WI:
wi_positive <- wi_data[wi_data > 0]

# for NY:
ny_positive <- ny_data[ny_data > 0]

WI.mean.pos = mean(wi_positive) # ... set this variable correctly
NY.mean.pos = mean(ny_positive) # ... set this variable correctly
cat(sep="", "WI.mean.pos=", WI.mean.pos, "\n")
cat(sep="", "NY.mean.pos=", NY.mean.pos, "\n")

# Find the median positive donation from each state. (Do not include
# zero or negative donations.)
WI.median.pos = median(wi_positive) # ... set this variable correctly
NY.median.pos = median(ny_positive) # ... set this variable correctly
cat(sep="", "WI.median.pos=", WI.median.pos, "\n")
cat(sep="", "NY.median.pos=", NY.median.pos, "\n")

# Find the largest and second-largest positive donation from each
# state. Write code, including a cat() statement or two, to produce
# formatted output exactly like this (except that the numbers should
# be correct, not 0):
#

WI.largest= sort(wi_positive, decreasing = TRUE)[1]
WI.second.largest= sort(wi_positive, decreasing = TRUE)[2]


NY.largest= sort(ny_positive, decreasing = TRUE)[1]
NY.second.largest= sort(ny_positive, decreasing = TRUE)[2]

cat("WI.largest = ", WI.largest, sep = "", "\n")
cat("WI.second.largest = ", WI.second.largest, sep = "", "\n")
cat("NY.largest = ", NY.largest, sep = "", "\n")
cat("NY.second.largest = ", NY.second.largest, sep = "", "\n")


# Note that your code should work on the current data set, and also on
# a new data set. For example, if I ask for a sum, don't use "17",
# even if the sum is 17, because 17 will probably be wrong for a new
# data set. Instead, use sum(...), since this second solution will be
# correct even for a new data set.
#
# I recommend checking that your code works on the files WI_tiny and
# NY_tiny, which are fake data files for which you can check your
# computations by hand. Get your code working on them, and then switch
# to the real data files specified above. Your submitted code should
# use the real files, "WI_donations" and "NY_donations".
