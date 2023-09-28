rm(list = ls()) #initialization, i.e. clear the memory of the computer (?);


###############################Vector###############################
#############All the elements must be of the same type!#############
######################Like a column of a table######################

#var: choose meaningful names
#type: very important!!!
#vector: same type, with index, like a column

v <- c(2.71, 5, 3.14) #case sensitive! num vectors
                      #<-: Alt + - in RStudio
                      #<-: option + - in on Mac
length(v)
class(v)
str(v)

v1 <- c(2.71, 5, "3.14") # even though it contains a string, no error message;
                        # adding a string, makes all elements of the vector to
                        # become character type;

class(v1)
str(v1)

v #also watch Global Environment on the right
  #always pay attention to its type
str(v)
v[3] #index starts from 1, instead of 0, unlike most programming languages


words <- c("tree", "ant", "chainsaw", "stats") #char vectors
length(words)
words
str(words)
words[1]


############################Vector Type#############################

#numeric = decimal
3.1415927e7; 3.1415927E7 # = 3.1415927*10^7 (scientific notation, check https://en.wikipedia.org/wiki/Scientific_notation)
3.14e-2; 3.14E-2; 3.14*10^(-2)


#character/string (' = ")
quotation <- c("\\stat\\", "", "\"love\"")
quotation[1] # \stat\
quotation[2] # empty string
quotation[3] # "love"


oak <- 70
text <- paste(sep = "",   "Oak weighs", oak, "lbs/ft^3.")
text

text <- paste("Oak weighs", oak, "lbs/ft^3.") #sep = " " by default
text

text <- paste(sep = "\n", "Oak weighs", oak, "lbs/ft^3.")
text

words <- c("I", "like", "apple")

sentence <- paste(words, collapse = "")
sentence

names(words) <- c("subject", "verb", "object")

needed <- c(3,1,2, 1, 2, 3)

words[needed]


#the most important print command: cat()
oak <- 7.4e-3
cat(sep = "",   "\"Oak\" weighs", oak, "lbs/ft^3.")
cat(sep = "\n", "\"Oak\" weighs", oak, "lbs/ft^3.") #\n = new line
cat(sep = "\t", "\"Oak\" weighs", oak, "lbs/ft^3.") #\t = TAB
cat(sep = "\\", "\"Oak\" weighs", oak, "lbs/ft^3.") #You can try all the others listed in our handout on your own!

cat("I ");   cat("love ");   cat("R.\n")
cat("I \n"); cat("love \n"); cat("R.\n")

text <- cat(sep="\n", "Oak weighs", oak, "lbs/ft^3.")
text #NULL!


#logical: TRUE (T for short, or = 1) and FALSE (F, or = 0)
v <- c(2.71, 5, 3.14)
result <- (v > 3); result
v > 3
sum(v > 3) #counting, cf. sum(result)
sum(v)

words <- c("tree", "ant", "chainsaw", "stats")
words == "ant" # == for comparison, =/<- for assignment
sum(words == "ant")


#set up a vector
vector(mode = "logical", length = 5) #mode define type
w <- vector(mode = "logical",   length = 5);   #default = FALSE
w <- vector(mode = "numeric",   length = 5); w #default = 0
w <- vector(mode = "character", length = 5); w #default = ""


#conversion
#Don't change the type too frequently. You will confuse yourself!
v <- c(2.71, 5, 3.14)
v > 3
as.numeric(v > 3) #logical => numeric

w = c("34", "12", "45")
sum(w) # wrong!
w.numbers = as.numeric(w); w.numbers #character => numeric
sum(w.numbers); sum(as.numeric(w))


#three other types: integer, complex, raw. Please use ? to see details.


##########################Names Attribute############################

v <- c(2.71, 5, 3.14)
str(v)
names(v) <- c("e", "five", "pi")
v
v["e"]
v[2] <- 4; names(v)[2] <- "four"; v
names(v) <- NULL; v

y <- c(burger = 2.50, fries = 1.50); y


##########################Vector Functions###########################

x <- c(11, 11, 12, 16)
sum(x)
max(x)
mean(x); sum(x) / length(x) #recycle the shorter one, length(x)
median(x)
sd(x)
var(x); sd(x)^2


########################Element-Wise Operators#######################

#arithmetic: +, -, *, /, ^, %/%, %%, etc
mean(x)
x - mean(x) #signed deviations, sum(x-mean(x)) = ?
(x - mean(x))^2 #squared deviations
sum((x - mean(x))^2 / (length(x) - 1)); var(x) #sample variance by using a divisor n-1
sqrt(sum((x - mean(x))^2 / (length(x) - 1))); sd(x) #sample sd

#for finding SD:

sd = sqrt(sum((x-mean(x))^2)/(length(x) - 1))
sd

#How to boil down the complicated line into the simple lines as shown above is very useful for debugging!


#relation: >, >=, <, <=, == (equal to), != (not equal to)
#logic operator: ! (not), & (and), | (or)
v <- c(2.71, 5, 3.14)
v > 3
!(v > 3)
v <= 3.14
(v > 3) & (v <= 3.14) 
(v > 3) | (v <= 3.14) #ALWAYS use some paratheses if you are confused about the order of all these opeartors
any(v > 3); all(v > 3) #any = or, all = and

#assignment: <- or = (not ==!)
#<- is NOT equivalent to < -



#################################Sequence#############################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#: (colon)
11:14
x <- 11:14; y <- c(11, 12, 13, 14); x; y
5*(1:10); 5*1:10 #same output. Which is better?
(5*1):10 #adding paratheses is really necessary!

2*(11:14)

fx != 11

#seq (a powerful function)
seq(from = 10, to = 15, by = 2); seq(10, 15, 2)
seq(10, 15, length.out = 5)
seq(10, 15, length.out = 30) #good for drawing a graph
?seq

# more examples:
seq(1, 100, length.out = 10)


#############################Matching (%in%)##########################

1:8 %in% c(2, 4, 6)


#################################Indexing#############################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!

x <- 11:20; x


#using a scalar
x[4]


#using a vector
v <- c( 1,  2,  10); x[v] #1st, 2nd, 10th
v <- c( 10, 9,  8, 7, 6, 3, 4, 3); x[v] #any order, even with repetition
v <- c(-1, -2, -10); x[v] #negative = excluding

#Only for advanced students!
#x[0] #What does it mean?
#x[20] #What does it mean?
#x[1.9]; x[1.4] #Why?

v <- seq(-1, -10, -1); v
w <- x[v]; w #integer(0) = zero integer


#using which [that gives the values, which meet the condition]
x != 14 #criterion for which element will be chosen
w <- which(x != 14); w
x[w]


#using a logical filter, even simpler
x != 14
x[x != 14] #like a filter

x[x < 14] #like indices = which(x < 14); x[indices]

x %% 2
(x %% 2) == 0
x[(x %% 2) == 0] #even entries


#batch assignment with recycling (only for advanced students!)
x[1:3] <- 101; x #duplicate assignment
x[1:3] <- 101:103; x
x[1:9] <- 101:103; x #cyclic assignment
x[1:3] <- 101:105 #length doesn't match well, but assignments are done!
x[1:8] <- 101:103; x #length doesn't match well, but cyclic assignments are done!
x[(x %% 2) == 0] <- 0; x #all the even term is set to be zero


#using names
x <- 1:3
names(x) <- c("one", "two", "Fred"); x
v <- c("Fred", "one")
x[v]


#######################R Script (save as test.R)###################

rm(list = ls()) #initialization

radius <- 3 # assignment

#computation
area <- pi * radius^2
circumference <- 2 * pi * radius

#output
cat(sep = "", "area = ", area, ", circumference = ", circumference, "\n")


##############################HW1###################################
#Watch the video and read the requirement carefully.
#Then, fill in your name & email (blank 1 & 2) and code (blank 3 & 4).


############################Summary#################################

#Understand var, type, vector, index

#The best way to learn is always trial and error

#Practice indexing of vector on your own

#Debugging is always challenging. Try the following basic tips:
#1. Boil down a complicated line into several simple lines.
#2. Getting more output on Console or Global Environment is always good for debugging.
#3. Keep your code neat and blockwise.
#4. Always be case-sensitive and type-sensitive.
#5. Use parentheses if you are not sure about the precedence of the operators.
#6. For the vector, you need to distinguish its indices and values.
