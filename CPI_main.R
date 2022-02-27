library(readxl)
library(quantmod)
library(Metrics)
library(fBasics)
library(forecast)
library(tseries)
library(fGarch)
library(moments)
library(TSstudio)
CPI_U1 <- read_excel("~/Documents/CPI_U1.xlsx",
                     range = "A1:B131")
CPI_U1 <- read_excel("~/Documents/CPI_U1.xlsx",
                     range = "A1:B131")
View(CPI_U1)
CPIdata <-CPI_U1$`CPI`
summary(CPIdata)
length(CPIdata)
inds <- seq(as.Date("2011-01-01"), as.Date("2021-09-01"), by = "month")
CPIseries<-ts(CPIdata,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot.ts(CPIseries,main="CPI over time", ylab="CPI value", col="blue")

kpss.test(CPIdata)
adf.test(CPIdata)

logCPI<-log(CPIdata)
logCPIseries<-ts(logCPI,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot.ts(logCPIseries,main="CPI over time(logged)", ylab="Logged CPI value", col="blue")


diffCPI<-diff(logCPI)
diffCPIseries<-ts(diffCPI,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot.ts(diffCPIseries,main="CPI over time(differenced and logged)", ylab="Differenced and Logged CPI value", col="blue")


kpss.test(diffCPI)
adf.test(diffCPI)

acf(diffCPI,main = "ACF")
pacf(diffCPI,main = "PACF")

CPIcomponents <- decompose(CPIseries)
plot(CPIcomponents)

season<-CPIcomponents$seasonal
plot(season)

trend<-CPIcomponents$trend
plot(trend)

cycle<-CPIcomponents$random
plot(cycle)

Nosea<-auto.arima(CPIdata,seasonal=F)
checkresiduals(Nosea)
summary(Nosea)

Tsea<-auto.arima(CPIdata,seasonal=T)
checkresiduals(Tsea,main = "Season")
summary(Tsea)

model1<-Arima(ts(CPIdata[1:130]),c(2,1,2))
model1S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(2,1,2) fit",col="blue")
lines(model1S,col="red")

model2<-Arima(ts(CPIdata[1:130]),c(2,1,11))
model2S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(2,1,11) fit",col="blue")
lines(model2S,col="red")


model3<-Arima(ts(CPIdata[1:130]),c(2,1,12))
model3S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(2,1,12) fit",col="blue")
lines(model3S,col="red")



model4<-Arima(ts(CPIdata[1:130]),c(2,1,0))
model4S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(2,1,0) fit",col="blue")
lines(model4S,col="red")


model5<-Arima(ts(CPIdata[1:130]),c(2,1,1))
model5S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(2,1,1) fit",col="blue")
lines(model5S,col="red")


model6<-Arima(ts(CPIdata[1:130]),c(11,1,11))
model6S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(11,1,11) fit",col="blue")
lines(model6S,col="red")

model7<-Arima(ts(CPIdata[1:130]),c(11,1,12))
model7S<-ts(model1$fitted,start=c(2011, as.numeric(format(inds[1], "%j"))),frequency=12)
plot(CPIseries,main="ARIMA(11,1,12) fit",col="blue")
lines(model7S,col="red")





AIC(model1)
BIC(model1)
AIC(model2)
BIC(model2)
AIC(model3)
BIC(model3)
AIC(model4)
BIC(model4)
AIC(model5)
BIC(model5)
AIC(model6)
BIC(model6)
AIC(model7)
BIC(model7)

summary(model1)
summary(model2)
summary(model3)
summary(model4)
summary(model5)
summary(model6)
summary(model7)

CPIpredict <- predict(Arima(CPIdata[87:127], c(11,1,12)),n.ahead=10)
CPIforecast <- CPIpredict$pred
CPIpredictlower <- NULL
CPIpredictupper <- NULL
for (i in seq_along(CPIforecast)) {
 CPIpredictlower[40+i] <- CPIforecast[i]-(CPIpredict$se[i]*1.96)
 CPIpredictupper[40+i] <- CPIforecast[i]+(CPIpredict$se[i]*1.96)
}
fcst <- NULL
for (j in seq_along(CPIforecast)) {
  fcst[40+j] <- CPIforecast[j]
}
fcst <- as.ts(fcst, frequency=12)
CPIpart<-as.ts(CPIdata[87:130],12)
plot(CPIpart,xlim = c(0,50 ),ylim = c(250,300 ),ylab="Consumer price index",xlab="Time",axes=T, main="Consumer Price Index forecasting by ARIMA(11,1,12) model")
lines(fcst, col="blue")
lines(CPIpredictlower,col="red",lty=2)
lines(CPIpredictupper,col="red",lty=2)

abline(v=41,lty="dashed")
legend("topleft",c("Actual","Prediction","Interval"),lty=c(1,1),col=c("black","blue","red"),cex=0.5)

rmse(CPIdata[128:130],fcst[41:43])
fcst

CPIpredict <- predict(Arima(CPIdata[87:127], c(2,1,1)),n.ahead=10)
CPIforecast <- CPIpredict$pred
CPIpredictlower <- NULL
CPIpredictupper <- NULL
for (i in seq_along(CPIforecast)) {
  CPIpredictlower[40+i] <- CPIforecast[i]-(CPIpredict$se[i]*1.96)
  CPIpredictupper[40+i] <- CPIforecast[i]+(CPIpredict$se[i]*1.96)
}
fcst <- NULL
for (j in seq_along(CPIforecast)) {
  fcst[40+j] <- CPIforecast[j]
}
fcst <- as.ts(fcst, frequency=12)
CPIpart<-as.ts(CPIdata[87:130],12)
plot(CPIpart,xlim = c(0,50 ),ylim = c(250,300 ),ylab="Consumer price index",xlab="Time",axes=T, main="Consumer Price Index forecasting by ARIMA(2,1,0) model")
lines(fcst, col="blue")
lines(CPIpredictlower,col="red",lty=2)
lines(CPIpredictupper,col="red",lty=2)

abline(v=41,lty="dashed")
legend("topleft",c("Actual","Prediction","Interval"),lty=c(1,1),col=c("black","blue","red"),cex=0.5)

rmse(CPIdata[128:130],fcst[41:43])
fcst



