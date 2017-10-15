
rm(list=ls())

View(dat1)
dim(dat1)

library(caret)
library(dplyr)
library(ggplot2)
library(xts)
library(reshape2)
library(vars)
library("gridExtra")


#import dataset
data <- read_csv("~/Documents/ML_code/ICL_interview/shiny-project/TrainingSet.csv")


#create subset with data on MDGs only 
unique(data$`Series Code`)
dt <- subset(data, data$`Series Code` %in% c("1.2","2.1","3.2","4.1","5.1","6.1","6.7","7.8","8.16"))

glimpse(dt)
summary(dt)


#function to rename columns to respective year
n <- 1972:2007
x <- 2

while (x <= 37){
  for(y in n) {
    colnames(dt)[x] <- y
    x <- x + 1
  }}


#rename columns 
colnames(dt)[40] <- 'serieName'
colnames(dt)[39] <- 'serieCode'
colnames(dt)[38] <- 'country'
rownames(dt) <- NULL

dim(dt)
length(unique(dt$X1))


#add new columns concatenating columns - to facilitate manipulation
dt$codeAndCountry <- paste(dt$serieCode,dt$country,dt$X1, sep=" - ") 
dt$serieName <- paste(dt$serieCode,dt$serieName, sep=" - ") 
dt$country <- paste(dt$country,dt$X1, sep=" - ") 



#create function to take a random sample of 30% without replacement 
codes <- unique(dt$serieCode)
codes
p = 0.3 #percentage for sampling 
dat <- data.frame() #create empty dataframe to store the sampled data

for(i in codes) {
  dsub <- subset(dt, dt$serieCode == i)
  set.seed(1100)
  B = ceiling(nrow(dsub) * p)
  dsub <- dsub[sample(1:nrow(dsub), B, replace=FALSE), ]
  dat <- rbind(dat, dsub) 
}

View(dat) # View sample data 


###################################################################
#DO NOT USE FOR DEMO >>>>> create subset with submission labels only
#import data for which prediction is required
#submrows <- read.csv("~/Desktop/data/SubmissionRows.csv")
#sub <- submrows[,1]
#dat <- subset(data, X  %in% c(sub))
#View(dat)
##################################################################




###################################################reshape data.frame for plotting 
names(dat)
dat1 <- melt(dat, id=c("X1","codeAndCountry","serieCode","country","serieName"))
colnames(dat1)[7] <- 'indicator'
colnames(dat1)[6] <- 'year'

View(dat1)
indic <- unique(dat1$serieName)
year <- unique(dat1$year)

dat1[dat1$year == "2000",]

# order data and view result  
dat1 <- dat1[order(dat1$codeAndCountry),]
View(dat1)
glimpse(dat1)
dat1$year <- as.character(dat1$year)
dat1$year <- as.Date(dat1$year, format = "YYYY")
View(head(dat1,200))

############################################################# DATA VISUALISATION 

#view by MDG, by country
p1 <- ggplot(data=dat1, 
             aes(x=year, 
                 y=indicator,
                 group=codeAndCountry, 
                 colour=codeAndCountry)) + geom_line() + geom_point() 

p1 + theme(legend.text=element_text(size=5))

View(unique(dat1$country))
View(unique(dat1$serieName))

#view by MDG  
rm(p1)
p1 <- ggplot(data=dat1, 
             aes(x=year, 
                 y=indicator,
                 group=codeAndCountry, 
                 colour=serieName)) + geom_line() + geom_point() 
p1
p1 + facet_grid(serieCode~.)


#function to create a separate graph for each indicator
w <- (unique(dat1$serieName))
plotX<-function(i){
  n <- dat1[dat1$serieName==w[i],]  
  ggplot(data=n, 
         aes(x=year, 
             y=indicator,
             group=codeAndCountry, 
             colour=country)) + geom_line() + geom_point()  + labs(title=w[i])
}



#"1.2 - Eradicate extreme poverty and hunger" 
plotX(1)
#"2.1 - Achieve universal primary education"                        
plotX(2)
#"3.2 - Promote gender equality and empower women" 
plotX(3)
#"4.1 - Reduce child mortality"                                     
plotX(4)
#"5.1 - Improve maternal health"  
plotX(5)
#"6.1 - Combat HIV/AIDS"                                            
plotX(6)
#"6.7 - Combat malaria and other diseases" 
plotX(7)
#"7.8 - Ensure environmental sustainability"   
plotX(8)
#"8.16 - Develop a global partnership for development: Internet Use"
plotX(9)


############################################################# INSPECT ODD RESULTS
#inspect results in plotX(?) and plotX(?)
n <- dat[dat$serieName=="TYPE SERIE NAME FOR INSPECTION",]
View(n)
n <- dat[dat$serieName=="TYPE SERIE NAME FOR INSPECTION",]
View(n)
#################################################################################


#boxplots for each indicator 

#View(y1972)
y1972 <- dat1[dat1$year=='1972',]
g4 <- qplot(serieCode,indicator , data=y1972, geom=c("boxplot", "jitter"), 
            fill=serieCode, main="1972",
            xlab="MDGs", ylab="indicators",colour=serieCode)

#View(y1990)
y1990 <- dat1[dat1$year=='1990',]
g2 <- qplot(serieCode,indicator , data=y1990, geom=c("boxplot", "jitter"), 
            fill=serieCode, main="1990",
            xlab="MDGs", ylab="indicators",colour=serieCode)

#View(y2007)
y2007 <- dat1[dat1$year=='2007',]
g3 <- qplot(serieCode,indicator , data=y2007, geom=c("boxplot", "jitter"), 
            fill=serieCode, main="2007",
            xlab="MDGs", ylab="indicators",colour=serieCode)


#compare 2007 with 1972 & 1990 
myPlotList = list(g4,g2,g3)
do.call(grid.arrange,  myPlotList)

############################################################# CREATE TIME SERIES  
#USE DAT > reshape data.frame, and create time serie from each row 

rm(df)

df <- data.frame(matrix(nrow = 36,ncol=436)) 
for (x in 1:436) {
  z <- as.numeric(dat[x,2:37])
  df[,x] <- ts(z,start=c(1972),end=c(2007),frequency=1)
  colnames(df)[x] <- dat$codeAndCountry[x]  
}

View(df)