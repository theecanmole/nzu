## New Zealand Emission Unit Prices in the NZ Emissions Trading Scheme 2010 to date. 

### Description

This data repository provides a reproducible public domain data series of mean monthly spot prices of the New Zealand emission unit (or "NZU"), the domestic emission unit in the [New Zealand emissions trading scheme](https://en.wikipedia.org/wiki/New_Zealand_Emissions_Trading_Scheme/ "New Zealand emissions trading scheme").      

New Zealand has had an emissions trading scheme since 2009.  Although private sector carbon brokers such as [OMF](https://www.commtrade.co.nz/ "OMF") and [Carbon Forest Services](http://www.carbonforestservices.co.nz/carbon-prices.html "Carbon Forest Services") display current and some historic trading prices for sales of the NZ emission unit (the "NZU"), there is no public data series of the New Zealand carbon price. However, NZU prices are frequently displayed online on various 'carbon news' websites. 

There is a chart of the data at [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:NZU-NZ-emission-unit-720by540.svg).

### Data Preparation

#### Requirements

Data preparation was performed with the [R programming language](https://www.r-project.org/about.html), R version 3.3.3 (2017-03-06) with the [RKWard 0.6.5 IDE](https://rkward.kde.org/) running on an i586-pc-linux-gnu (32-bit), [Debian GNU/Linux 9 (Stretch) MX-17](https://mxlinux.org/index.php) operating system on a Dell Inspiron 6000 laptop.

#### Processing

The raw price data has been manually 'web-scraped' and recorded in the file [NZU-weekly-prices-data.csv](https://github.com/theecanmole/nzu/raw/master/nzu-weekly-prices-data.csv). The raw data is also available as a [Google sheet](https://drive.google.com/uc?id=1PT7HfwDIYE44q-H29GD7Ie2UeW6Ol9ZH&export=downloadprice "Google sheet").

Edited data including the addition of a month column is also available as a [Google sheet](https://drive.google.com/uc?id=1zIfRvgYK-SYXi8-imGjc0Eiozx45YQjl&export=download "Google sheet").

Run the R script [NZU-monthly-mean.r](https://github.com/theecanmole/nzu/blob/master/NZU-monthly-mean.r) from this directory to download and process the raw data into a mean monthly time series. This is then written to a file [nzu-month-price.csv](https://github.com/theecanmole/nzu/raw/master/nzu-month-price.csv). 

This data is also available as a [Google sheet](https://drive.google.com/uc?id=1jsYmImqbvM6WAT-o0IpeQ9mK9QV8JxZC&export=download "Google sheet").

### License

#### ODC-PDDL-1.0

This data package and these datasets and the R scripts are made available under the Public Domain Dedication and License v1.0 whose full text can be found at: http://www.opendatacommons.org/licenses/pddl/1.0/. You are free to share, to copy, distribute and use the data, to create or produce works from the data and to adapt, modify, transform and build upon the data, without restriction.


#### Index of files

1. [nzu-weekly-prices-data.csv](https://github.com/theecanmole/nzu/raw/master/nzu-weekly-prices-data.csv) (web-scraped raw price data, irregular dates, price and url reference)

2. [nzu-edited-raw-prices-data.csv](https://github.com/theecanmole/nzu/raw/master/nzu-edited-raw-prices-data.csv) (raw price data, irregular dates, with added month column, price and url reference)

3. [NZU-monthly-mean.r](https://github.com/theecanmole/nzu/blob/master/NZU-monthly-mean.r)     (R script file of code to process raw price data to monthly mean price)

4. [nzu-month-price.csv](https://github.com/theecanmole/nzu/raw/master/nzu-month-price.csv) (the output data, the processed monthly mean of the raw price data)

5. [NZU-charts.r](https://github.com/theecanmole/nzu/blob/master/NZU-charts.r) (R script file of code to create [charts](https://commons.wikimedia.org/wiki/File:NZU-NZ-emission-unit-720by540.svg))

6. [Licence.txt](https://github.com/theecanmole/nzu/blob/master/Licence.txt) (Public Domain  Dedication and License v1.0 http://opendatacommons.org/licenses/pddl/1.0/)

#### Citation

Theecanmole. (2016). New Zealand emission unit (NZU) monthly prices 2010 to 2016: V1.0.01 [Data set]. Zenodo. http://doi.org/10.5281/zenodo.221328 [![DOI](https://zenodo.org/badge/75373224.svg)](https://zenodo.org/badge/latestdoi/75373224)
