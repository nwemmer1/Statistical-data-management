######################################################
############ Analyzing the Diamond Data ##############
######################################################

#Opening the file and summarizing data
diamonds <- read.table("diamonds.txt",header=T)

attach(diamonds)
names(diamonds)
head(diamonds)

diamonds
summary(diamonds)

#######   Creating Plots for Color and Clarity #######

#install.packages('plyr')
library(plyr)
color = count(COLOR, "COLOR")
color$COLOR <- paste(color$COLOR, color$freq) # add percents to labels
color$COLOR <- paste(color$COLOR,"%",sep="") # ad % to labels
pie(color$freq,color$COLOR,main="Pie Chart of Color")

clarity = count(CLARITY,"CLARITY")
clarity$CLARITY <- paste(clarity$CLARITY, clarity$freq) # add percents to labels
clarity$CLARITY <- paste(clarity$CLARITY,"%",sep="") # ad % to labels
pie(clarity$freq, clarity$CLARITY,main="Pie Chart of Clarity")

COLOR <- factor(COLOR)
CLARITY <- factor(CLARITY)

plot(COLOR, PRICE, main="Price vs Color Boxplot", ylab="Price", xlab="Color",col="goldenrod")
plot(COLOR, WEIGHT, main="Weight vs Color Boxplot", ylab="Weight", xlab="Color", col="goldenrod")
plot(COLOR, main="Color Barchart", xlab="Color", ylab="Count", col="goldenrod")

plot(CLARITY, PRICE, main="Price vs Clarity Boxplot", ylab="Price", xlab="Clarity", col="red")
plot(CLARITY, WEIGHT, main="Weight vs Clarity Boxplot", ylab="Weight", xlab="Clarity", col="red")
plot(CLARITY, main="Clarity Barchart", xlab="Clarity", ylab="Count", col="red")


#######   Creating Plots for Price and Weight #######

hist(PRICE,xlab="Price",col="blue")
outlier_values <- boxplot.stats(diamonds$PRICE)$out  # outlier values.
boxplot(diamonds$PRICE,main="Price",boxwex=0.1)
mtext(paste("Outliers: ",paste(outlier_values,collapse=", ")), cex=0.6)

hist(WEIGHT, xlab="Weight", col="darkgreen")
outlier_values <- boxplot.stats(diamonds$WEIGHT)$out  # outlier values.
boxplot(diamonds$WEIGHT,main="Weight",boxwex=0.1)
mtext(paste("Outliers: ",paste(outlier_values,collapse=", ")), cex=0.6)

plot(WEIGHT, PRICE, main="Price vs Weight Scatterplot", ylab="Price", xlab="Weight", col="darkseagreen")

means <- tapply(PRICE,WEIGHT,mean)
barplot(means,main="Mean Price vs. Weight Barplot",xlab="Weight",ylab="Mean Price",col="forestgreen")

#Standard Deviations
sd(PRICE)
sd(WEIGHT)

#Calculating Mode
Mode = function(x){
  ta = table(x)
  tam = max(ta)
  if (all(ta == tam))
    mod = NA
  else
    if(is.numeric(x))
      mod = as.numeric(names(ta)[ta == tam])
  else
    mod = names(ta)[ta == tam]
  return(mod)
}

Mode(COLOR)
Mode(CLARITY)
Mode(WEIGHT)
Mode(PRICE)