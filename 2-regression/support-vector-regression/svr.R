dataset <- read.csv('position-salaries.csv')
# omit 1st column which is redundant w/ 2nd
dataset <- dataset [2: 3]

### TRAIN MODELS
# install.packages('e1071')
library(e1071)
# svr module in R already include scaling
model <- svm(formula = Salary ~ ., data = dataset, type = 'eps-regression')
summary(model)

### VISUALIZE
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(model, dataset)),
            colour = 'blue') +
  labs(title = 'Position level vs. Salary', x = 'Position level', y = 'Salary')

### PREDICT
predict(model, data.frame(Level <- 6.5))
