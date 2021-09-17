dataset <- read.csv('Data.csv')

# Handle missing data
dataset$Age[is.na(dataset$Age)] <- mean(dataset$Age, na.rm = T)
dataset$Salary[is.na(dataset$Salary)] <- mean(dataset$Salary, na.rm = T)

# Encode categorical data (into dummy vars)
dataset$Country <- factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))
dataset$Purchased <- factor(dataset$Purchased,
                           levels = c('No', 'Yes'),
                           labels = c(0, 1))

#install.packages('caTools')
# Split dataset into training & test set
library(caTools)
set.seed(1)
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)

# Scale numeric features
training_set[, 2:3] <- scale(training_set[, 2:3])
test_set[, 2:3] <- scale(test_set[, 2:3])
