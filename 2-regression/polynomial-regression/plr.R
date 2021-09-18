dataset <- read.csv('position-salaries.csv')
# omit 1st column which is redundant w/ 2nd
dataset <- dataset [2: 3]

### TRAIN MODELS
# univariate linear regression model
ulr_model <- lm(formula = Salary ~ ., data = dataset)
summary(ulr_model)
# polynomial linear regression model
# @raw TRUE for not orthogonal polynomial, recommend FALSE
plr_model <- lm(formula = Salary ~ poly(Level, 4, raw = FALSE), data = dataset) 
summary(plr_model)

### VISUALIZE
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(ulr_model, dataset)),
            colour = 'blue') +
  geom_line(aes(x = dataset$Level, y = predict(plr_model, dataset)), 
            colour = 'green') +
  labs(title = 'Position level vs. Salary', x = 'Position level', y = 'Salary')

### PREDICT
predict(ulr_model, data.frame(Level <- 6.5))
predict(plr_model, data.frame(Level <- 6.5))