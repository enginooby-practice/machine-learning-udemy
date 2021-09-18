dataset <- read.csv('50_Startups.csv')

# Split dataset into training & test set
library(caTools)
set.seed(1)
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)

# Fit Linear Regression model to the Training set
model = lm(formula = Profit ~ ., # . indicate all features
           data = training_set) 

# Inspect the fitted model
summary(model)

# Predict the Test set results
y_predict <- predict(model, newdata = test_set)
