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

# Optimize model using Backward Elimination
model = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
           data = dataset) 
print(coef(summary(model))[c(1:6), "Pr(>|t|)"])
summary(model)


model = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
           data = dataset) 
summary(model)

model = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
           data = dataset) 
summary(model)

model = lm(formula = Profit ~ R.D.Spend,
           data = dataset) 
summary(model)

# Automatic Backward Elimination
backwardElimination <- function(dataset, significance_level) {
  numOfVars <- length(dataset)
  print(numOfVars)
  
  for (i in c(1 : numOfVars)){
    model <- lm(formula = Profit ~ ., data = dataset)
    # FIX: pValues not include last var
    pValues <- coef(summary(model))[c(2 : (numOfVars + 0)), "Pr(>|t|)"]
    # print(pValues)
    maxPValue <- max(pValues)
    
    if (maxPValue > significance_level){
      varToEliminate <- which(pValues == maxPValue)
      dataset <- dataset[, -varToEliminate]
      numOfVars <- numOfVars - 1
    }
  }
  # return(summary(model))
}
# Usage:
SL = 0.05
dataset <- read.csv('50_Startups.csv')
# dataset <- dataset[, c(1,2,3,4,5)]
backwardElimination(dataset, SL)