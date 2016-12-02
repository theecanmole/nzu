# NZU monthly mean

x <- read.csv("/home/simon/R/nzu/NZU-price-2016.csv", skip=6,header=TRUE, sep=",", colClasses = c("Date","numeric","numeric","character"),na.strings="NA", dec=".", strip.white=TRUE)

str(x)
'data.frame':	294 obs. of  4 variables:
 $ date      : Date, format: "2016-01-11" "2016-01-13" ...
 $ price     : num  9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...
 $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ...
 $ Source    : chr  "" "" "" "http://www.carbonnews.co.nz/story.asp?storyID=9354" ...

x$month <- as.factor(format(x$date, "%Y-%m"))

str(x)
'data.frame':	294 obs. of  5 variables:
 $ date      : Date, format: "2016-01-11" "2016-01-13" ...
 $ price     : num  9.75 9.7 9.7 9.73 NA NA NA 9.65 9.6 9.6 ...
 $ monthprice: num  NA NA NA NA NA NA NA NA NA NA ...
 $ Source    : chr  "" "" "" "http://www.carbonnews.co.nz/story.asp?storyID=9354" ...
 $ month     : Factor w/ 10 levels "2016-01","2016-02",..: 1 1 1 1 1 1 1 1 1 1 ...
 
mprice<-aggregate(price ~ month, x, mean)

str(mprice)
'data.frame':	10 obs. of  2 variables:
 $ month: Factor w/ 10 levels "2016-01","2016-02",..: 1 2 3 4 5 6 7 8 9 10
 $ price: num  9.62 9.36 10.63 12.81 14.39 ...
 
mprice[["month"]] = seq(as.Date('2016-01-15'), by = 'months', length = 10) 
mprice[["price"]] = round(mprice[["price"]], digits = 2)

str(mprice)
'data.frame':	10 obs. of  2 variables:
 $ month: Date, format: "2016-01-15" "2016-02-15" ...
 $ price: num  9.62 9.36 10.63 12.81 14.39 ...
 
write.table(mprice, file = "nzu-month-price-2016.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

round(mprice[["price"]], digits = 2)
[1]  9.62  9.36 10.63 12.81 14.39 16.96 17.98 18.03 18.84 18.75

http://www.reuters.com/search/news?blob=NZ+spot+carbon+price
