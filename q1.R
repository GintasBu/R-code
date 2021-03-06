library(ElemStatLearn)
library(caret)
data(vowel.train)
data(vowel.test)
vowel.test$y<-as.factor(vowel.test$y)
vowel.train$y<-as.factor(vowel.train$y)
set.seed(33833)
modelfit1<-train(y~., data=vowel.train, method="rf")
modelfit2<-train(y~., data=vowel.train, method="gbm")
confusionMatrix(vowel.test$y, predict(modelfit1, vowel.test))
confusionMatrix(vowel.test$y, predict(modelfit2, vowel.test))

predDF<-data.frame(predict(modelfit1, vowel.test), predict(modelfit2, vowel.test), y=vowel.test$y)
combmod<-train(y~., method="gbm", data=predDF)
confusionMatrix(predDF$y, predict(combmod, predDF))