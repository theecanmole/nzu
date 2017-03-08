# Create charts of processed monthly mean NZU prices

# download monthly price data from Github
# make a short 'list' for the url
urldata <- c("https://raw.githubusercontent.com/theecanmole/nzu/master/nzu-month-price-2010-2016.csv")
# define the destination file name and location                 
monthprice <-c("/home/simon/nzu-month-price-2010-2016.csv")

str(monthprice)
 chr "/home/simon/nzu-month-price-2010-2016.csv"
 
download.file(urldata, monthprice)

#trying URL 'https://raw.githubusercontent.com/theecanmole/nzu/master/nzu-month-price-2010-2016.csv'
#Content type 'unknown' length 2522 bytes
#==================================================
#downloaded 2522 bytes

# read in raw prices data from the .csv file in the destination folder
monthprice <- read.csv("/home/simon/nzu-month-price-2010-2016.csv", skip=0, header=TRUE, sep=",", colClasses = c("Date","numeric","numeric"),na.strings="NA", dec=".", strip.white=TRUE)

# examine dataframe
str(monthprice)
'data.frame':	82 obs. of  3 variables:
 $ month  : Date, format: "2010-05-15" "2010-06-15" ...
 $ price  : num  17.6 17.4 18.1 18.4 20.2 ...
 $ decimal: num  2010 2010 2011 2011 2011 ...
 
# create svg format chart
svg(filename="NZUprice-720by540.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2017")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

png("NZU-800by600-2016-11.png", bg="white", width=800, height=600,pointsize = 16)
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE,las=1,col="#F32424",lwd=2,type='l')
grid(col="darkgray",lwd=1)
mtext(side=1,cex=1,line=-1.2,"Data: 'NZU monthly prices' https://github.com/theecanmole/nzu")
mtext(side=3,cex=2, line=-2.5,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

# Use 'decimal' year vector in place of date-formatted month vector
svg(filename="NZUpricedecimal-720by540-11-2016.svg", width = 8, height = 6, pointsize = 16, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(monthprice[["decimal"]],monthprice[["price"]],ylim=c(0,24),tck=0.01,axes=TRUE,ann=TRUE, las=1,col=2,lwd=1,type='l',lty=1)
points(monthprice[["decimal"]],monthprice[["price"]],pch = 20)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=1,line=-1.3,"Data: 'NZU-prices-data-2010-2016' http://bit.ly/2fHbojr")
mtext(side=3,cex=1.7, line=-2.2,expression(paste("New Zealand Unit Prices 2010 - 2016")) )
mtext(side=2,cex=1, line=-1.3,"$NZ Dollars/tonne")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()