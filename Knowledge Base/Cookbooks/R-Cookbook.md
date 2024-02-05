[ISLR v2 Resources](https://www.statlearning.com/resources-second-edition)

`R version 4.3.2 (2023-10-31 ucrt) -- "Eye Holes"`

# Basics

```R
print(paste("Hello,", "world!"))
# Ask for help
?funcname
# packages
install.packages("some_packages")
```

```R
# logical #issue
& | ! # elementwise
&& || # only examine the first element
```

```R
if (condition) {
 expr1
} else {
 expr2
}

for(var in seq) {
    expr
    break
}

while(condition) {
    expr
}
while(condition) {
    break # stop the while loop
```

```R
strsplit() #issue
```

## Loading Data

```R
## import data
data <- read.table(file = "./Resources/Datasets/Auto.data", header = TRUE, na.strings = "?", stringsAsFactors = TRUE)
# set stringsAsFactors to TRUE: treat variable containing strings as a quanlitative variable
# also using data <- na.omit(data)

data <. read.csv(file = "...") # read a csv file

## export data
write.table()
```

## Literals

```R
## vector
vec <- c(1, 2, 4, 3)
vec = c(1, 2, 4, 3)
length(x)

# name a vector
names(vector) <- vec_names

seq(0, 1, length=100)
seq(0, 10) # 0:10 note that this will include both the start and the end number

## matrix
mat <- matrix(data = vec, nrow = 2, ncol = 2, byrow = TRUE) 
# matrix(vec, 2, 2, byrow=TRUE)
# Note that by default byrow = FALSE
length(mat) # dim(mat)[1] * dim(mat)[2]
dim(mat)

# name a matrix
rownames(matrix) <- row_names_vec
colnames(matrix) <- col_names_vec
# alternatively, you can use `dimnames = list(row_names, col_names)`

# indexing the matrix
mat[1,1]
mat[1:2, ]
mat[1:2, 2]
mat[c(1,2), c(2,1)]
mat[-1, ] # ignore the first row
mat[-c(1,2), -c(2,2)] # ignorw the 1st,2nd row and the 2nd row

# matrix arithmetic
rowSums(matrix)
colSums(matrix)
matrix1 * matrix2 # elementwise
matrix1 %*% matrix2

## cached objects
ls() # check a list of all the objects: data & functions
rm() # delete objects
rm(list = ls()) # remove all objects

## combine matrices and vectors
big_matrix = cbind(mat1, mat2, ..., vec1, ...)
big_matrix = rbind(mat1, mat2, ..., vec2, ...)
```

### Factor

R use term factor to describe the vector whose values represent categories or enumerated types.

```R
vec <- c(1,3,5)
fac_vec <- factor(vec)
fac_vec <- as.factor(vec)

## factor with levels
fac_vec <- factor(vector, order = TRUE, levels = c("lev1", "lev2", ...))
# acsending
# alternatively levels(fac_vec) <- c("lev1", "lev2", ...)
# you can also use levels() to change the existing levels to another set of levels, e.g. levels(fac_vec) = new_levels

## Order factor
order(fac_vec)
fac_vec[order(fac_vec)]
```

### List

```R
my_list <- list(comp1, comp2, ...)
my_list <- list(name1 = comp1, name2 = comp2, ...)
# or equivalently names(my_list) <- name_list

# select components
my_list$name1
my_list[[1]]
```

## Arithmetic

```R
mat1 * mat2 # elementwise
mat1 %*% mat2 # matrix mulitplication
sqrt(vec_or_mat)
vec_or_mat^2

mean(vec_or_mat)
var(vec_or_mat)
sd(vec_or_mat) == sqrt(var(vec_or_mat)) # sd for standard deviation

cor(vec, vec + rnorm(length(vec), mean=1, sd=.2)) # correlation

# outer product
mat <- outer(vec1, vec2, function(x, y) cos(x) + sin(y))
dim(mat)
```

## Random Variables

```R
set.seed(1919)
vec <- rnorm(19, mean=1, sd=.2) # generate random normal variables
# by default rnorm() creates std normal random variables
```

## Graphics

[ggplot](https://r-charts.com/ggplot2/)

```R
# line: intercept a and slope b, lwd: line width
abline(a, b, lwd = 3, col = "red") 

## scatter
x <- rnorm(10)
y <- rnorm(10)
plot(x, y, xlab = "the x-axis label", ylab = "the y-axis label", main = "the title", col = "green", pch = "+")
# plot(y ~ x), pch option to create plotting symbols

## countour
z <- outer(x, y, function(x,y) cos(y) / (1 + x^2))
contour(x, y, z, nlevels=30, add=FALSE) 
# if add set TRUE, will do modifcation on the original figure

## heatmap
image(x, y, z) # the color depends on z

## 3d plot
persp(x, y, z, theta = 30, phi = 20)

## histogram
hist(vec, breaks = 15)

## output the R plot
pdf("Figure.pdf")
plot(x, y)
dev.off() # indicates that the creation is done

## plot a data frame's column
plot(data$property1, data$property2)
attach(data)
plot(property1, property2)
```

If the variable on x-axis is qualitative, `plot()` function will produce the boxplots.

```R
fac_vec <- factor(vec)
plot(fac_vec, vec2, varwidth = TRUE)
# set varwidth to TRUE to indicate the group size by the box width
```

In some cases you want to see the relationship of each two variables of the data frame. You can use `pairs` to achieve it.

```R
pairs(data)

# or select some properties
pairs(~ property1 + property2 + ..., data = data)
```

You can also use kind of a interactive mode. Clicking the point and you will see the values you offer. (❗Not working in VSCode)

```R
attach(data)
plot(property1, property2)
identify(property1, property2, property_to_be_query)

# then clicking on the plotted dot
```

## Genetic Functions

```R
# index of the max / min variable
which.max(object)
which.min(object)
# repetition
rep(x, times)
```

## Data Frame

```R
## create data frame (by column)
df <- data.frame(vec1, vec2, ...)

## exploring the data frame
View(df) # Open a new window to see the data frame
head(df) # show the first lines of the data frame
tail(df)
dim(df)
names(df) # check the variable names

str(df) # this will give a overview of each variable in the data frame
summary(df) # produce a summary for each variable in the data frame, e.g. min, 1st Qu, Median, Mean, 3st Qu, Max
# note that summary can also be used to vector, matrix

df[1, ]
df[ , 2] # or df$2thColName or df[ , "2thColName"]
df[1, 2]

```

### R Toy Dataset

```R
mtcars # Motor Trend Car Road Tests
```

### NaN

```R
# missing values omit
df <- na.omit(df) # remove the rows containing missing values

# missing values are indicated as NaN
df.isna()
df.isna().any() # check the column
df.isna().sum() # check the number of NaN in each column
df.isna().sum().plot(kind="bar")
# removing missing values
df.dropna()
# replacing missing values
df.fillna(0)
```

# Model

## Linear Regression

### Single-variable LM

```R
# y: response, x: predictor, data: data set
lm.fit <- lm(y ~ x, data)
# check coefficients
lm.fit
# check residuals, coefficients (estimated, std error, t value, p value), RSE, multiple R^2 & adjusted R^2 #issue , F-statistic and corresponding p-value 
summary(lm.fit)

# check predicted values
predict(lm.fit)
# for a few given value, give confidence inteval, prediction inteval
predict(lm.fit, data.frame(predictor = (c(1,2,3))), interval = "confidence")
predict(lm.fit, data.frame(predictor = (c(1,2,3))), interval = "prediction")

# check statistics you can get from linear regression
names(lm.fit)
# e.g. plot residual by index
plot(lm.fit$residuals)
# acquire coefficients
lm.fit$coefficients # or coef(lm.fit)

# confidence interval
confint(lm.fit)

# R^2
summary(lm.fit)$r.sq

# residuals and studentized residuals
lm.fit$residuals
rstudent(lm.fit)
# RSE
summary(lm.fit)$sigma

# leverages
plot(hatvalues(lm.fit))
# tell which one has the largest leverage
which.max(hatvlaues(lm.fit))

# plot the scatter and regression line
plot(x, y)
abline(lm.fit, lwd = 3) # abline for a,b line, a + bx
```

Diagonostic plots.

```R
par(mfrow=c(2,2))
plot(lm.fit) 
## four diagnostic plots
# residuals ~ fitted values
# standardized residuals ~ theoretical quantiles
# standardized residuals ~ fitted values
# standardized residuals ~ leverage
```

### Multi-variable LM

```R
lm.fit <- lm(y ~ x1 + x2 + ..., data)
# fit LM without some variables 
lm.fit1 <- update(lm.fit, ~ . -var_to_be_ignored)
# altenatively
lm.fit1 <- lm(y ~ . -var_to_be_ignored)

# VIF
library(car)
vif(lm.fit)
```

