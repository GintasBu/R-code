library(lubridate) # For year() function below
rm(list=ls())
dat = read.csv("gaData.csv")

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

fitmodel<-bats(tstrain)
pred<-forecast(fitmodel,235)
i2<-which(ts(testing$visitsTumblr)<pred$upper[,2] & ts(testing$visitsTumblr)>pred$lower[,2] )

i2/235