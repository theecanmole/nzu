# Create charts of processed monthly mean NZU prices

# download monthly price data from Github
# make a short 'list' for the url
urldata <- c("https://raw.githubusercontent.com/theecanmole/nzu/master/nzu-month-price-2010-2016.csv")
# define the destination file name and location                 
monthprice <-c("nzu-month-price.csv")

str(monthprice)
 chr "nzu-month-price.csv"
 
download.file(urldata, monthprice)

#trying URL 'https://raw.githubusercontent.com/theecanmole/nzu/master/nzu-month-price-2010-2016.csv'
#Content type 'unknown' length 2522 bytes
#==================================================
#downloaded 2522 bytes

# read in raw prices data from the .csv file in the destination folder
monthprice <- read.csv("nzu-month-price.csv", skip=0, header=TRUE, sep=",", colClasses = c("Date","numeric","numeric"),na.strings="NA", dec=".", strip.white=TRUE)

# examine dataframe
str(monthprice)
'data.frame':	145 obs. of  3 variables:
 $ month  : Date, format: "2010-05-15" "2010-06-15" ...
 $ price  : num  17.6 17.4 18.1 18.4 20.2 ...
 $ decimal: num  2010 2010 2011 2011 2011 ...

# create svg format chart with 16 pt text font and grid lines via 'grid'

svg(filename="NZUprice-720by540.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.8,line=-1.1,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.5, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2022")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# upload to wikimedia commons 

# these scripts below are just slight variations of the chart

# create svg format chart with 16 pt text font and grid lines via 'abline' for uploading to wikimedia commons
svg(filename="NZUprice-720by540grid.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["month"]],monthprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
plot(monthprice,ylim=c(0,80),tck=0.01,axes=TRUE,ann=FALSE, las=1,col=2,lwd=2,type='l',lty=1)
axis(side=1, tck=0.01, las=0, lwd = 1, at = c(2011:2021), labels = c(2011:2021), tick = TRUE)
box()
abline(v=c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021),col="lightgray",lwd=0.5,lty=2)
abline(h=c(10,20,30,40,50,60,70,80),col="lightgray",lwd=0.5,lty=2)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=2, tck=0.01, las=0,tick=TRUE,labels = TRUE)
mtext(side=1,cex=0.75,line=-1.3,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.2, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2022")) )
mtext(side=2,cex=0.75, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

RKGraphicsDevice 
               2 
         
------------------
# plot the more detailed 'weekly' data
str(rawdata)
'data.frame':	1328 obs. of  4 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month    : Factor w/ 90 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...

svg(filename="NZUpricesweekly-720by540.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(rawdata[["date"]],rawdata[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU weekly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.3, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2022")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

abline(h=c(25,40),col="lightgray",lwd=0.5,lty=2)

# create svg format chart with smaller text font =14
svg(filename="NZUprice-720by540f14.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU weekly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.4, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2022")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

png("NZU-800by600-2017-12.png", bg="white", width=800, height=600,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],ylim=c(0,25),tck=0.01,axes=TRUE,ann=TRUE,las=1,col="#F32424",lwd=2,type='l')
grid(col="darkgray",lwd=1)
mtext(side=1,cex=1,line=-1.2,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.7, line=-2.5,expression(paste("New Zealand Unit Prices 2010 - 2019")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# Use 'decimal' year vector in place of date-formatted month vector black dots
svg(filename="NZUprice-720by540.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=1,type='l',lty=1)
points(monthprice[["decimal"]],monthprice[["price"]],pch = 20)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU-prices-data-2010-2017' http://bit.ly/2fHbojr")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2018")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()
-----------------------------------
11/02/2018  
# plot 2017

svg(filename="NZUprice-720by540-2017.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],xlim=c(2017.042,2018.042),ylim=c(0,24),tck=0.01,axes=FALSE,ann=FALSE, las=1,col=2,lwd=1,type='o',lty=1)
#points(monthprice[["decimal"]],monthprice[["price"]],col=1,xlim=c(2017.042,2018.042))
axis(side=1, tck=0.01, las=0, lwd = 1, at = c(2017.042, 2017.125, 2017.208, 2017.292, 2017.375, 2017.458, 2017.542, 2017.625, 2017.708, 2017.792, 2017.875, 2017.958,2018.042), labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec","Jan"), tick = TRUE)
box()
abline(v=c(2017.042, 2017.125, 2017.208, 2017.292, 2017.375, 2017.458, 2017.542, 2017.625, 2017.708, 2017.792, 2017.875, 2017.958,2018.042),col="darkgray",lwd=1,lty=2)
abline(h=c(5,10,15,20),col="darkgray",lwd=1,lty=2)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
axis(side=2, tck=0.01, las=0,tick=TRUE,labels = TRUE)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2017")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

monthprice[["decimal"]]
