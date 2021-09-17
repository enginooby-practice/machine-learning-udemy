dataset <- read.csv('Salary_Data.csv')

# Split dataset into training & test set
library(caTools)
set.seed(1)
split <- sample.split(dataset$Salary, SplitRatio = 2/3)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)

# Fit Linear Regression model to the Training set
model <- lm(formula = Salary ~ YearsExperience,
           data = training_set)

# Inspect the fitted model
summary(model)

# Predict the Test set results
y_predict <- predict(model, newdata = test_set)

library(ggplot2)
# Visualize Training set results
ggplot() +
  geom_point(aes(x <- training_set$YearsExperience, y <- training_set$Salary),
            colour = 'red') +
  geom_line(aes(x <- training_set$YearsExperience, y <- predict(model, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs. Experience (Training set)') +
  xlab('Experience (years)') +
  ylab('Salary (USD)')

# Visualize Test set results
ggplot() +
  geom_point(aes(x <- test_set$YearsExperience, y <- test_set$Salary),
             colour = 'red') +
  geom_line(aes(x <- training_set$YearsExperience, y <- predict(model, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs. Experience (Test set)') +
  xlab('Experience (years)') +
  ylab('Salary (USD)')


