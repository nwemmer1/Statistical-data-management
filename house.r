# part of Ch. 8, setting up skew test
par(mfrow=c(1,2))
x <- seq(0,4,0.01)

skew <- function(x){
  m3 <- sum((x-mean(x))^3)/length(x)
  s3 <- sqrt(var(x))^3
  m3/s3
}

# extracting data
house <- read.table("house.txt", header=T)
attach(house)
names(house)
house

#Getting the Famous Five in a Single Matrix
b <- cbind(1,TAX,SQFT)
dimnames(b) [[2]][1] <- "sample"
t(b) %*% b

# summaries for data
summary(TAX)
fivenum(TAX)

# testing for normality using a Q-Q plot
par(mfrow=c(1,1))
qqnorm(TAX)
qqline(TAX,lty=2)

# checking if mean is within range of acceptable values for daa
a <- numeric(10000)
for(i in 1:10000) a[i] <- mean(sample(TAX,replace=T))
hist(a,main="",col="blue")

# testing skew for TAX data
hist(TAX)
skew(TAX)
skew(TAX)/sqrt(6/length(TAX))
1-pt(2.949,28)
skew(sqrt(TAX))/sqrt(6/length(TAX))
skew(log(TAX))/sqrt(6/length(TAX))

# creating scatterplots of TAX vs SQFT and TAX vs PRICE
plot(SQFT,TAX)
plot(AGE,TAX)

# testing for relationships between TAX, SQFT and PRICE
reg <- lm(TAX~SQFT)
summary(reg)
influence.measures(reg)$is.inf

reg <- lm(TAX~AGE)
summary(reg)
influence.measures(reg)$is.inf

reg <- lm(TAX ~ SQFT + AGE)
summary(reg)
influence.measures(reg)$is.inf

# regression modelling
(sse <- deviance(lm(TAX~AGE)))
(ssy <- deviance(lm(TAX~1)))

(ssr <- ssy-sse)
anova(lm(TAX~AGE))

model <- lm(TAX~AGE)
predict(model,list(PRICE=2050))

par(mfrow=c(2,2))
plot(model)
model2 <- update(model,subset=( PRICE != 2050))
summary(model2)

# multiple regression modelling
Y <- cbind(TAX, PRICE)

model <- manova(Y~SQFT*AGE)
summary(model)
summary.aov(model)