rm(list=ls())

library(e1071)
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

set.seed(325)
x<-subset(training, select=-CompressiveStrength)
y<-training$CompressiveStrength
modelfit<-svm(x, y)
pred<-predict(modelfit, subset(testing, select=-CompressiveStrength))
RMSE(pred, testing$CompressiveStrength)