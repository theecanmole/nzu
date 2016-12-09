## New Zealand Emission Unit Prices in the NZ Emissions Trading Scheme 2010 to 2016. 

This data repository provides a reproducible public domain data series of mean monthly spot prices of the New Zealand emission unit (or "NZU"), the domestic emission unit in the [New Zealand emissions trading scheme](https://en.wikipedia.org/wiki/New_Zealand_Emissions_Trading_Scheme/ "New Zealand emissions trading scheme").      

New Zealand has had an emissions trading scheme since 2009.  Although private sector carbon brokers such as [OMF](https://www.commtrade.co.nz/ "OMF") and [Carbon Forest Services](http://www.carbonforestservices.co.nz/carbon-prices.html "Carbon Forest Services") display current and some historic trading prices for sales of the NZ emission unit (the "NZU"), there is no public data series of the New Zealand carbon price. 

However, NZU prices are frequently displayed online on various 'carbon news' websites. This raw price data has been manually 'web-scraped' and recorded in "NZU-weekly-prices-data-2010-2016.csv". It is also available as a [Google sheet](https://docs.google.com/spreadsheets/d/1Ru2Mu7iSwVhO3Dud4jciNYPM1mryNoMYEYPZNEpYUpA/edit#gid=176935002 "Google sheet"). 

The raw price data is processed with a R script into a mean monthly time series.

### Index of files

1. NZU-weekly-prices-data-2010-2016.csv (web-scraped raw price data, irregular dates, price and url reference)

2. NZU-monthly-mean-2010-2016.r         (R script file of code to process raw price data to monthly mean price)

3. nzu-month-price-2010-2016.csv        (the output data, the processed monthly mean of the raw price data)

4. NZU-charts.r                         (R script file of code to create charts)

5. Licence.txt                          (Public Domain  Dedication and License v1.0 http://opendatacommons.org/licenses/pddl/1.0/)