dataset <- read.csv('Data.csv')

# Handle missing data
dataset$Age[is.na(dataset$Age)] <- mean(dataset$Age, na.rm = T)
dataset$Salary[is.na(dataset$Salary)] <- mean(dataset$Salary, na.rm = T)

# Encode categorical data (into dummy vars) 
# (may be unnecessary since R treats they as factors by default?)
dataset$Country <- factor(dataset$Country,
                        levels = unique(dataset$Country),
                        labels = c(1:length(unique(dataset$Country))))
dataset$Purchased <- factor(dataset$Purchased,
                          levels = unique(dataset$Purchased),
                          labels = c(1:length(unique(dataset$Purchased))))

#install.packages('caTools')
# Split dataset into training & test set
library(caTools)
set.seed(1)
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)3

# Scale numeric features
training_set[, 2:3] <- scale(training_set[, 2:3])
test_set[, 2:3] <- scale(test_set[, 2:3])
