NZU-monthly-mean-2010-2016 R code

# R code to create a monthly mean time series vector of prices of the New Zealand Emission Unit (NZU) from raw data of irregular prices webscraped from various web sources. 

# read in raw NZU price data from http://bit.ly/2gmwpy3

rawdata <- read.csv("/home/simon/R/nzu/NZU-weekly-prices-data-2010-2016.csv", skip=0, header=TRUE, sep=",", colClasses = c("Date","numeric","character"),na.strings="NA", dec=".", strip.white=TRUE)

# examine dataframe
str(rawdata)
'data.frame':	373 obs. of  3 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...

# add month variable/factor to data
rawdata$month <- as.factor(format(rawdata$date, "%Y-%m"))

# examine dataframe
str(rawdata)
'data.frame':	373 obs. of  4 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month    : Factor w/ 79 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...

# create new dataframe of monthly mean price 
monthprice<-aggregate(price ~ month, rawdata, mean)

# examine dataframe
str(monthprice)
'data.frame':	79 obs. of  2 variables:
 $ month: Factor w/ 79 levels "2010-05","2010-06",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price: num  17.6 17.4 18.1 18.4 20.1 ...

lengthmonthprice <- length(monthprice[["month"]])

# replace month factor with mid month 15th of month date formatted object 
monthprice[["month"]] = seq(as.Date('2010-05-15'), by = 'months', length = nrow(monthprice)) 
# round mean prices to whole cents
monthprice[["price"]] = round(monthprice[["price"]], digits = 2)

# create 'decimal' year vector as an alternative to the month vector, e.g. May 2010 = 2010.333, Jan 2011 = 2011.000
decimal = seq(2010.333, by = 1/12, length = nrow(monthprice)) 

# examine dataframe
str(monthprice)
'data.frame':	79 obs. of  2 variables:
 $ month: Date, format: "2010-05-15" "2010-06-15" ...
 $ price: num  17.6 17.4 18.1 18.4 20.1 ...

# write new monthly data to a .csv file 
write.table(monthprice, file = "/home/simon/R/nzu/nzu-month-price-2010-2016.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)
# download from short url http://bit.ly/2fHbojr which is the address of the Google sheet I uploaded 

sessionInfo()
R version 3.3.1 (2016-06-21)
Platform: i586-pc-linux-gnu (32-bit)
Running under: Debian GNU/Linux 8 (jessie)

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
[1] tools_3.3.1

url <- c("https://raw.githubusercontent.com/theecanmole/new-zealand-unit-nzu-emission-unit-prices-2010-to-2016/gh-pages/nzu-month-price-2010-2016.csv")
file <- c("/home/simon/R/nzu-month-price-2010-2016.csv")

url
file

url
[1] "https://raw.githubusercontent.com/theecanmole/new-zealand-unit-nzu-emission-unit-prices-2010-to-2016/gh-pages/nzu-month-price-2010-2016.csv"
file
[1] "/home/simon/R/nzu-month-price-2010-2016.csv"

download.file(url, file)
# worked fine the csv file is in /home/simon/R/

urlrawdata <- c("https://raw.githubusercontent.com/theecanmole/new-zealand-unit-nzu-emission-unit-prices-2010-to-2016/gh-pages/NZU-weekly-prices-data-2010-2016.csv")
filerawdata <-c("/home/simon/R/nzu-weekly-prices-data-2010-2016.csv")

download.file(urlrawdata, filerawdata)
# worked fine the csv file is in /home/simon/R/ 
