NZU-monthly-mean  R code

# R code to create a mean monthly time series vector of prices of the New Zealand Emission Unit (NZU) from raw data of irregular prices webscraped from various web sources. 

# locate and anchor the location of the working folder
library(here)

set_here()
getwd()
[1] "/home/user/R/nzu"
# or setwd("home/user/R/nzu")
# download raw prices from Github

urlrawdata <- c("https://raw.githubsimoncontent.com/theecanmole/nzu/master/NZU-weekly-prices-data.csv")
                 
download.file(urlrawdata, rawdata)

# or read in raw prices data from a local folder

rawdata <- read.csv("nzu-weekly-prices-data.csv", skip=0, header=TRUE, sep=",", colClasses = c("Date","numeric","character"),na.strings='NA', dec=".", strip.white=TRUE)

# examine dataframe

str(rawdata)
'data.frame':	1516 obs. of  3 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 
# add month variable/factor to data
rawdata$month <- as.factor(format(rawdata$date, "%Y-%m"))

# examine dataframe
str(rawdata)
'data.frame':	1516 obs. of  4 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month    : Factor w/ 152 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...

# create new dataframe of monthly mean price 
monthprice<-aggregate(price ~ month, rawdata, mean)

# examine dataframe
str(monthprice)
'data.frame':	152 obs. of  2 variables:
 $ month: Factor w/ 149 levels "2010-05","2010-06",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price: num  17.6 17.4 18.1 18.4 20.2 ...
 
# create a vector that is the number of months and the number of rows in 'monthprice' 
lengthmonthprice <- length(monthprice[["month"]])
lengthmonthprice
[1] 152

# replace month factor with mid-month 15th of month date-formatted object 
monthprice[["month"]] = seq(as.Date('2010-05-15'), by = 'months', length = nrow(monthprice)) 

# round mean prices to whole cents
monthprice[["price"]] = round(monthprice[["price"]], digits = 2)

# create 'decimal' year vector as an alternative to the month vector, e.g. May 2010 = 2010.375, Jan 2011 = 2011.04167
monthprice[["decimal"]] = seq(2010.375, by = 1/12, length = nrow(monthprice))

# examine dataframe - again
str(monthprice)
'data.frame':	152 obs. of  3 variables:
 $ month  : Date, format: "2010-05-15" "2010-06-15" ...
 $ price  : num  17.6 17.4 18.1 18.4 20.2 ...
 $ decimal: num  2010 2010 2011 2011 2011 ...

# write the new monthly data to a .csv file 

write.table(monthprice, file = "nzu-month-price.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the edited tidy data to a .csv file 

write.table(rawdata, file = "nzu-edited-raw-prices-data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# add week variable/factor to data
rawdata$week <- as.factor(format(rawdata$date, "%Y-%m-%U"))

# create new dataframe of weekly mean price 
weeklymeanprice <- aggregate(price ~ week, rawdata, mean) 

str(weeklymeanprice)
'data.frame':	609 obs. of  2 variables:
 $ week : Factor w/ 600 levels "2010-05-19","2010-05-20",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price: num  17.8 17.5 17.5 17 17.8 ...  

head(weeklymeanprice,2)
        week price
1 2010-05-19 17.75
2 2010-05-20 17.50

# add   week date-formatted object 
weeklymeanprice[["weekended"]] = seq(as.Date('2010-05-19'), by = 'weeks', length = nrow(weeklymeanprice))  
head(weeklymeanprice,2)
        week price  weekended
1 2010-05-19 17.75 2010-05-19
2 2010-05-20 17.50 2010-05-26

str(weeklymeanprice)
'data.frame':	609 obs. of  3 variables:
 $ week     : Factor w/ 600 levels "2010-05-19","2010-05-20",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ weekended: Date, format: "2010-05-19" "2010-05-26" ...
 tail(weeklymeanprice,2)
          week  price  weekended
608 2022-12-49 81.800 2022-01-05
609 2022-12-50 81.624 2022-01-12 

svg(filename="NZU-weekly-mean-price-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(weeklymeanprice[["weekended"]],weeklymeanprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col="red",lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.5, line=-2.2,expression(paste("New Zealand Mean Weekly Unit Prices 2010 - 2022")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

png("NZU-weekly-mean-price2-560by420-v1.png", bg="white", width=560, height=420,pointsize = 12)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(weeklymeanprice[["weekended"]],weeklymeanprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col="red",lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.5, line=-2.2,expression(paste("New Zealand Weekly Unit Prices 2010 - 2022")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# write the new monthly data to a .csv file 
write.table(weeklymeanprice, file = "weeklymeanprice.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)
weeklymeanprice <- read.csv(file = "weeklymeanprice.csv")


sessionInfo()
R version 3.3.3 (2017-03-06)
gdrive info 1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC
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
[1] rkward_0.6.5

loaded via a namespace (and not attached):
[1] tools_3.3.3
