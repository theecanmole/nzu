
http://stackoverflow.com/questions/6660103/select-date-from-date-column

getwd()
[1] "/home/simon/R/nzu"
dat <- read.table("file.txt", header = TRUE, colClasses = c("character", "numeric", "numeric"))
 str(dat)
'data.frame':	4 obs. of  3 variables:
 $ Date      : chr  "1/01/1985" "16/01/1985" "1/02/1985" "16/02/1985"
 $ Observe   : num  9.8 7.5 5.6 4.6
 $ Simulation: num  7.65 5.74 3.35 3.15

# Convert the Date column to a known Date class, specifying explicitly the format used. See ?strptime for the codes available.

dat$gDate <- as.Date(dat$Date, "%d/%m/%Y")

str(dat)
'data.frame':	4 obs. of  4 variables:
 $ Date      : chr  "1/01/1985" "16/01/1985" "1/02/1985" "16/02/1985"
 $ Observe   : num  9.8 7.5 5.6 4.6
 $ Simulation: num  7.65 5.74 3.35 3.15
 $ gDate     : Date, format: "1985-01-01" "1985-01-16" ...
 
# Create a logical vector to match TRUE/FALSE with month day equal to 16.

as.POSIXlt(dat$Date)$mday == 16

[1] FALSE FALSE FALSE FALSE

dat[["Date"]]

#datesub <- (as.POSIXlt(dat$Date)$mday) == 16

gdatesub <- (as.POSIXlt(dat$gDate)$mday) == 16

gdatesub
[1] FALSE  TRUE FALSE  TRUE

#datesub
[1] FALSE FALSE FALSE FALSE

# Subset the original data with the logical vector, discarding rows where the day is not "16".

#dat16only <- dat[datesub, ]

dat16only <- dat[gdatesub, ]

dat16only
        Date Observe Simulation      gDate
2 16/01/1985     7.5       5.74 1985-01-16
4 16/02/1985     4.6       3.15 1985-02-16

# See ?read.table ?as.Date ?DateTimeClasses ?Comparison and ?Extract