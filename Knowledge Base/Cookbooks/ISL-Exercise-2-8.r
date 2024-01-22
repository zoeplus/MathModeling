college <- read.csv(file = "./Resources/Datasets/College.csv",
                    head = TRUE, stringsAsFactors = TRUE)
rownames(college) <- college[, 1]
college <- college[, -1] # eliminate the first column

summary(college)

pairs(college[, 1:10]) # note that you need to set stringsAsFactors = TRUE

attach(college)

plot(Outstate ~ Private,
     xlab = "Private College?",
     ylab = "Out of State Tuition")
# note that you have to set stringsAsFactors = TRUE
# to turn Private into a factor

# create a variable Elite
elite <- rep("No", nrow(college))
elite[Top10perc > 50] <- "Yes"
elite <- as.factor(elite)
college <- data.frame(college, elite)
summary(elite)

# plot the boxplot of Outstate versus Elite
plot(Outstate ~ elite,
     xlab = "Elite College?",
     ylab = "Out of State Tuition",
     col = "lightblue",
     varwidth = TRUE)


# plot the histogram by accending braks
par(mfrow = c(2, 2))
for (i in (1:4) * 4) {
  hist(Outstate,
       xlab = "Out of State Tuition",
       ylab = "Frequency",
       main = paste("Histogram of Out of State Tuition\n",
                    "Breaks = ", i, sep = ""),
       col = "lightblue",
       breaks = i)
}

# Continue exploring the data
