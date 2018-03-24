NZU-monthly-mean (2010-2018) R code

# R code to create a mean monthly time series vector of prices of the New Zealand Emission Unit (NZU) from raw data of irregular prices webscraped from various web sources. 

# download raw prices from Github

urlrawdata <- c("https://raw.githubusercontent.com/theecanmole/nzu/master/NZU-weekly-prices-data.csv")
                 
rawdata <-c("/home/simon/R/nzu/nzu-weekly-prices-data.csv")

download.file(urlrawdata, rawdata)

# or read in raw prices data from a local folder

rawdata <- read.csv("/home/simon/R/nzu/nzu-weekly-prices-data.csv", skip=0, header=TRUE, sep=",", colClasses = c("Date","numeric","character"),na.strings='NA', dec=".", strip.white=TRUE)

# or read in raw NZU price data from http://bit.ly/2gmwpy3

# examine dataframe

str(rawdata)
'data.frame':	503 obs. of  3 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 
# add month variable/factor to data
rawdata$month <- as.factor(format(rawdata$date, "%Y-%m"))

# examine dataframe
str(rawdata)
data.frame:	503 obs. of  4 variables:
 $ date     : Date, format: "2010-05-14" "2010-05-21" ...
 $ price    : num  17.8 17.5 17.5 17 17.8 ...
 $ reference: chr  "http://www.carbonnews.co.nz/story.asp?storyID=4529" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4540" "http://www.carbonnews.co.nz/story.asp?storyID=4588" ...
 $ month    : Factor w/ 93 levels "2010-05","2010-06",..: 1 1 1 2 2 2 3 3 4 4 ...

# create new dataframe of monthly mean price 
monthprice<-aggregate(price ~ month, rawdata, mean)

# examine dataframe
str(monthprice)
'data.frame':	94 obs. of  2 variables:
 $ month: Factor w/ 94 levels "2010-05","2010-06",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ price: num  17.6 17.4 18.1 18.4 20.2 ... 

# create vector that is the number of months and the number of rows in 'monthprice' 
lengthmonthprice <- length(monthprice[["month"]])
lengthmonthprice
[1] 94

# replace month factor with mid-month 15th of month date-formatted object 
monthprice[["month"]] = seq(as.Date('2010-05-15'), by = 'months', length = nrow(monthprice)) 

# round mean prices to whole cents
monthprice[["price"]] = round(monthprice[["price"]], digits = 2)

# create 'decimal' year vector as an alternative to the month vector, e.g. May 2010 = 2010.375, Jan 2011 = 2011.04167
monthprice[["decimal"]] = seq(2010.375, by = 1/12, length = nrow(monthprice)) 

# examine dataframe - again
str(monthprice)
'data.frame':	94 obs. of  3 variables:
 $ month  : Date, format: "2010-05-15" "2010-06-15" ...
 $ price  : num  17.6 17.4 18.1 18.4 20.2 ...
 $ decimal: num  2010 2010 2011 2011 2011 ...
 
# write the new monthly data to a .csv file 

write.table(monthprice, file = "/home/simon/R/nzu/nzu-month-price.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# write the edited raw data to a .csv file 

write.table(rawdata, file = "/home/simon/R/nzu/nzu-edited-raw-prices-data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# upload the csv file to the Google sheets short url http://bit.ly/2fHbojr via Gdrive (https://github.com/prasmussen/gdrive) command line utility 
# open a xterminal window
$ for first upload enter enter "gdrive upload /home/simon/R/nzu/nzu-edited-raw-prices-data.csv" and "gdrive upload /home/simon/R/nzu/nzu-month-price.csv"
$ simon@i6:~ Uploading /home/simon/R/nzu/nzu-edited-raw-prices-data.csv
$ simon@i6:~ Uploaded 1zIfRvgYK-SYXi8-imGjc0Eiozx45YQjl at 16.3 KB/s, total 38.3 KB

$ simon@i6:~ Uploading /home/simon/R/nzu/nzu-month-price.csv
$ simon@i6:~ Uploaded 1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC at 1.2 KB/s, total 2.9 KB

# to download enter "gdrive download 1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC"
# for subsequent updates enter "gdrive update 1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC /home/simon/R/nzu/nzu-month-price.csv"

simon@i6:~
$ gdrive info 1zIfRvgYK-SYXi8-imGjc0Eiozx45YQjl
Id: 1zIfRvgYK-SYXi8-imGjc0Eiozx45YQjl
Name: nzu-edited-raw-prices-data.csv
Path: nzu-edited-raw-prices-data.csv
Mime: text/csv
Size: 38.3 KB
Created: 2018-03-24 18:57:49
Modified: 2018-03-24 18:57:49
Md5sum: e6d243b62b753db1d8289aa2862e3854
Shared: False
Parents: 0AMLhMBA3NXL4Uk9PVA
ViewUrl: https://drive.google.com/file/d/1zIfRvgYK-SYXi8-imGjc0Eiozx45YQjl/view?usp=drivesdk
DownloadUrl: https://drive.google.com/uc?id=1zIfRvgYK-SYXi8-imGjc0Eiozx45YQjl&export=download

simon@i6:~
$ gdrive info 1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC
Id: 1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC
Name: nzu-month-price.csv
Path: nzu-month-price.csv
Mime: text/csv
Size: 2.9 KB
Created: 2018-03-24 17:06:05
Modified: 2018-03-24 17:06:05
Md5sum: b7e9eab4d26786cee1ae68b9a15e5891
Shared: False
Parents: 0AMLhMBA3NXL4Uk9PVA
ViewUrl: https://drive.google.com/file/d/1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC/view?usp=drivesdk
DownloadUrl: https://drive.google.com/uc?id=1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC&export=download.file


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
[1] rkward_0.6.5

loaded via a namespace (and not attached):
[1] tools_3.3.3 