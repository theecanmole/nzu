Name of spreadsheet NZU-price-data-2010-2016

spreadsheet url

https://docs.google.com/spreadsheets/d/1kVaWs_G_Uy8ifesqRWEY5V4mAuf6BPZNt6-lte3IuJA

short url no 1 https://bit.ly/1S6fPka = 
# https://docs.google.com/spreadsheets/d/1kVaWs_G_Uy8ifesqRWEY5V4mAuf6BPZNt6-lte3IuJA/edit#gid=0
# Date Year Month Decimal prices NZUs CERs ERUs  from 31/03/10 to 30/06/16

short url no 2 https://goo.gl/zEt852 
https://docs.google.com/spreadsheets/d/1kVaWs_G_Uy8ifesqRWEY5V4mAuf6BPZNt6-lte3IuJA/edit#gid=0
"NZU-price-data-2010-2015"
Date Year Month Decimal prices NZUs CERs ERUs  from 31/03/10 to 30/06/16

short url no 3 https://bit.ly/29U7i3D	
= https://docs.google.com/spreadsheets/d/1KBD-mg53_adOjkmXjCoSqaHQBC3vxQaKMrxf51xkRtA/edit#gid=0
= Date prices NZUs CERs ERUs from 31/03/10 to 31/10/16

col1 <-c(  "#1B9E77", "#D95F02", "#7570B3" ) 
col2 <- c(  "#E41A1C", "#377EB8", "#4DAF4A")

barplot(c(3,4,5),col=col1) 
 # green brown purple

barplot(c(5,4,3),col=col2)
# red blue green

getwd()
[1] "/home/simon"
setwd("/home/simon/R/nzu")

# 9/11/2016
# the sheet with the carbon news prices which could be averaged by month

x <- read.csv("/home/simon/R/nzu/NZU-price-2016.csv", skip=6,header=TRUE, sep=",", colClasses = c("Date","numeric","numeric","character"),na.strings="NA", dec=".", strip.white=TRUE)

str(x)
'data.frame':	294 obs. of  4 variables:
 $ date      : Date, format: "2016-01-11" "2016-01-13" ...
 $ price     : num  9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...
 $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ...
 $ Source    : chr  "" "" "" "http://www.carbonnews.co.nz/story.asp?storyID=9354" ...

 
head(x,20)
        date price monthprice
1 2016-01-11  9.75         NA
2 2016-01-13  9.70         NA
3 2016-01-14  9.70         NA
4 2016-01-15  9.73         NA
5 2016-01-16    NA         NA
6 2016-01-17    NA         NA
18 2016-01-29  9.50         NA
19 2016-01-30    NA         NA
20 2016-01-31  9.62   9.621538                             
                             Source
1                                                   
2                                                   
3                                                   
4 http://www.carbonnews.co.nz/story.asp?storyID=9354
5                                                   
6                                          
http://www.carbonnews.co.nz/story.asp?storyID=4336

tapply(x$price,x$date,mean)

str(x$date)
Date[1:294], format: "2016-01-11" "2016-01-13" "2016-01-14" "2016-01-15" ...

str(x$price)
num [1:294] 9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...

x$date[1:20]
 [1] "2016-01-11" "2016-01-13" "2016-01-14" "2016-01-15" "2016-01-16"
 [6] "2016-01-17" "2016-01-18" "2016-01-19" "2016-01-20" "2016-01-21"
[11] "2016-01-22" "2016-01-23" "2016-01-24" "2016-01-25" "2016-01-26"
[16] "2016-01-27" "2016-01-28" "2016-01-29" "2016-01-30" "2016-01-31"

format(x$date[1:20], "%Y-%m")
 [1] "2016-01" "2016-01" "2016-01" "2016-01" "2016-01" "2016-01" "2016-01"
 [8] "2016-01" "2016-01" "2016-01" "2016-01" "2016-01" "2016-01" "2016-01"
[15] "2016-01" "2016-01" "2016-01" "2016-01" "2016-01" "2016-01"

format(x$date[285:294], "%Y-%m")
 [1] "2016-10" "2016-10" "2016-10" "2016-10" "2016-10" "2016-10" "2016-10"
 [8] "2016-10" "2016-10" "2016-10"
 
x$month <- as.factor(format(x$date, "%Y-%m"))

str(x)
'data.frame':	294 obs. of  5 variables:
 $ date      : Date, format: "2016-01-11" "2016-01-13" ...
 $ price     : num  9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...
 $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ...
 $ Source    : chr  "" "" "" "http://www.carbonnews.co.nz/story.asp?storyID=9354" ...
 $ month     : Factor w/ 10 levels "2016-01","2016-02",..: 1 1 1 1 1 1 1 1 1 1 ...


head(x)

#'data.frame':	294 obs. of  5 variables:
# $ date      : Date, format: "2016-01-11" "2016-01-13" ...
# $ price     : num  9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...
# $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ...
# $ Source    : chr  "" "" "" "http://www.carbonnews.co.nz/story.asp?storyID=9354" ...
$ $ month     : Factor w/ 10 levels "2016-01","2016-02",..: 1 1 1 1 1 1 1 1 1 1 ...
 
str(x$month)
Factor w/ 10 levels "2016-01","2016-02",..: 1 1 1 1 1 1 1 1 1 1 ...
length(x$month) 
[1] 294

str(x[["price"]])
num [1:294] 9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...

mean(x[["price"]])
[1] NA
mean(x[["price"]],na.rm = TRUE)
[1] 13.7232

aggregate(price ~ month, x, mean)
    month     price
1  2016-01  9.621429
2  2016-02  9.361429
3  2016-03 10.626667
4  2016-04 12.810000
5  2016-05 14.388571
6  2016-06 16.965000
7  2016-07 17.982727
8  2016-08 18.034444
9  2016-09 18.838000
10 2016-10 18.755000

mprice<-aggregate(price ~ month, x, mean)

str(mprice)
'data.frame':	10 obs. of  2 variables:
 $ month: Factor w/ 10 levels "2016-01","2016-02",..: 1 2 3 4 5 6 7 8 9 10
 $ price: num  9.62 9.36 10.63 12.81 14.39 ...

mprice$month = seq(as.Date('2016-01-15'), by = 'months', length = 10) 

str(mprice)

'data.frame':	10 obs. of  2 variables:
 $ month: Date, format: "2016-01-15" "2016-02-15" ...
 $ price: num  9.62 9.36 10.63 12.81 14.39 ...
 
mprice.df <- merge(x, mprice, by="month") 

'data.frame':	294 obs. of  6 variables:
 $ month     : Factor w/ 10 levels "2016-01","2016-02",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ date      : Date, format: "2016-01-11" "2016-01-13" ...
 $ price.x   : num  9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...
 $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ...
 $ Source    : chr  "" "" "" "http://www.carbonnews.co.nz/story.asp?storyID=9354" ...
 $ price.y   : num  9.62 9.62 9.62 9.62 9.62 ...

plot(price.x~month, data=mprice.df)


ddd <- data.frame(time = seq(as.Date('1993-01-01'), by = 'months', length = 20), s = rnorm(20)) 

str(ddd)
'data.frame':	20 obs. of  2 variables:
 $ time: Date, format: "1993-01-01" "1993-02-01" ...
 $ s   : num  -1.815 0.287 -1.169 -1.154 1.186 ...

monprice <- data.frame(time = seq(as.Date('2016-01-15'), by = 'months', length = 10), price = mprice[["price"]])  
 
str(monprice) 
'data.frame':	10 obs. of  2 variables:
 $ time : Date, format: "2016-01-15" "2016-02-15" ...
 $ price: num  9.62 9.36 10.63 12.81 14.39 ...
 
tapply(x$price, x$month, FUN=mean,na.rm = TRUE)
 2016-01   2016-02   2016-03   2016-04   2016-05   2016-06   2016-07   2016-08 
 9.621429  9.361429 10.626667 12.810000 14.388571 16.965000 17.982727 18.034444 
  2016-09   2016-10 
18.838000 18.755000 

y<-tapply(x$price, x$month, FUN=mean,na.rm = TRUE)

str(y)
num [1:10(1d)] 9.62 9.36 10.63 12.81 14.39 ...
 - attr(*, "dimnames")=List of 1
  ..$ : chr [1:10] "2016-01" "2016-02" "2016-03" "2016-04" ...

names(y)
 [1] "2016-01" "2016-02" "2016-03" "2016-04" "2016-05" "2016-06" "2016-07"
 [8] "2016-08" "2016-09" "2016-10" 

dim(y) [1] 10

http://stackoverflow.com/questions/16652199/compute-monthly-averages-from-daily-data?rq=1

http://stackoverflow.com/questions/30037722/daily-average-to-monthly-total-in-r?noredirect=1&lq=1

http://stackoverflow.com/questions/13671450/monthly-average-of-working-days-data?rq=1

http://stackoverflow.com/questions/36205472/calculating-monthly-averages-in-r-with-a-large-dataset-spanning-several-years?rq=1

# I want only the rows where the variable (col) month price is not NA as these are the average price for the month

is.na(x$monthprice)
[1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
 [13]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
# Since we want to remove the NA, we just need to reverse it using a boolean-not operator: "!"
# ! indicates logical negation (NOT)

nzuprice <-x[!is.na(x$monthprice),] 

str(nzuprice)
'data.frame':	10 obs. of  4 variables:
 $ date      : Date, format: "2016-01-31" "2016-02-29" ...
 $ price     : num  9.62 9.5 11.15 NA NA ...
 $ monthprice: num  9.62 9.36 10.63 12.81 14.39 ...
 $ Source    : chr  "" "http://www.carbonnews.co.nz/story.asp?storyID=9539" "http://www.carbonnews.co.nz/story.asp?storyID=9783" "" ...
 
# delete the original prices column and Source column

nzumonprice <-subset(nzuprice, select = c(date,monthprice))

str(nzumonprice)
'data.frame':	10 obs. of  2 variables:
 $ date      : Date, format: "2016-01-31" "2016-02-29" ...
 $ monthprice: num  9.62 9.36 10.63 12.81 14.39 ...

ls() 
[1]      "nzumonprice" "nzuprice"   "x"

plot(nzumonprice,type="l")

png("NZU-monthly2016.png", bg="white", width=720, height=540,pointsize = 16)
#par(mar=c(2.7,2.7,1,1)+0.1)
with(nzuprice,plot(date,monthprice, type='o',las=1,ylim=c(0,20),main="NZU Mean Monthly Prices 2016",ylab='Price in $NZ',xlab='Month')) 
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

png("NZU-source-monthly2016.png", bg="white", width=720, height=540,pointsize = 16)
#par(mar=c(2.7,2.7,1,1)+0.1)
with(x,plot(date,monthprice, type='b',pch=16,col=2,las=1,ylim=c(0,20),main="NZU Mean Monthly Prices 2016",ylab='Price in $NZ',xlab='Month')) 
with(x,points(date,price))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
legend("right",bty='n',bg="white",cex=1.0, legend=c("Actual Prices","Monthly Mean Price") ,pch=c(1,19),lty=c(NA,NA),lwd=c(1,1),col=c(1,2))
mtext(side=1,cex=1,line=-1.3,"Mean monthly prices are plotted on the last day of the month.\nWhich looks inaccurate.\nMaybe display the monthly mean price on the middle of the month.")
dev.off()




write.table(nzumonprice, file = "nzumonprice2016.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)
# worked fine

------------------------------------------------------------

mp <-subset(x, select = c(date,monthprice))

str(mp)
'data.frame':	294 obs. of  2 variables:
 $ date      : Date, format: "2016-01-11" "2016-01-13" ...
 $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ..



# Examples
head(mtcars)
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

aggregate(mtcars$mpg,list(mtcars$gear),mean)
  Group.1        x
1       3 16.10667
2       4 24.53333
3       5 21.38000

aggregate(mpg ~ gear, mtcars, mean)
  gear      mpg
1    3 16.10667
2    4 24.53333
3    5 21.38000

str(airquality)
'data.frame':	153 obs. of  6 variables:
 $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
 $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
 $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
 $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
 $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
 $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

aggregate(airquality$Temp,list(airquality$Month),mean)
  Group.1        x
1       5 65.54839
2       6 79.10000
3       7 83.90323
4       8 83.96774
5       9 76.90000

aggregate(Temp ~ Month, airquality, mean)
  Month     Temp
1     5 65.54839
2     6 79.10000
3     7 83.90323
4     8 83.96774
5     9 76.90000

subset(airquality, select = Ozone:Wind)
    Ozone Solar.R Wind
1      41     190  7.4
2      36     118  8.0
3      12     149 12.6
4      18     313 11.5
5      NA      NA 14.3
6      28      NA 14.9

airq<-subset(airquality, select = Ozone:Wind)
str(airq)
'data.frame':	153 obs. of  3 variables:
 $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
 $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
 $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
 
airq2<-na.omit(airq) 
str(airq2) 
'data.frame':	111 obs. of  3 variables:
 $ Ozone  : int  41 36 12 18 23 19 8 16 11 14 ...
 $ Solar.R: int  190 118 149 313 299 99 19 256 290 274 ...
 $ Wind   : num  7.4 8 12.6 11.5 8.6 13.8 20.1 9.7 9.2 10.9 ...
 - attr(*, "na.action")=Class 'omit'  Named int [1:42] 5 6 10 11 25 26 27 32 33 34 ...
  .. ..- attr(*, "names")= chr [1:42] "5" "6" "10" "11" ...

airqoz<-subset(airquality, select = c(Ozone,Month))

 str(airqoz)
'data.frame':	153 obs. of  2 variables:
 $ Ozone: int  41 36 12 18 NA 28 23 19 8 NA ...
 $ Month: int  5 5 5 5 5 5 5 5 5 5 ...
 
airqoz2<-na.omit(airqoz)
str(airqoz2)
'data.frame':	116 obs. of  2 variables:
 $ Ozone: int  41 36 12 18 28 23 19 8 7 16 ...
 $ Month: int  5 5 5 5 5 5 5 5 5 5 ...
 - attr(*, "na.action")=Class 'omit'  Named int [1:37] 5 10 25 26 27 32 33 34 35 36 ...
  .. ..- attr(*, "names")= chr [1:37] "5" "10" "25" "26" ...
  

# 31/10/2015

u <- read.csv("nzu-price-data-2010-2016.csv", skip=0,header=TRUE, sep=",", colClasses = c("Date","numeric"),na.strings="NA", dec=".", strip.white=TRUE)

str(u)

'data.frame':	80 obs. of  2 variables:
 $ Date: Date, format: "2010-03-31" "2010-04-30" ...
 $ nzu : num  20.5 19.6 17.2 18.1 18.5 ...
 
head(u) 
        Date   nzu
1 2010-03-31 20.47
2 2010-04-30 19.60
3 2010-05-29 17.17
4 2010-06-30 18.11
5 2010-07-31 18.47
6 2010-08-31 19.01

tail(u)
         Date   nzu
75 2016-05-31 14.39
76 2016-06-30 16.96
77 2016-07-31 17.98
78 2016-08-31 18.03
79 2016-09-30 18.84
80 2016-10-31 18.75

u$Date[13]
[1] "2011-03-31"

summary(u)
     Date                 nzu        
 Min.   :2010-03-31   Min.   : 1.600  
 1st Qu.:2011-11-22   1st Qu.: 4.125  
 Median :2013-07-15   Median : 6.975  
 Mean   :2013-07-15   Mean   : 9.692  
 3rd Qu.:2015-03-07   3rd Qu.:17.058  
 Max.   :2016-10-31   Max.   :20.900 
 
svg(filename="NZU-720by540-10-16.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(u[["Date"]],u[["nzu"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
abline(v=c(u$Date[10],u$Date[22],u$Date[34],u$Date[46],u$Date[58],u$Date[70]),h=c(0,5,10,15,20),lty=2,lwd=1,col="darkgray")
lines(u[["Date"]],u[["nzu"]],col=2,lwd=3,type='l',lty=1)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU-price-data-2010-2016' http://bit.ly/29U7i3D")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

png("NZU-1200by900-2016-10.png", bg="white", width=1200, height=900,pointsize = 24)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(u[["Date"]],u[["nzu"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
#axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
#axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
abline(v=c(u$Date[10],u$Date[22],u$Date[34],u$Date[46],u$Date[58],u$Date[70]),h=c(0,5,10,15,20),lty=2,lwd=1,col="darkgray")
lines(u[["Date"]],u[["nzu"]],col="#F32424",lwd=3)
mtext(side=1,cex=1,line=-1.2,"Data: 'NZU-price-data-2010-2016' http://bit.ly/29U7i3D")
mtext(side=3,cex=2, line=-2.5,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

nzudata <- read.csv("nzu-price2010-2015.csv", skip=7,header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

str(nzudata)
'data.frame':	70 obs. of  7 variables:
 $ Date   : Factor w/ 70 levels "2010/03/31","2010/04/30",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ Year   : int  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
 $ Month  : int  3 4 5 6 7 8 9 10 11 12 ...
 $ Decimal: num  2010 2010 2010 2010 2010 ...
 $ nzu    : num  20.5 19.6 17.2 18.1 18.5 ...
 $ otccer : num  22.2 25.8 22.3 23.2 21 ...
 $ otceru : num  NA NA NA NA NA NA NA NA NA NA ...
 
# format month to date format
nzudata[["Date"]]<-as.Date(nzudata[["Date"]]) 

str(nzudata)
'data.frame':	70 obs. of  5 variables:
 $ Date   : Date, format: "2010-03-31" "2010-04-30" ...
 $ Year   : int  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
 $ Month  : int  3 4 5 6 7 8 9 10 11 12 ...
 $ Decimal: num  2010 2010 2010 2010 2010 ...
 $ Price  : num  20.5 19.6 17.2 18.1 18.5 ..


head(nzudata)
        Date Year Month  Decimal   nzu   otccer otceru
1 2010-03-31 2010     3 2010.167 20.47 22.15157     NA
2 2010-04-30 2010     4 2010.250 19.60 25.76645     NA
3 2010-05-29 2010     5 2010.333 17.17 22.28748     NA
4 2010-06-30 2010     6 2010.417 18.11 23.17062     NA
5 2010-07-31 2010     7 2010.500 18.47 20.97113     NA
6 2010-08-31 2010     8 2010.583 19.01 24.58723     NA


attach(nzudata)

summary(nzudata)
     Date                 Year          Month           Decimal    
 Min.   :2010-03-31   Min.   :2010   Min.   : 1.000   Min.   :2010  
 1st Qu.:2011-09-07   1st Qu.:2011   1st Qu.: 4.000   1st Qu.:2012  
 Median :2013-02-14   Median :2013   Median : 7.000   Median :2013  
 Mean   :2013-02-13   Mean   :2013   Mean   : 6.643   Mean   :2013  
 3rd Qu.:2014-07-23   3rd Qu.:2014   3rd Qu.: 9.750   3rd Qu.:2014  
 Max.   :2015-12-31   Max.   :2015   Max.   :12.000   Max.   :2016  
                                                                    
      nzu             otccer           otceru     
 Min.   : 1.600   Min.   : 0.630   Min.   :0.070  
 1st Qu.: 3.675   1st Qu.: 1.871   1st Qu.:0.130  
 Median : 6.525   Median : 6.694   Median :0.150  
 Mean   : 8.969   Mean   :10.864   Mean   :0.193  
 3rd Qu.:15.703   3rd Qu.:21.356   3rd Qu.:0.240  
 Max.   :20.900   Max.   :25.766   Max.   :0.600  
                  NA's   :22       NA's   :40       


#nzuts<-ts(price, frequency = 12, start = c(2010, 1))
#str(nzuts) 
#Time-Series [1:72] from 2010 to 2016: 21.7 21.7 20.1 19.5 17.3 ...



png("NZU-NZ-emission-unitv2.png", bg="white", width=650, height=487,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
with(nzudata, plot(Decimal,nzu,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1))
#axis(side=1, tck=0.01, las=0,tick=TRUE)
#axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
#box()
with(nzudata,lines(Decimal,nzu,col="#CC0000",lwd=1))
with(nzudata,points(Decimal,nzu,col="#CC0000",pch=16))
mtext(side=1,cex=0.9,line=-1.1,"Data: https://www.commtrade.co.nz \n http://www.carbonforestservices.co.nz/carbon-prices.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit (NZU) Price 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()

#F32424

png("NZU-NZ-emission-unitv3.png", bg="white", width=650, height=487,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,Price,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
#axis(side=1, tck=0.01, las=0,tick=TRUE)
#axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
#box()
lines(Decimal,Price,col="#F32424",lwd=2)
#points(month,price,col="#F32424",pch=19)
mtext(side=1,cex=0.9,line=-1.1,"Data: https://www.commtrade.co.nz \n http://www.carbonforestservices.co.nz/carbon-prices.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit (NZU) Price 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()


svg(filename="NZU-NZ-emission-unit-720by540-v1.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,Price,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,Price,col="#F32424",lwd=3)
#points(Decimal,Price,col="#F32424",pch=19)
mtext(side=1,cex=0.9,line=-1.1,"Data: https://www.commtrade.co.nz \n http://www.carbonforestservices.co.nz/carbon-prices.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit (NZU) Price 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()

svg(filename="NZU-NZ-emission-unit-720by540-v2.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,Price,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,Price,col="#F32424",lwd=3)
mtext(side=1,cex=0.9,line=-1.1,"Data: https://www.commtrade.co.nz \n http://www.carbonforestservices.co.nz/carbon-prices.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()


svg(filename="NZU-NZ-emission-unit-720by540.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,Price,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,Price,col="#F32424",lwd=3)
mtext(side=1,cex=1,line=-1.2,"Data: 'NZU-price-data-2010-2015', https://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()

NZU-price-data-2010-2015 https://bit.ly/1S6fPka

ls()
[1] "mypalette" "nzu"   
mypalette

--------------------------------------------------------------------------------
22/05/2016 update to 30/04/2016

getwd()
[1] "/home/simon/r/nzu"

rm(nzu)
ls()
[1] "u"
rm(u)


nzu <- read.csv("nzu-price-2010-2016.csv", skip=0,header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

str(nzu)
'data.frame':	74 obs. of  5 variables:
 $ Date       : Factor w/ 74 levels "2010/03/31","2010/04/30",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ Year       : int  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
 $ Month      : int  3 4 5 6 7 8 9 10 11 12 ...
 $ Decimaldate: num  2010 2010 2010 2010 2010 ...
 $ Nzuprice   : num  20.5 19.6 17.2 18.1 18.5 ...
# no problem with data phew!
 
nzu[["Date"]]<-as.Date(nzu[["Date"]])
# convert factor to date 
str(nzu)
'data.frame':	74 obs. of  5 variables:
 $ Date       : Date, format: "2010-03-31" "2010-04-30" ...
 $ Year       : int  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
 $ Month      : int  3 4 5 6 7 8 9 10 11 12 ...
 $ Decimaldate: num  2010 2010 2010 2010 2010 ...
 $ Nzuprice   : num  20.5 19.6 17.2 18.1 18.5 ...

attach(nzu)

svg(filename="NZU-NZ-emission-unit-720by540-2016-04.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Nzuprice,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Date,Nzuprice,col="#F32424",lwd=3)
mtext(side=1,cex=1,line=-1.2,"Data: https://ethercalc.org/nz-emission-unit-prices-2010-2016")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off() 
# works fine

png("NZU-800by600-2016-04.png", bg="white", width=800, height=600,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Nzuprice,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Date,Nzuprice,col="#F32424",lwd=3)
mtext(side=1,cex=1,line=-1.2,"Data: https://ethercalc.org/nz-emission-unit-prices-2010-2016")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()

png("NZU-560by420-2016-04.png", bg="white", width=560, height=420,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Nzuprice,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Date,Nzuprice,col="#F32424",lwd=3)
mtext(side=1,cex=1,line=-1.2,"Data: https://ethercalc.org/nz-emission-unit-prices-2010-2016")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()
------------------------------------------------------------------------------------
# using the https://ethersheet.org/s/new-zealand-emission-unit-prices-2010-2016 data but has problems

nzu <- read.csv("c7368119-452d-4760-b338-ae11b5342f46.csv", skip=0,header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
str(nzu)
'data.frame':	174 obs. of  26 variables:
 $ Date       : Factor w/ 75 levels "","2010/03/31",..: 2 3 4 5 6 7 8 9 10 11 ...
 $ Year       : int  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
 $ Month      : int  3 4 5 6 7 8 9 10 11 12 ...
 $ Decimaldate: num  2010 2010 2010 2010 2010 ...
 $ Nzuprice   : num  20.5 19.6 17.2 18.1 18.5 ...
 $ X          : logi  NA NA NA NA NA NA ...
 # slight problem with extra 21 extra columns and 99 extra rows
subset out the extra 21 extra columns and 99 extra rows
str(nzu[1:75,1:5])
'data.frame':	75 obs. of  5 variables:
 $ Date       : Factor w/ 75 levels "","2010/03/31",..: 2 3 4 5 6 NA NA NA NA NA ...
 $ Year       : int  2010 2010 2010 2010 2010 NA NA NA NA NA ...
 $ Month      : int  3 4 5 6 7 NA NA NA NA NA ...
 $ Decimaldate: num  2010 2010 2010 2010 2010 ...
 $ Nzuprice   : num  20.5 19.6 17.2 18.1 18.5 ...

u<-(nzu[1:75,1:5]) 
str(u) 
'data.frame':	75 obs. of  5 variables:
 $ Date       : Factor w/ 75 levels "","2010/03/31",..: 2 3 4 5 6 NA NA NA NA NA ...
 $ Year       : int  2010 2010 2010 2010 2010 NA NA NA NA NA ...
 $ Month      : int  3 4 5 6 7 NA NA NA NA NA ...
 $ Decimaldate: num  2010 2010 2010 2010 2010 ...
 $ Nzuprice   : num  20.5 19.6 17.2 18.1 18.5 ...
 
u[["Date"]]<-as.Date(u[["Date"]])  
str(u)
'data.frame':	75 obs. of  5 variables:
 $ Date       : Date, format: "2010-03-31" "2010-04-30" ...
 $ Year       : int  2010 2010 2010 2010 2010 NA NA NA NA NA ...
 $ Month      : int  3 4 5 6 7 NA NA NA NA NA ...
 $ Decimaldate: num  2010 2010 2010 2010 2010 ...
 $ Nzuprice   : num  20.5 19.6 17.2 18.1 18.5 ...

str(u[["Date"]])
Date[1:75], format: "2010-03-31" "2010-04-30" "2010-05-29" "2010-06-30" ...

attach(u) 

svg(filename="NZU-NZ-emission-unit-720by540-2016-04.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Nzuprice,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Date,Nzuprice,col="#F32424",lwd=3)
mtext(side=1,cex=1,line=-1.2,"Data: 'NZU-price-data-2010-2015', https://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off() 
# something wrong with the ethernet data, the csv has 175 black rows (,) and 21 extra columns

nzu1[["Date"]]<-as.Date(nzu1[["Date"]]) 
str(nzu1[["Date"]]) 
Date[1:5], format: "2010-03-31" "2010-04-30" "2010-05-29" "2010-06-30" ...
 nzu1[["Date"]] 
[1] "2010-03-31" "2010-04-30" "2010-05-29" "2010-06-30" "2010-07-31"

ls()
nzu


with(nzu1,plot(Date,Nzuprice,ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1))
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
with(nzu1,lines(Date,Nzuprice,col="#F32424",lwd=3))
mtext(side=1,cex=1,line=-1.2,"Data: 'NZU-price-data-2010-2015', https://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")


---------------------------------------------------
cer <- read.csv("HistoricupdatesKyotoProtocolfinancialinformation.csv", skip=4,header=TRUE, sep=",", na.strings="NaN", dec=".", strip.white=TRUE)
str(cer) 
'data.frame':	107 obs. of  11 variables:
 $ Date   : Factor w/ 107 levels "2005/05/14","2005/06/14",..: 107 106 105 104 103 102 101 100 99 98 ...
 $ A      : num  8.3 21.6 21.6 21.6 21.6 21.6 21.6 21.6 21.6 21.6 ...
 $ B      : num  -82.5 -79.2 -77.1 -73.8 -52.3 -52.3 -50.4 -45.6 -42.5 -42.5 ...
 $ C.A.B  : num  90.8 100.8 98.7 95.4 73.9 ...
 $ X      : Factor w/ 31 levels "€0.01","€0.06",..: 5 6 11 9 8 13 16 15 14 12 ...
 $ Y      : num  0.63 0.612 0.602 0.594 0.596 ...
 $ Z.X.Y  : num  0.3 0.42 0.71 0.54 0.52 0.85 1 0.99 0.93 0.82 ...
 $ C.x.Z  : int  27 43 70 51 38 63 72 67 60 53 ...
 $ Year   : int  2014 2014 2014 2013 2013 2013 2013 2013 2013 2013 ...
 $ Month  : int  3 2 1 12 11 10 9 8 7 6 ...
 $ Decimal: num  2014 2014 2014 2014 2014 ...
 
 # the only sensible column heading is 'Date' which I added to the csv. 
 # we want the CER price in $NZ that Treasury/MfE used to calculate the Kyoto liability
 # that is column Z.X.Y

# reformat Date column to Date format 
cer[["Date"]]<-as.Date(cer[["Date"]]) 

str(cer) 
'data.frame':	107 obs. of  8 variables:
 $ Date : Date, format: "2014-03-14" "2014-02-14" ...
 $ A    : num  8.3 21.6 21.6 21.6 21.6 21.6 21.6 21.6 21.6 21.6 ...
 $ B    : num  -82.5 -79.2 -77.1 -73.8 -52.3 -52.3 -50.4 -45.6 -42.5 -42.5 ...
 $ C.A.B: num  90.8 100.8 98.7 95.4 73.9 ...
 $ X    : Factor w/ 31 levels "€0.01","€0.06",..: 5 6 11 9 8 13 16 15 14 12 ...
 $ Y    : num  0.63 0.612 0.602 0.594 0.596 ...
 $ Z.X.Y: num  0.3 0.42 0.71 0.54 0.52 0.85 1 0.99 0.93 0.82 ...
 $ C.x.Z: int  27 43 70 51 38 63 72 67 60 53 ...
 
str(cer[["Date"]])
Date[1:107], format: "2014-03-14" "2014-02-14" "2014-01-14" "2013-12-14" ...

Sys.Date()
[1] "2016-01-12"
# thats yyyy mm dd

attach(cer) 

The following object(s) are masked from 'cer (position 3)':

    A, B, C.A.B, C.x.Z, Date, X, Y, Z.X.Y

max(Z.X.Y) 
[1] 29.24


 
png("CER-NZ-emission-unitv1.png", bg="white", width=650, height=487,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Z.X.Y,ylim=c(0,32),tck=0.01,axes=TRUE,ann=FALSE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
box()
lines(Date,Z.X.Y,col="#000099",lwd=2)
#points(Date,Z.X.Y,col="#000099",pch=19)
text(2005,1,cex=0.9,adj=1,"Data: Historic updates of the Kyoto Protocol financial information \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=1,cex=0.9,line=-1.1,"Data: Historic updates of the Kyoto Protocol financial information \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand CER Prices 2005 - 2014")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off() 

png("CER-NZ-emission-unitv2.png", bg="white", width=667, height=500,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Z.X.Y,ylim=c(0,32),tck=0.01,axes=TRUE,ann=FALSE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
box()
lines(Date,Z.X.Y,col="#000099",lwd=2)
text(2005,1,cex=0.9,adj=1,"Data: Historic updates of the Kyoto Protocol financial information \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=1,cex=0.9,line=-1.1,"Data: Historic updates of the Kyoto Protocol financial information \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand CER Prices 2005 - 2014")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()

png("CER-NZ-emission-unitv3.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Date,Z.X.Y,ylim=c(0,32),tck=0.01,axes=TRUE,ann=FALSE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
box()
lines(Date,Z.X.Y,col="#000099",lwd=2)
text(2005,1,cex=0.9,adj=1,"Data: Historic updates of the Kyoto Protocol financial information \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=1,cex=0.9,line=-1.1,"Data: Ministry for the Environment Sept 2014 \n'Historic updates of the Kyoto Protocol financial information' \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand CER Prices 2005 - 2014")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
dev.off()


png("NZU-CER-prices-v1.png", bg="white", width=650, height=487,pointsize = 16)
par(mar=c(4.5,2.7,1,1)+0.1)
plot(Date,Z.X.Y,ylim=c(0,32),tck=0.01,axes=TRUE,ann=FALSE, type="n",las=1)
#axis(side=1, tck=0.01, las=0,tick=TRUE,labels = TRUE)
#axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
box()
lines(Date,Z.X.Y,col="#000099",lwd=2)
#lines(month,price,col="#CC0000",lwd=2)
#points(Date,Z.X.Y,col="#000099",pch=19)
mtext(side=1,cex=0.9,line=2.9,"Data: 'Historic updates of the Kyoto Protocol financial information' 2014 \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Kyoto Liability \nCarbon Prices 2005 - 2014")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
#legend(Date[105],5,bty='n',bg="white",cex=1.2, c(paste("Price of", c("CERS", "NZUs"))),pch=c(3,4),lty=c(1,1),lwd=c(2,2),col=c("#000099","#CC0000"))
dev.off() 

Date[1]
[1] "2014-03-14"
text(Date[1],30,"Label")
text(Date[50],30,"Label 50")
Date[50] [1] "2010-02-14"
Date[70]
[1] "2008-06-14"
Date[100]
[1] "2005-12-14"
Date[107]
[1] "2005-05-14"
Date[108]
NA

text(Date[107],2,cex=0.8,adj=0,"Data: Historic updates of the Kyoto Protocol financial information 2014 \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")

legend(Date[100],5 ,bty='n',bg="white", c(paste("Price of", c("CERS", "NZUs"))),pch=c(NA,NA),lty=c(1,1),lwd=c(1,1),col=c("#000099","#CC0000"))





max(nzu$Decimal)
1] 2015.917
min(Decimal)
[1] 2005.333

png("NZU-CER-unitpricev1.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,Z.X.Y,ylim=c(0,32),xlim=c(2005.333,2015.917),tck=0.01,axes=TRUE,ann=FALSE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,Z.X.Y,col="#000099",lwd=2,lty=2)
lines(nzu$Decimal,Price,col="#CC0000",lwd=2,lty=1)
text(2005.333,3,cex=0.9,adj=0,"Data: NZU prices; NZU-price-data-2010-2015 \nhttps://bit.ly/1S6fPka\nCERs Ministry for the Environment Sept 2014 \nHistoric updates of the Kyoto Protocol \nfinancial information \nhttp://www.mfe.govt.nz/issues/climate/\ngreenhouse-gas-emissions/net-position/history.html")
#mtext(side=1,cex=0.9,line=-1.1,"Data: Ministry for the Environment Sept 2014 \n'Historic updates of the Kyoto Protocol financial information' \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Carbon Prices 2005 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
legend("right",bty='n',bg="white",cex=1.0, c(paste("Price of", c("CERS (MfE)", "NZUs (spot)"))),pch=c(NA,NA),lty=c(2,1),lwd=c(3,3),col=c("#000099","#CC0000"))
dev.off()

png("NZU-CER-unitpricev2.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,Z.X.Y,ylim=c(0,32),xlim=c(2005.333,2015.917),tck=0.01,axes=TRUE,ann=FALSE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,Z.X.Y,col="#000099",lwd=2,lty=2)
lines(nzu$Decimal,Price,col="#CC0000",lwd=2,lty=1)
text(2005.333,3,cex=0.9,adj=0,"Data: NZU prices; NZU-price-data-2010-2015 \nhttps://bit.ly/1S6fPka\nCERs Ministry for the Environment Sept 2014 \nHistoric updates of the Kyoto Protocol \nfinancial information \nhttp://www.mfe.govt.nz/issues/climate/\ngreenhouse-gas-emissions/net-position/history.html")
#mtext(side=1,cex=0.9,line=-1.1,"Data: Ministry for the Environment Sept 2014 \n'Historic updates of the Kyoto Protocol financial information' \nhttp://www.mfe.govt.nz/issues/climate/greenhouse-gas-emissions/net-position/history.html")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Carbon Prices 2005 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
legend("right",bty='n',bg="white",cex=1.0, c(paste("Price of", c("CERS (MfE)", "NZUs (spot)"))),pch=c(NA,NA),lty=c(2,1),lwd=c(3,3),col=c("#000099","#CC0000"))
dev.off()

_____________________________________________________________________________________
30 January 2016

attach(nzu)

summary(nzu)
      Date                 Year          Month           Decimal    
 Min.   :2010-03-31   Min.   :2010   Min.   : 1.000   Min.   :2010  
 1st Qu.:2011-09-07   1st Qu.:2011   1st Qu.: 4.000   1st Qu.:2012  
 Median :2013-02-14   Median :2013   Median : 7.000   Median :2013  
 Mean   :2013-02-13   Mean   :2013   Mean   : 6.643   Mean   :2013  
 3rd Qu.:2014-07-23   3rd Qu.:2014   3rd Qu.: 9.750   3rd Qu.:2014  
 Max.   :2015-12-31   Max.   :2015   Max.   :12.000   Max.   :2016  
                                                                    
      nzu             otccer           otceru     
 Min.   : 1.600   Min.   : 0.630   Min.   :0.070  
 1st Qu.: 3.675   1st Qu.: 1.871   1st Qu.:0.130  
 Median : 6.525   Median : 6.694   Median :0.150  
 Mean   : 8.969   Mean   :10.864   Mean   :0.193  
 3rd Qu.:15.703   3rd Qu.:21.356   3rd Qu.:0.240  
 Max.   :20.900   Max.   :25.766   Max.   :0.600  
                  NA's   :22       NA's   :40     

display.brewer.pal(3,"Dark2")
col1<-brewer.pal(3, "Dark2")
col1  "#E41A1C" (red) "#377EB8" (steel blue) "#4DAF4A" (grey green)

display.brewer.pal(3,"Dark2") #light green brown purple
display.brewer.pal(3,"Paired") light blue light green
display.brewer.pal(3,"Accent") ligth green light purple light brown
display.brewer.pal(3,"Set1") 
red green blue
col2<-brewer.pal(3, "Set1")
col2[1]  
col2 [1] "#1B9E77" "#D95F02" "#7570B3" aquamarine green, choc brown, steel blue purple

svg(filename="NZ-units-720by540a.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,nzu$nzu,ylim=c(0,29),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,nzu[["nzu"]],col=col2[1],lwd=2,type='l',pch=NA)
lines(Decimal,otccer,col=col2[2],lwd=2,type='l',pch=NA)
lines(Decimal,otceru,col=col2[3],lwd=2,type='l',pch=NA)
text(2010.1,2.5,adj=0,cex=1,"Data: \n'NZU-price-data-2010-2015' \nhttps://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
#leg.txt <- c("NZU price", "CER price", "ERU price")
legend(2014,26,bty='n',bg="white",cex=1.0, legend=leg.txt,pch=c(NA,NA,NA),lty=c(1,1,1),lwd=c(3,3,3),col=c(col2[1], col2[2], col2[3]))
dev.off()

png("NZ-units-720by540a.png", width = 720, height = 540, pointsize = 16, family = "sans", bg = "white")
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,nzu$nzu,ylim=c(0,29),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,nzu[["nzu"]],col=col2[1],lwd=2,type='l',pch=NA)
lines(Decimal,otccer,col=col2[2],lwd=2,type='l',pch=NA)
lines(Decimal,otceru,col=col2[3],lwd=2,type='l',pch=NA)
text(2010.1,2.5,adj=0,cex=1,"Data: \n'NZU-price-data-2010-2015' \nhttps://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
#leg.txt <- c("NZU price", "CER price", "ERU price")
legend(2014.5,25,bty='n',bg="white",cex=1.0, legend=leg.txt,pch=c(NA,NA,NA),lty=c(1,1,1),lwd=c(3,3,3),col=c(col2[1], col2[2], col2[3]))
dev.off()

("#1B9E77", "#D95F02", "#7570B3")

svg(filename="NZ-units-720by540b.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,nzu$nzu,ylim=c(0,29),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,nzu[["nzu"]],col="#1B9E77",lwd=2,type='l',pch=NA)
lines(Decimal,otccer,col="#D95F02",lwd=2,type='l',pch=NA)
lines(Decimal,otceru,col="#7570B3",lwd=2,type='l',pch=NA)
text(2010.1,2.5,adj=0,cex=1,"Data: \n'NZU-price-data-2010-2015' \nhttps://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
leg.txt <- c("NZU price", "CER price", "ERU price")
legend(2014,26,bty='n',bg="white",cex=1.0, legend=leg.txt,pch=c(NA,NA,NA),lty=c(1,1,1),lwd=c(3,3,3),col=c("#1B9E77", "#D95F02", "#7570B3"))
dev.off()

png("NZ-units-720by540b.png", width = 720, height = 540, pointsize = 16, family = "sans", bg = "white")
par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,nzu$nzu,ylim=c(0,29),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,otccer,col=1,lwd=0.5,type='l',pch=NA)
points(Decimal,otccer,col=1,lwd=1,type='o',lty=1,pch=20)
lines(Decimal,otceru,col=1,lwd=0.5,type='l',pch=NA)
lines(Decimal,otceru,col=1,lwd=1,type='p',lty=1)
lines(Decimal,nzu[["nzu"]],col=2,lwd=3,type='l',lty=1)
text(2010.1,2.5,adj=0,cex=1,"Data: \n'NZU-price-data-2010-2015' \nhttps://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
#leg.txt <- c("NZU price", "CER price", "ERU price")
legend(2014.5,25,bty='n',bg="white",cex=1.0, legend=leg.txt,pch=c(NA,20,1),lty=c(1,1,1),lwd=c(3,1,1),col=c(2, 1,1))
dev.off()

svg(filename="NZ-units-720by540b.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  

par(mar=c(2.7,2.7,1,1)+0.1)
plot(Decimal,nzu$nzu,ylim=c(0,29),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=3, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
grid(col="darkgray")
lines(Decimal,otccer,col=1,lwd=0.5,type='l',pch=NA)
points(Decimal,otccer,col=1,lwd=1,type='o',lty=1,pch=20)
lines(Decimal,otceru,col=1,lwd=0.5,type='l',pch=NA)
lines(Decimal,otceru,col=1,lwd=1,type='p',lty=1)
lines(Decimal,nzu[["nzu"]],col=2,lwd=3,type='l',lty=1)
text(2010.1,2.5,adj=0,cex=1,"Data: \n'NZU-price-data-2010-2015' \nhttps://bit.ly/1S6fPka")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2015")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
#leg.txt <- c("NZU price", "CER price", "ERU price")
legend(2014.5,25,bty='n',bg="white",cex=1.0, legend=leg.txt,pch=c(NA,20,1),lty=c(1,1,1),lwd=c(3,1,1),col=c(2, 1,1))
dev.off()


"nzu-price-data-2010-2016.txt"

n<- read.delim("/home/simon/R/nzu2/nzu-price-data-2010-2016.txt", header = TRUE, sep = "\t", quote = "\"",  dec = ".", fill = TRUE, comment.char = "")

str(n)
'data.frame':	74 obs. of  2 variables:
 $ Date: Factor w/ 74 levels "2010/03/31","2010/04/30",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ nzu : num  20.5 19.6 17.2 18.1 18.5 ...
 
n[["Date"]]<-as.Date(n[["Date"]])

str(n)
 'data.frame':	74 obs. of  2 variables:
 $ Date: Date, format: \"2010-03-31\" \"2010-04-30" ...
 $ nzu : num  20.5 19.6 17.2 18.1 18.5
 
head(n)
         Date   nzu
1 2010-03-31 20.47
2 2010-04-30 19.60
3 2010-05-29 17.17
4 2010-06-30 18.11
5 2010-07-31 18.47
6 2010-08-31 19.01

n[74,]
         Date   nzu
74 2016-04-30 12.96

png("NZU-basic-plot-dataframe-v1.png", bg="white", width=720, height=540,pointsize = 16)
plot(n,main="Basic R Plot of Dataframe NZU prices 2010 2016",type='l')
dev.off()

nts <- ts(n[["nzu"]], c(2010, 3), frequency=12)

str(nts)
Time-Series [1:74] from 2010 to 2016: 20.5 19.6 17.2 18.1 18.5 ...

plot(nts)

png("NZU-basic-plot-timeseries-v1.png", bg="white", width=720, height=540,pointsize = 16)
plot(nts,main="Basic R Plot of Timeseries NZU prices 2010 2016")
dev.off()
---------------
New Zealand carbon price (NZU)
http://cf.datawrapper.de/H296a/4/
file name data-H296a.csv
# it is nearly a weekly time series of NZU price from 7/09/12 to 18/09/14
h <- read.csv("data-H296a.csv", skip=0,header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE) 
str(h)
'data.frame':	98 obs. of  2 variables:
 $ Date          : Factor w/ 97 levels "10/01/2014","10/02/2014",..: 90 17 42 68 87 12 36 60 43 97 ...
 $ NZU.spot.price: num  4.65 3.6 3.1 3.7 3.45 3.2 2.85 2.5 2.8 2.65 ...

 head(h)
        Date NZU.spot.price
1  7/09/2012           4.65
2 14/09/2012           3.60
3 21/09/2012           3.10
4 28/09/2012           3.70
5  5/10/2012           3.45
6 12/10/2012           3.20
h[96,]
         Date NZU.spot.price
96 18/09/2014            4.5

h[["Date"]]<-as.Date(h[["Date"]])

str(h)
 'data.frame':	98 obs. of  2 variables:
 $ Date          : Date, format: "7-09-20" "14-09-20" ...
 $ NZU.spot.price: num  4.65 3.6 3.1 3.7 3.45 3.2 2.85 2.5 2.8 2.65 ...
 # the dates are in the 1920s !
 help(as.Date)
 #as.Date(dates, "%m/%d/%y")
rm(h)
h <- read.csv("data-H296a.csv", skip=0,header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE) 
h[["Date"]]<-as.Date(h[["Date"]],"%d/m%/y%")
str(h)
'data.frame':	98 obs. of  2 variables:
 $ Date          : Date, format: NA NA ... # still a problem - need to clean up data in csv file to yyyy-mm-dd
 $ NZU.spot.price: num  4.65 3.6 3.1 3.7 3.45 3.2 2.85 2.5 2.8 2.65 ...


hts <- ts(h[["NZU.spot.price"]], start=c(2012, 41), frequency=52,deltat=1/52)
str(hts)
hts
Time Series:
Start = c(2012, 41) 
End = c(2014, 34) 
# this means the date data is not complete for every week - some weeks are missing e.g. no data for Decemeber 2012

Frequency = 52 
 [1] 4.65 3.60 3.10 3.70 3.45 3.20 2.85 2.50 2.80 2.65 2.75 2.40 2.30 2.35 2.25
[16] 1.60 1.65 1.80 1.90 1.90 2.05 1.85 1.97 1.95 1.88 2.02 2.08 3.65 3.15 3.00
[31] 3.10 3.15 3.30 3.45 3.50 3.10 3.15 3.30 3.25 3.25 3.07 3.07 3.07 3.06 3.10
[46] 3.10 3.07 3.06 3.05 3.00 3.08 3.11 3.16 4.00 4.15 4.10 4.40 4.65 5.20 5.15
[61] 4.80 5.00 4.85 5.05 4.92 4.70 4.35 4.10 4.20 4.17 4.15 4.20 3.95 4.00 3.95
[76] 3.85 3.85 3.82 3.80 3.80 3.90 4.07 4.25 4.22 4.35 4.45 4.35 4.35 4.35 4.35
[91] 4.50 4.50 4.47 4.45 4.45 4.50 4.45 4.40

plot(hts) # plot goes to sept 2014

ls()
[1] "h"   "hts" "n"   "nts"  

rm(h,hts)
# clean up date data to yyyy-mm-dd with Gnumeric

h <- read.csv("data-H296av1.csv", skip=0,header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE) 

str(h)
'data.frame':	98 obs. of  2 variables:
 $ Date          : Factor w/ 97 levels "2012/09/07","2012/09/14",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ NZU.spot.price: num  4.65 3.6 3.1 3.7 3.45 3.2 2.85 2.5 2.8 2.65 ..  

h[["Date"]]<-as.Date(h[["Date"]])

str(h)
'data.frame':	98 obs. of  2 variables:
 $ Date          : Date, format: "2012-09-07" "2012-09-14" ...
 $ NZU.spot.price: num  4.65 3.6 3.1 3.7 3.45 3.2 2.85 2.5 2.8 2.65 ...

h[1,]
        Date NZU.spot.price
1 2012-09-07           4.65
h[98,]
         Date NZU.spot.price
98 2014-09-23            4.4

png("NZU-basic-plot-dataframe-2012-2014.png", bg="white", width=720, height=540,pointsize = 16)
plot(h,ylim=c(0,21),type='l',main="Basic R Plot of Dataframe and Date NZU prices 2012 2014")
dev.off()

png("My-NZU-data-vs-H296a-NZU-data.png", bg="white", width=720, height=540,pointsize = 16)
plot(n,main="My NZU data vs H296a NZU data NZU prices 2010 2016",type='l')
points(h,pch=3,col=2)
lines(h,col=2)
legend("topright",bty='n',bg="white",cex=1, c("My NZU data","H296a NZU data"),pch=c(NA,3),lty=c(1,NA),lwd=c(1,NA),col=c(1,2))
dev.off()
------------------------------------------
the google sheet data just date nzu cer eru but up to 30/06/2016

https://docs.google.com/spreadsheets/d/1KBD-mg53_adOjkmXjCoSqaHQBC3vxQaKMrxf51xkRtA/ 

#download as .csv
getwd()
[1] "/home/simon"
setwd("/home/simon/r/nzu")

ls()

u <- read.csv("nzu-price-data-2010-2016.csv", skip=0,header=TRUE, sep=",", colClasses = c("Date","numeric"),na.strings="NA", dec=".", strip.white=TRUE)

str(u)
'data.frame':	79 obs. of  2 variables:
 $ Date: Date, format: "2010-03-31" "2010-04-30" ...
 $ nzu : num  20.5 19.6 17.2 18.1 18.5 ...

 
head(u) 
        Date   nzu
1 2010-03-31 20.47
2 2010-04-30 19.60
3 2010-05-29 17.17
4 2010-06-30 18.11
5 2010-07-31 18.47
6 2010-08-31 19.01

u$Date[13]
[1] "2011-03-31"

summary(u)
      Date                 nzu        
 Min.   :2010-03-31   Min.   : 1.600  
 1st Qu.:2011-11-15   1st Qu.: 4.100  
 Median :2013-06-30   Median : 6.850  
 Mean   :2013-06-30   Mean   : 9.577  
 3rd Qu.:2015-02-14   3rd Qu.:16.990  
 Max.   :2016-09-30   Max.   :20.900  
 
rm(u)



png("NZU-basic-plot-dataframe-v1.png", bg="white", width=720, height=540,pointsize = 16)
plot(u, main="Basic R Plot of NZU prices 2010 2016")
dev.off()

svg(filename="NZU-720by540-09-16.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(u[["Date"]],u[["nzu"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
abline(v=c(u$Date[10],u$Date[22],u$Date[34],u$Date[46],u$Date[58],u$Date[70]),h=c(0,5,10,15,20),lty=2,lwd=1,col="darkgray")
lines(u[["Date"]],u[["nzu"]],col=2,lwd=3,type='l',lty=1)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU-price-data-2010-2016' http://bit.ly/29U7i3D")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.1,R.version.string)
dev.off()

svg(filename="NZU-CER-ERU-emission-unit-720by540", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(u[["Date"]],u[["nzu"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, type="n",las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
abline(v=c(u$Date[10],u$Date[22],u$Date[34],u$Date[46],u$Date[58],u$Date[70]),h=c(0,5,10,15,20),lty=2,lwd=1,col="darkgray")
lines(u[["Date"]],u[["cer"]],col=4,lwd=0.5,type='l',pch=NA)
points(u[["Date"]],u[["cer"]],col=1,lwd=1,type='o',lty=1,pch=20)
lines(u[["Date"]],u[["eru"]],col=3,lwd=2,type='b',pch=19)
lines(u[["Date"]],u[["eru"]],col=1,lwd=1,type='b',lty=1)
lines(u[["Date"]],u[["nzu"]],col=2,lwd=2,type='l',lty=1)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU-price-data-2010-2016' http://bit.ly/29U7i3D")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
leg.txt <- c("NZU price", "CER price", "ERU price")
legend("bottomleft",bty='n',bg="white",cex=1.0, legend=leg.txt,pch=c(NA,20,1),lty=c(1,1,1),lwd=c(3,1,1),col=c(2, 1,1))
grid()
dev.off()
# the grid lines don't match the dates!

