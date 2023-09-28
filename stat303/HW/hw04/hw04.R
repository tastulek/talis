# Oct 4, 2022

col_0102[1:3,]

str(col_01_02)

splitted <- strsplit((col_01_02[1]), split = " ")

splitted

?strsplit
df <- data.frame(rbind(col_01_02))
dim(df)
bf

?rbind
# Part 3

rm(list = ls())


n = 100
N = 100
my_x <- rnorm(n)
my_x[1:7]
x = rnorm(n)
var_list = replicate(N, expr = {x = rnorm(n); mu = mean(x); 
var = 1/n * sum((x - mu)^2)})

length(var_list)

str(var_list)

#my_error <- replicate(N, expr = sd(rnorm(n, sd = 4)/sqrt(n)))
#my_error <- replicate(N, expr = sd(rnorm(n, sd = 4)))
#length(my_error)
#my_error[1:7]
#exp01 = expr = sd(rnorm(n, sd = 4))
#length(exp01)

b0 = 2
b1 = 3

my_y = b0 + b1 * x + var_list
my_y_no_error = b0 + b1 * x

#plot(x, my_y)

#lines(x, my_y_no_error, col = "red")

# For checking the output;
#sort(my_error, decreasing = T)[1:7]
#length(my_error)

plot(x, my_y, xlab = expression(x[i]), ylab = expression(y[i]), col = "aquamarine4")

#dev.off() #for removing all plots;

lm_esti <-  lm(my_y ~ x)

summary(lm_esti)

lm_y_intercept <- lm_esti$coefficients[1]
lm_slope <- lm_esti$coefficients[2]

abline(a = lm_y_intercept, b = lm_slope, lty = "solid", col = "black")

lines(x, y = 2 + 3*x, lty = "dashed", col = "red" )


summary(lm_esti)

y_hat <- lm_esti$fitted.values

e_i <- my_y - y_hat

s <- sqrt(sum((e_i)^2)/(n-2))

x_i_diff <- (x - mean(x))^2

s_y_hat <- s * sqrt((1/n) + (x_i_diff / sum(x_i_diff)))
length(s_y_hat)
s_y_hat[1:7]

upper_limit <- y_hat + (s_y_hat * 50)
sorted_upper_limit <- sort(upper_limit)

lower_limit <- y_hat - (s_y_hat * 50)
sorted_lower_limit <- sort(lower_limit)

dif <- upper_limit - lower_limit
dif[1:7]

lines(x, lower_limit, lty = "dotted", col = "steelblue")
lines(x, upper_limit, lty = "dotted", col = "steelblue")


legend(x = "topleft", legend = c("Best Fit Line", "y=2+3x", "Confidence Bands"), 
       col = c("black", "red", "steelblue"), lty = c("solid", "dashed", "dotted"))

