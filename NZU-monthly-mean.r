NZU-monthly-mean  R code

# R code to create a mean monthly time series vector of prices of the New Zealand Emission Unit (NZU) from raw data of irregular prices webscraped from various web sources. 

# Don't forget to do a find and replace of "-" with "/" in nzu-edited-raw-prices-data.csv 

# in an xterminal run "python api.py" to webscrape the NZU prices and save to the csv file "nzu-edited-raw-prices-data.csv"

getwd()
[1] "/home/user/R/nzu"
# or setwd("home/user/R/nzu")
# download raw prices from Github

urlrawdata <- c("https://raw.githubsimoncontent.com/theecanmole/nzu/master/NZU-weekly-prices-data.csv")
                 
download.file(urlrawdata, rawdata)

# or read in raw prices data from a local folder specifying header status as false
data <- read.csv("nzu-edited-raw-prices-data.csv",header=FALSE,stringsAsFactors = FALSE)
dim(data)
[1] 1876    5
# examine dataframe
str(data)
'data.frame':	1876 obs. of  5 variables:
 $ V1: chr  "2010/05/14" "2010/05/21" "2010/05/29" "2010/06/11" ...
 $ V2: chr  "17.75" "17.5" "17.5" "17" ...
 $ V3: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ V4: chr  "2010/05" "2010/05" "2010/05" "2010/06" ...
 $ V5: chr  "2010/W19" "2010/W20" "2010/W21" "2010/W23" ...

[1] "date"      "price"     "reference" "month"     "week"   
# add column names as character string of formatted last row cells
colnames(data) <- as.character(tail(data,1))

colnames(data) 
[1] "date"      "price"     "reference" "month"     "week"  
# delete last row - the old header names
data <- data[-nrow(data),] 
# change formats of date column and price column
data$date <- as.Date(data$date)
data$price <- as.numeric(data$price)
# add month variable/factor to data
data$month <- as.factor(format(data$date, "%Y-%m"))

# load package aweek
library(aweek)

# make aweek vector from date format column and overwrite contents of week column with week start set at Day 1 - Monday (default) 
data$week <- as.aweek(data$date)
# make aweek vector into factor
# data$weekfactor <- factor_aweek(data$week)

# examine the dataframe again to check formats of columns
str(data)
'data.frame':	1875 obs. of  5 variables:
 $ date      : Date, format: "2010-05-14" "2010-05-21" ...
 $ price     : num  17.8 17.5 17.5 17 17.8 ...
 $ reference : chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month     : Factor w/ 171 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...
 $ week      :Class 'aweek'  atomic [1:1804] 2010-W19 2010-W20 2010-W21 2010-W23 ...
  .. ..- attr(*, "week_start")= int 1
  
# create new dataframe of monthly mean price 
monthprice<-aggregate(price ~ month, data, mean)

# examine dataframe
str(monthprice)
'data.frame':	171 obs. of  2 variables:
 $ month: Factor w/ 171 levels "2010-05","2010-06",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price: num  17.6 17.4 18.1 18.4 20.2 ...
 
# create a vector that is the number of months and the number of rows in 'monthprice' 
lengthmonthprice <- length(monthprice[["month"]])
lengthmonthprice
[1] 171

# replace month factor with mid-month 15th of month date-formatted object 
monthprice[["month"]] = seq(as.Date('2010-05-15'), by = 'months', length = nrow(monthprice)) 
# rename columns
colnames(monthprice) <- c("date","price")
# round mean prices to whole cents
monthprice[["price"]] = round(monthprice[["price"]], digits = 2)

# examine the monthly price dataframe - again
str(monthprice)
'data.frame':	171 obs. of  2 variables:
 $ date: Date, format: "2010-05-15" "2010-06-15" ...
 $ price: num  17.6 17.4 18.1 18.4 20.1 ...

## weekly time series
str(data$week) 
Class 'aweek'  atomic [1:1875] 2010-W19 2010-W20 2010-W21 2010-W23 ...
  ..- attr(*, "week_start")= int 1 
head(data$week,2) 
<aweek start: Monday>
[1] "2010-W19-5" "2010-W20-5"

# remove week day part from aweek week and stay in aweek format
data$week <- trunc(data$week) 

# create new dataframe of weekly mean price based on 'aweek' variable 
weeklyprice <- aggregate(price ~ week, data, mean) 

str(weeklyprice) 
'data.frame':	647 obs. of  2 variables:
 $ week :Class 'aweek'  atomic [1:644] 2010-W19 2010-W20 2010-W21 2010-W23 ...
  .. ..- attr(*, "week_start")= int 1
 $ price: num  17.8 17.5 17.5 17 17.8 ...
# includes missing data, as levels (all weeks) = 709 but obs (weeks with price) = 615 

tail(weeklyprice) 
        week   price
642 2024-W25 49.1000
643 2024-W26 50.6425
644 2024-W27 51.0600
645 2024-W28 52.5480
646 2024-W29 53.7580
647 2024-W30 51.6520

# add date column from aweek week & change to date format 
weeklyprice[["date"]] <- as.Date(weeklyprice[["week"]])  
# round mean prices to whole cents
weeklyprice[["price"]] = round(weeklyprice[["price"]], digits = 2)

# load package xts
library("xts")
# load package zoo
library("zoo")

# convert and add aweek week to date format date 
#weeklyprice[["date"]] <- as.Date(weeklyprice[["week"]])
# change order of columns
weeklyprice <- weeklyprice[,c(3,2,1)]
str(weeklyprice)
'data.frame':	647 obs. of  3 variables:
 $ date : Date, format: "2010-05-10" "2010-05-17" ...
 $ price: num  17.8 17.5 17.5 17 17.8 ...
 $ week :Class 'aweek'  atomic [1:640] 2010-W19 2010-W20 2010-W21 2010-W23 ...
  .. ..- attr(*, "week_start")= int 1

## Fill in the missing values in the weekly prices data series - as there are no prices for at least 95 weeks

# How many weeks should be included if there were prices for all weeks?
weeklypriceallDates <- seq.Date( min(weeklyprice$date), max(weeklyprice$date), "week")
str(weeklypriceallDates)
 Date[1:742], format: "2010-05-10" "2010-05-17" "2010-05-24" "2010-05-31" ...

# How many weeks were there in weekly prices dataframe which omits weeks with missing prices?
nrow(weeklyprice)
[1] 647
# How many missing weeks?
length(weeklypriceallDates) - nrow(weeklyprice)
[1] 95
# So 95 missing prices/weeks 

# create dataframe of all the weeks with missing weeks of prices as NA
weeklypricemissingprices <- merge(x= data.frame(date = weeklypriceallDates),  y = weeklyprice,  all.x=TRUE)

str(weeklypricemissingprices)
'data.frame':	742 obs. of  3 variables:
 $ date : Date, format: "2010-05-10" "2010-05-17" ...
 $ price: num  17.8 17.5 17.5 NA 17 ...
 $ week : 'aweek' chr  "2010-W19" "2010-W20" "2010-W21" NA ...
  ..- attr(*, "week_start")= int 1 
  
head(weeklypricemissingprices,9)
       date price     week
1 2010-05-10 17.75 2010-W19
2 2010-05-17 17.50 2010-W20
3 2010-05-24 17.50 2010-W21
4 2010-05-31    NA     <NA>
5 2010-06-07 17.00 2010-W23
6 2010-06-14    NA     <NA>
7 2010-06-21 17.75 2010-W25
8 2010-06-28 17.50 2010-W26
9 2010-07-05 18.00 2010-W27

# Convert the data frame price and date columns to a zoo time series object
weeklypricemissingpriceszoo <- zoo(weeklypricemissingprices[["price"]], weeklypricemissingprices[["date"]])
str(weeklypricemissingpriceszoo) 
‘zoo’ series from 2010-05-10 to 2024-04-08
  Data: num [1:742] 17.8 17.5 17.5 NA 17 ...
  Index:  Date[1:742], format: "2010-05-10" "2010-05-17" "2010-05-24" "2010-05-31" 
head(weeklypricemissingpriceszoo,9)
2010-05-10 2010-05-17 2010-05-24 2010-05-31 2010-06-07 2010-06-14 2010-06-21 
     17.75      17.50      17.50         NA      17.00         NA      17.75 
2010-06-28 2010-07-05 
     17.50      18.00 

# calculate the missing values with zoo na.approx which is linear interpolation to fill in NA values     
na.approx(weeklypricemissingpriceszoo)
2010-05-10 2010-05-17 2010-05-24 2010-05-31 2010-06-07 2010-06-14 2010-06-21 
   17.7500    17.5000    17.5000    17.2500    17.0000    17.3750    17.7500 
2010-06-28 2010-07-05 2010-07-12 2010-07-19 2010-07-26 2010-08-02 2010-08-09 
   17.5000    18.0000    18.3000    18.3125    18.3250    18.3375    18.3500 
2010-08-16 
   18.3500 
# fill in the missing prices with linear interpolation via zoo package and save output  
weeklypricefilled <- na.approx(weeklypricemissingpriceszoo)
head(weeklypricefilled)
2010-05-10 2010-05-17 2010-05-24 2010-05-31 2010-06-07 2010-06-14 
    17.750     17.500     17.500     17.250     17.000     17.375
# check zoo object
str(weeklypricefilled)
‘zoo’ series from 2010-05-10 to 2024-02-26
  Data: num [1:742] 17.8 17.5 17.5 17.2 17 ...
  Index:  Date[1:742], format: "2010-05-10" "2010-05-17" "2010-05-24" "2010-05-31" ...

# Convert zoo(xts) time series to a data.frame
weeklypricefilleddataframe <- data.frame(date=index(weeklypricefilled),price=coredata(weeklypricefilled))   
 
# check dataframe
str(weeklypricefilleddataframe)
'data.frame':	742 obs. of  2 variables:
 $ date : Date, format: "2010-05-10" "2010-05-17" ...
 $ price: num  17.8 17.5 17.5 17.2 17 ...

# write the infilled mean price per week dataframe to a .csv file 
write.table(weeklypricefilleddataframe, file = "weeklypricefilled.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)  
  
# subset out the spot prices only from data 
spotprice <- data[,c(1,2)] 
# write the spot prices dataframe to a .csv file 
write.table(spotprice, file = "spotprices.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 

# write the edited raw prices and urls to a .csv file 
# write.table(data, file = "nzu-edited-raw-prices-data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the mean monthly price dataframe to a .csv file 
write.table(monthprice, file = "nzu-month-price.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the mean week price dataframe to a .csv file 
write.table(weeklyprice, file = "weeklymeanprice.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

## fill in missing values in week day spot prices
library("xts")
library("zoo")
spotprice <- read.csv("spotprices.csv", colClasses = c("Date","numeric"))

str(spotprice) 
'data.frame':	1875 obs. of  2 variables:
 $ date : Date, format: "2010-05-14" "2010-05-21" ...
 $ price: num  17.8 17.5 17.5 17 17.8 ... 

# How many day dates should be included if there were prices for all days from May 2010 to the present?
spotpricealldates <- seq.Date(min(spotprice$date), max(spotprice$date), "day")
length(spotpricealldates) 
[1] 5188
# how many missing values are there?
length(spotpricealldates) - nrow(spotprice) 
[1] 3313

# create dataframe of all the days with missing prices added as NA
spotpricealldatesmissingprices <- merge(x= data.frame(date = spotpricealldates),  y = spotprice,  all.x=TRUE)
str(spotpricealldatesmissingprices) 
'data.frame':	5188 obs. of  2 variables:
 $ date : Date, format: "2010-05-14" "2010-05-15" ...
 $ price: num  17.8 NA NA NA NA ...
head(spotpricealldatesmissingprices) 
        date price
1 2010-05-14 17.75
2 2010-05-15    NA
3 2010-05-16    NA
4 2010-05-17    NA
5 2010-05-18    NA
6 2010-05-19    NA

# Convert the data frame price and date columns to a zoo time series object
spotpricealldatesmissingpriceszoo <- zoo(spotpricealldatesmissingprices[["price"]], spotpricealldatesmissingprices[["date"]])
# check the object's structure
str(spotpricealldatesmissingpriceszoo)
‘zoo’ series from 2010-05-14 to 2024-04-05
  Data: num [1:5188] 17.8 NA NA NA NA ...
  Index:  Date[1:5188], format: "2010-05-14" "2010-05-15" "2010-05-16" "2010-05-17" "2010-05-18" ...
# look a first 6 lines/rows
head(spotpricealldatesmissingpriceszoo) 
2010-05-14 2010-05-15 2010-05-16 2010-05-17 2010-05-18 2010-05-19 
     17.75         NA         NA         NA         NA         NA

# create a zoo time series matrix with filled in the missing prices with linear interpolation via zoo package and save output  
spotpricefilled <- na.approx(spotpricealldatesmissingpriceszoo)
# round infilled values to cents
spotpricefilled <- round(spotpricefilled,2)

head(spotpricefilled) 
2010-05-14 2010-05-15 2010-05-16 2010-05-17 2010-05-18 2010-05-19 
     17.75      17.71      17.68      17.64      17.61      17.57

str(spotpricefilled) 
‘zoo’ series from 2010-05-14 to 2024-07-12
  Data: num [1:5188] 17.8 17.7 17.7 17.6 17.6 ...
  Index:  Date[1:5188], format: "2010-05-14" "2010-05-15" "2010-05-16" "2010-05-17" ...
  
# Convert  the zoo vector to a data frame
spotpricefilleddataframe <- data.frame(date=index(spotpricefilled),price=coredata(spotpricefilled))   
# check dataframe
str(spotpricefilleddataframe)
'data.frame':	5188 obs. of  2 variables:
 $ date : Date, format: "2010-05-14" "2010-05-15" ...
 $ price: num  17.8 17.7 17.7 17.6 17.6 ...

# Get the days of week and add to dataframe
spotpricefilleddataframe$day <- format(as.Date(spotpricefilleddataframe$date), "%A")

head(spotpricefilleddataframe)  
        date price       day
1 2010-05-14 17.75    Friday
2 2010-05-15 17.71  Saturday
3 2010-05-16 17.68    Sunday
4 2010-05-17 17.64    Monday
5 2010-05-18 17.61   Tuesday
6 2010-05-19 17.57 Wednesday 

# Where are the Saturdays ? use Logical indexing
idSat <- spotpricefilleddataframe$day == "Saturday"  
idSat
[1] FALSE FALSE  TRUE FALSE ....
#  records
# leave out the Saturdays from the dataframe
spotpricefilleddataframe <- spotpricefilleddataframe[!idSat, ]

# Where are the Sundays ?
idSun <- spotpricefilleddataframe$day == "Sunday"  
idSun
# leave out the Sundays
spotpricefilleddataframe <- spotpricefilleddataframe[!idSun, ] 

head(spotpricefilleddataframe)
       date price       day
1 2010-05-14 17.75    Friday
4 2010-05-17 17.64    Monday
5 2010-05-18 17.61   Tuesday
6 2010-05-19 17.57 Wednesday
7 2010-05-20 17.54  Thursday
8 2010-05-21 17.50    Friday 

str(spotpricefilleddataframe)
'data.frame':	3706 obs. of  3 variables:
 $ date : Date, format: "2010-05-14" "2010-05-17" ...
 $ price: num  17.8 17.6 17.6 17.6 17.5 ...
 $ day  : chr  "Friday" "Monday" "Tuesday" "Wednesday" ...

# write the spot prices dataframe to a .csv file 
write.table(spotpricefilleddataframe, file = "spotpricesinfilled.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 
#spotpricefilleddataframe <- read.csv("spotpricesinfilled.csv", colClasses = c("Date","numeric","character")) 

## create rolling mean time series

# read in the infilled spot prices data if needed
#spotpricefilleddataframe <- read.csv("spotpricesinfilled.csv")
# confirm date format of date column if needed
#spotpricesinfilled[["date"]] <- as.Date(spotpricesinfilled[["date"]]) 

spot <- spotpricefilleddataframe[,1:2]
str(spot) 
'data.frame':	3706 obs. of  2 variables:
 $ date      : Date, format: "2010-05-14" "2010-05-17" ...
 $ price     : num  17.8 17.6 17.6 17.6 17.5 ...
nrow(spot)
3706
# write the infilled spot prices dataframe to a .csv file 
write.table(spot, file = "spotpricesinfilled.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 


## Generic functions for computing rolling means, maximums, medians, and sums of ordered observations.

Usage
rollmean(x, k, fill = if (na.pad) NA, na.pad = FALSE, align = c("center", "left", "right"), ...)

# create 21 day (a month of week days) rolling average
spot$spotroll31 <- rollmean(spot[["price"]], k =21,  fill = NA, align = c("center"))
# round the rolling mean values to cents
spot$spotroll31 <- round(spot$spotroll31,2)

# create dataframe of only the 31 day rolling mean values and dates
spotrollmean31  <-spot[,c(1,3)] 
colnames(spotrollmean31) <- c("date","price") 
str(spotrollmean31) 
'data.frame':	3706 obs. of  2 variables:
 $ date : Date, format: "2010-05-14" "2010-05-17" ...
 $ price: num  NA NA NA NA NA NA NA NA NA NA ...

# write the spot prices dataframe to a .csv file 
write.table(spotrollmean31, file = "spotrollmean31.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)  

## charts
# read in monthly mean prices data (if needed)
monthprice <- read.csv("nzu-month-price.csv", skip=0, header=TRUE, sep=",", colClasses = c("Date","numeric"),na.strings="NA", dec=".", strip.white=TRUE)

# make a time series out of mean NZU price per month
mpts <- ts(data = monthprice[["price"]], start =c(2010, 5), deltat = 1/12) 

# create svg format chart of mean monthly price with 14 pt text font and grid lines via 'grid'

svg(filename="NZUprice-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(mpts,tck=0.01,axes=TRUE,ann=TRUE, las=1,col="#ED1A3B",lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit monthly mean prices 2010 - 2024")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# create svg format chart of all spot (secondary) prices with 14 pt text font and grid lines via 'grid' with colour as 'pomegranite' "#ED1A3B"

svg(filename="NZU-spot-prices-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(spotpricefilleddataframe[["date"]],spotpricefilleddataframe[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col= "#ED1A3B" ,lwd=1,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.9,line=-1.3,"Data: 'NZU prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit spot prices 2010 - 2024")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# create svg format chart of all weekly mean spot (secondary) prices with 14 pt text font and grid lines via 'grid' 
# create time series object for average weekly prices
weekts <- ts(weeklypricefilleddataframe[["price"]],frequency=52,start = c(2010,19))
str(weekts) 
Time-Series [1:742] from 2010 to 2024: 17.8 17.5 17.5 17.2 17 ... 

svg(filename="NZU-mean-weekly-prices-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(weekts,tck=0.01,axes=T,ann=T, las=1,col="#ED1A3B",lwd=1,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit mean weekly spot prices 2010 2024")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# create svg format chart of 21 day rolling mean of infilled spot prices 
svg(filename="NZU-rollingmean-prices-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(spotrollmean31,tck=0.01,axes=T,ann=T, las=1,col='4',lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit 21 day rolling mean spot prices 2010 2024")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

sessionInfo()
R version 3.3.3 (2017-03-06)
Platform: i686-pc-linux-gnu (32-bit)
Running under: Debian GNU/Linux 9 (stretch)

locale:
 [1] LC_CTYPE=en_NZ.UTF-8          LC_NUMERIC=C                 
 [3] LC_TIME=en_NZ.UTF-8           LC_COLLATE=en_NZ.UTF-8       
 [5] LC_MONETARY=en_NZ.UTF-8       LC_MESSAGES=en_NZ.UTF-8      
 [7] LC_PAPER=en_NZ.UTF-8          LC_NAME=en_NZ.UTF-8          
 [9] LC_ADDRESS=en_NZ.UTF-8        LC_TELEPHONE=en_NZ.UTF-8     
[11] LC_MEASUREMENT=en_NZ.UTF-8    LC_IDENTIFICATION=en_NZ.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] xts_0.9-7    zoo_1.8-12   aweek_1.0.3  rkward_0.6.5

loaded via a namespace (and not attached):
[1] tools_3.3.3     grid_3.3.3      lattice_0.20-34 

# prior to Sunday 10 December 2023
sessionInfo()
R version 3.3.3 (2017-03-06)
Platform: i686-pc-linux-gnu (32-bit)
Running under: Debian GNU/Linux 9 (stretch)

locale:
 [1] LC_CTYPE=en_NZ.UTF-8          LC_NUMERIC=C                 
 [3] LC_TIME=en_NZ.UTF-8           LC_COLLATE=en_NZ.UTF-8       
 [5] LC_MONETARY=en_NZ.UTF-8       LC_MESSAGES=en_NZ.UTF-8      
 [7] LC_PAPER=en_NZ.UTF-8          LC_NAME=en_NZ.UTF-8          
 [9] LC_ADDRESS=en_NZ.UTF-8        LC_TELEPHONE=en_NZ.UTF-8     
[11] LC_MEASUREMENT=en_NZ.UTF-8    LC_IDENTIFICATION=en_NZ.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] xts_0.9-7    zoo_1.7-14   aweek_1.0.3  rkward_0.6.5

loaded via a namespace (and not attached):
[1] tools_3.3.3     grid_3.3.3      lattice_0.20-34

Python 2.7.13
