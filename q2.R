library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]
set.seed(62433)
modelfit1<-train(diagnosis~., data=training, method="rf")
set.seed(62433)
modelfit2<-train(diagnosis~., data=training, method="gbm")
set.seed(62433)
modelfit3<-train(diagnosis~., data=training, method="lda")
confusionMatrix(testing$diagnosis, predict(modelfit1, testing))
confusionMatrix(testing$diagnosis, predict(modelfit2, testing))
confusionMatrix(testing$diagnosis, predict(modelfit3, testing))

predDF<-data.frame(predict(modelfit1, testing), predict(modelfit2, testing), predict(modelfit3, testing), diagnosis=testing$diagnosis)
combmod<-train(diagnosis~., method="rf", data=predDF)
confusionMatrix(predDF$diagnosis, predict(combmod, predDF))