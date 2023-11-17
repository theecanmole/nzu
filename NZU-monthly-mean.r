NZU-monthly-mean  R code

# R code to create a mean monthly time series vector of prices of the New Zealand Emission Unit (NZU) from raw data of irregular prices webscraped from various web sources. 
# Don't forget to do a find and replace of "-" with "/" in nzu-edited-raw-prices-data.csv 
# in an xterminal run "python api.py" to webscrape the NZU prices and save to the csv file "nzu-edited-raw-prices-data.csv"
# load program aweek
library(aweek)
getwd()
[1] "/home/user/R/nzu"
# or setwd("home/user/R/nzu")
# download raw prices from Github

urlrawdata <- c("https://raw.githubsimoncontent.com/theecanmole/nzu/master/NZU-weekly-prices-data.csv")
                 
download.file(urlrawdata, rawdata)

# or read in raw prices data from a local folder specifying header status as false
data <- read.csv("nzu-edited-raw-prices-data.csv",header=FALSE,stringsAsFactors = FALSE)
dim(data)
[1] 1710    5
# examine dataframe
str(data)
'data.frame':	1710 obs. of  5 variables:
 $ V1: chr  "2010/05/14" "2010/05/21" "2010/05/29" "2010/06/11" ...
 $ V2: chr  "17.75" "17.5" "17.5" "17" ...
 $ V3: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ V4: chr  "2010/05" "2010/05" "2010/05" "2010/06" ...
 $ V5: chr  "2010/W19" "2010/W20" "2010/W21" "2010/W23" ...

# look at the last row again
data[nrow(data),]
1710 date price reference month week
tail(data,1)
       V1    V2        V3    V4   V5
1710 date price reference month week
# converting the last row to a character vector
as.character(tail(data,1))
[1] "date"      "price"     "reference" "month"     "week"   
# add column names as character formated last row cells
colnames(data) <- as.character(tail(data,1))

colnames(data) 
[1] "date"      "price"     "reference" "month"     "week"  
# delete last row 1710 - the old header names
data <- data[-nrow(data),] 
# change formats of date column and price column
data$date <- as.Date(data$date)
data$price <- as.numeric(data$price)
# add month variable/factor to data
data$month <- as.factor(format(data$date, "%Y-%m"))
# make aweek vector from date format column and overwrite contents of week column  
data$week <- as.aweek(data$date) 

# examine dataframe
str(data)
'data.frame':	1709 obs. of  5 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month    : Factor w/ 163 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...
 $ week     :Class 'aweek'  atomic [1:1699] 2010-W19-5 2010-W20-5 2010-W21-6 2010-W23-5 ...
  .. ..- attr(*, "week_start")= int 1 
  
# create new dataframe of monthly mean price 
monthprice<-aggregate(price ~ month, data, mean)

# examine dataframe
str(monthprice)
'data.frame':	163 obs. of  2 variables:
 $ month: Factor w/ 163 levels "2010-05","2010-06",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price: num  17.6 17.4 18.1 18.4 20.2 ...
 
# create a vector that is the number of months and the number of rows in 'monthprice' 
lengthmonthprice <- length(monthprice[["month"]])
lengthmonthprice
[1] 163

# replace month factor with mid-month 15th of month date-formatted object 
monthprice[["month"]] = seq(as.Date('2010-05-15'), by = 'months', length = nrow(monthprice)) 
# rename columns
colnames(monthprice) <- c("date","price")
# round mean prices to whole cents
monthprice[["price"]] = round(monthprice[["price"]], digits = 2)

# examine dataframe - again
str(monthprice)
'data.frame':	163 obs. of  2 variables:
 $ date: Date, format: "2010-05-15" "2010-06-15" ...
 $ price: num  17.6 17.4 18.1 18.4 20.1 ...

# check last 6 weeks
tail(data$week)
<aweek start: Monday>
[1] "2023-W45-5" "2023-W46-1" "2023-W46-2" "2023-W46-3" "2023-W46-4"
[6] "2023-W46-5"
# remove week day part from aweek week and stay in aweek format
data$week <- trunc(data$week) 
table(data$week) 

str(data)
'data.frame':	1709 obs. of  5 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month    : Factor w/ 163 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...
 $ week     :Class 'aweek'  atomic [1:1709] 2010-W19 2010-W20 2010-W21 2010-W23 ...
  .. ..- attr(*, "week_start")= int 1
  
# create new dataframe of weekly mean price based on 'aweek' variable 
weeklyprice <- aggregate(price ~ week, data, mean)

# round mean prices to whole cents
weeklyprice[["price"]] = round(weeklyprice[["price"]], digits = 2)

# convert and add aweek week to date format date 
weeklyprice[["date"]] <- as.Date(weeklyprice[["week"]])
# change order of columns
weeklyprice <- weeklyprice[,c(3,2,1)]
str(weeklyprice)
'data.frame':	611 obs. of  3 variables:
 $ date : Date, format: "2010-05-10" "2010-05-17" ...
 $ price: num  17.8 17.5 17.5 17 17.8 ...
 $ week :Class 'aweek'  atomic [1:611] 2010-W19 2010-W20 2010-W21 2010-W23 ...
  .. ..- attr(*, "week_start")= int 1

# subset out the spot prices only from data 
spotprice <- data[,c(1,2)] 
 
# write the edited raw prices and urls to a .csv file 

write.table(data, file = "nzu-edited-raw-prices-data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the mean monthly price dataframe to a .csv file 

write.table(monthprice, file = "nzu-month-price.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the mean week price dataframe to a .csv file 

write.table(weeklyprice, file = "weeklymeanprice.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the spot prices dataframe to a .csv file 

write.table(spotprice, file = "spotprices.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 

# charts

# create svg format chart of mean monthly price with 14 pt text font and grid lines via 'grid'

svg(filename="NZUprice-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["date"]],monthprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit monthly mean prices 2010 - 2023")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# create svg format chart of all spot (secondary) prices with 14 pt text font and grid lines via 'grid'

svg(filename="NZU-spot-prices-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(spotprice[["date"]],spotprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.9,line=-1.3,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit spot prices 2010 - 2023")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# create svg format chart of all weekly mean spot (secondary) prices with 14 pt text font and grid lines via 'grid' 

svg(filename="NZU-mean-weekly-prices-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(weeklyprice$date,weeklyprice$price,tck=0.01,axes=T,ann=T, las=1,col="red",lwd=1,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit mean weekly spot prices 2010 2023")) )
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
[1] aweek_1.0.3  rkward_0.6.5

loaded via a namespace (and not attached):
[1] tools_3.3.3

Python 2.7.13
