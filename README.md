# USCPIforecasting
This project is about forecasting US consumer price index. "The level of inflation is a serious impediment to economic recovery". The best way to understand inflation is to use CPI. 

![image](https://user-images.githubusercontent.com/100450841/155900844-1449b655-5840-47fe-91ec-eea6d55ad3f9.png)

CPI rose rapidly then fell to the lowest in 2008(financial crisis). In 2021, there is an abnormal rapidly rose showed in this year.

![image](https://user-images.githubusercontent.com/100450841/155901204-3c600cf2-6bbd-4cf2-bbf1-4d7068eb6e09.png)

Dataset is used on U.S. Bureau of labor statistics,all items in U.S. city average, all urban consumers, not seasonally adjusted during 2011 January to 2021 October.

![image](https://user-images.githubusercontent.com/100450841/155901269-b092c40f-da78-4c26-89be-e626621012ea.png)

Graph1: Over time plot.

KPSS ADF test1:

__________ P value

KPSS test: 0.01

ADF test: 0.99

KPSS: h0: has a unit root. h1: no unit root. 

ADF: h0: no unit root. h1: has a unit root.

KPSS cannot reject null, ADF reject null

![image](https://user-images.githubusercontent.com/100450841/155901401-1830e928-64c7-40d7-a8cb-37d86af19238.png)

Graph2: Differenced and Logged Consumer Price Index Plot

Much smooth than before.


KPSS ADF test2:

__________ P value

KPSS test: 0.1

ADF test: 0.01



Seasonal Test:

![image](https://user-images.githubusercontent.com/100450841/155901585-34e5e644-a2f4-4fc6-82f5-1004b0bdb520.png)

Graph3: Seasonal plot

![image](https://user-images.githubusercontent.com/100450841/155901613-759899f9-9933-45ff-9412-423edec083d3.png)

Graph4: Residuals for Consumer Price Index

![image](https://user-images.githubusercontent.com/100450841/155901626-a1aa18fa-5050-4061-b68c-4e2ad0cd553c.png)

Graph5: Residuals for Consumer Price Index with Seasonal

There is no obvious differece between two plots.



 
ACF PACF plot:

![image](https://user-images.githubusercontent.com/100450841/155901686-15c3c412-f04e-42c5-932d-e058fe9d67d7.png)

Graph6: Auto correlation function lag plot

![image](https://user-images.githubusercontent.com/100450841/155901743-41bf10ad-853b-4c5b-a8b4-9c26f0447240.png)

Graph7: Partial Auto-correlation plot


Lag ACF at 0,1,11,12.  Lag PACF at 1,2,11



Find out best model by AIC BIC:

![image](https://user-images.githubusercontent.com/100450841/155901824-93fc9e5a-3c81-4bcd-adc9-f121e59f405f.png)

Table2: AIC and BIC test for the part of ARIMA models


AIC best:ARIMA(11,1,12) BIC best:ARIMA(2,1,0)



RMSE test: use predict data compare with original data.

_________________RMSE

ARIMA(11,1,12): 1.10775

ARIMA(2,1,0):2.09223



Prediction of CPI in 10 month : 

![image](https://user-images.githubusercontent.com/100450841/155901952-ad82dd61-6c9f-4819-815c-d96af32033f7.png)

Graph8: ARIMA(11,1,12) Forecasting Result of Consumer Price Index
