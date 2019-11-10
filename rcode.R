setwd("C:/Users/Nathan/Desktop/school/statistical data management")

house <- read.table ("house.txt", header=T)
attach(house)
names(house)

plot(SQFT,PRICE,pch=21,col="blue", bg="red")

model<- lm(SQFT~PRICE)
abline(model,col="red")
yhat<- predict(model,PRICE=PRICE)
join<- function(i)
  lines(c(PRICE[i],PRICE[i]),c(SQFT[i], yhat[i]), col="green")
sapply(1:9,join)