rm(list = ls()) #initialization

########################### Class Intro ##############################
#1. Online Syllabus: http://www.stat.wisc.edu/~byang/327-4
#2. Quiz/HW/Group Practice Online System: http://www.stat.wisc.edu/~byang/327-4/login
#3. Piazza: forum, https://piazza.com/class/jllolzdl2fw384
#4. Canvas on Learn@UW: Check your grades and get my own supplementary codes


############################# R Intro ################################
#install R: http://www.stat.wisc.edu/~byang/327-4/R_install.txt


########################## RStudio Intro #############################
#install RStudio: http://www.stat.wisc.edu/~byang/327-4/RStudio_install.txt
#save .R file


#############################Arithmetic#############################

8 + 11
8 - 3
8 * 3; 8 / 3; 8 ^ 3
8 ^ (1/3)
8 / 3; 8 %/% 3 #cf. 8 / (-3); 8 %/% (-3) #quotient
8 %% 3 #cf. 8 %% (-3) #remainder


########################Calculator functions########################

exp(2) #cf. 2.718281828459 ^ 2 or e = 2.718281828459; e^2


log(7.389056)

?log #!IMPORTANT TRICK: using ?
     #like help("log") or help('log')

log(9, base = 3); log(9) #different output because of different bases!
log(9, 3) #too brief!
log(x = 9, base = 3)


e <- exp(1); log(e^2) #cf. e = 2.718281828459; log(e^2)
e; print(e) #same output


sin(pi/2); cos(pi/2); tan(pi/2) #using radian, not degree; output: too small/large
pi


sqrt(4); sqrt(-4); 4/0 #NaN, Inf? Undefined values
?NaN
?Inf


########################Other easy functions########################

abs(4); abs (-4); abs(0)


floor(2.5); floor(-2.5)
8 / 3; 8 %/% 3 
8 / (-3); 8 %/% (-3)
ceiling(2.5); ceiling(-2.5)


round(8000/3, 5) 
round(8000/3, 0); round(8000/3, -2)

#Only for advanced students!
#round(-1.5); round(1.5); 
#round(-0.5); round(0.5) #Weird!
                         #Rounding with 5 is a little tricky! Why? See ?round for more details


signif(8000/3, 2)
signif(8000/3, 5)


######################Statistics distributions######################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Check http://onlinestatbook.com/2/introduction/distributions.html

?dnorm 
#Pay attention to the first letter:   
#d - density (pdf)
#p - probability (cdf) (which side?)
#q - quartile (critical value, or inverse of cdf) (which side?)
#r - random generating

dnorm(0); dnorm(0, 0, 1) #pdf; see details at http://onlinestatbook.com/2/calculators/normal_dist.html
pnorm(q = -1, 1) #cdf
qnorm(0.5, 10, 2) #z-critical value
rnorm(20, 0, 0.1)
rnorm(20, 0, 0.1) #different random number every time!


?distribution #find all the distribution commands
?dt
dt(0, 1000) #cf. dnorm(0)
pt(0, 10)

q_t <- qt(0.025, 98, lower.tail = FALSE)
str(q_t)

##########################Miscellaneous#############################

?cot
??cot
??cotangent #no such function => cot(pi/2) = 1 / tan(pi/2)
??hypergeometric #like help.search("hypergeometric") or help.search('hypergeometric')

x = -1; y < -3 # <- means assignment, like =
x
y

ls()

rm(x)
ls()
x

rm(list = ls())
ls()
y


#Don't use the link below directly! Change the following directory accordingly
setwd("C:/Users/bo/Dropbox/STAT327/327_4/code") #like setwd('C:/Users/bo/Dropbox/STAT327/327_4/code')
getwd()

setwd("..") #like setwd('..')
getwd(); list.files() #list all files in your working directory

setwd("code") #like setwd('code')
getwd(); list.files()


#!IMPORTANT: Always set up your working directory at first, then there is no hassle to find your files.

#You can use Menu: Session > Set Working Directory to do the same job as setwd()


#Try to generate a .R file in the working directory, then use it below
source("2Vector.R") #like source('2vector.R')

demo(graphics)
demo(plotmath)

q() #like quit()

<- 


############################Shortcuts###############################

#up/down arrow         : previous/next command (on console)
#ESC                   : interrupt current command
#Ctrl + Enter (PC)     : Run the script line by line or from the selected part (very important!)
#F1                    : Get help for the selected part (very important!)
#Alt + - (PC)          : <- (assignment)
#Option + -   (Mac)    : <-
#Ctrl + Alt + c        : comment/decomment all the selected lines
#Ctrl + Shift + h (PC) : set up the working directory

#for more shortcuts:
'
https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts-in-the-RStudio-IDE

'
############################Summary#################################

#Preview before the class is very important!

#R is interpreted line by line, unlike C++.

#Set up the working dir and save .R and data files in the correct dir.

#Function(): repeated code, call/invoke it with parameters.

#How to find the help:
#1. use ? or ?? in R
#2. Google R subject or error message
#3. Visit stackoverflow: https://stackoverflow.com/ to find the answer
#4. Read the comments in my R script, just like this line
#5. Use Piazza

#Understanding statistical distribution is also the key in this course.