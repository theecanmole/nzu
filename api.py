import requests
from datetime import datetime
from bs4 import BeautifulSoup
import csv

# Performs the HTTP request to the Carbon News Market Updates RSS feed
def getCarbonNews():
    url = "https://www.carbonnews.co.nz/rssfeed.asp?tag=21"
    response = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
    return response.text

# Parses the RSS feed using BeautifulSoup and returns a dictionary of the latest market updates
def getPriceUpdates(): 
    html  = getCarbonNews()
    soup = BeautifulSoup(html, 'html.parser')
    items = soup.find_all('item')
    market_updates = {}
    for item in items:
        if is_market_latest(item.title.text):
            print()
            obj = {
                'price': parsePrice(item.title.text),
                'date': formatDate(item.pubdate.text),
                'url': item.guid.text
            }
            market_updates[obj['date']] = obj
    return market_updates

def is_market_latest(title='blank'): 
    if 'MARKET LATEST' in title: 
        return True
    else:
        return False
    
def formatDate(str):
    date = datetime.strptime(str, '%a, %d %b %Y %H:%M:%S ')
    new_str = date.strftime('%Y/%m/%d')
    return new_str


def parsePrice(title='blank'):
    return title.split('$',1)[1].split("\r",1)[0]

def addDoubleQuotes(str):
    return "\"" + str + "\""

# Gets the old data from the csv file and returns as a dictionary
def getOldData():
    old_dict = {}
    with open("./nzu-edited-raw-prices-data.csv") as csvfile:
        reader = csv.reader(csvfile) # change contents to floats
        for row in reader: # each row is a list
            old_dict[row[0]] =  {  
                'date' : row[0],
                'price': row[1],
                'url': row[2],
                'year_month': row[3],
                'year_week': row[4]
            }
    return old_dict


# Main function of this file, calls all the other functions and updates the csv file 
def doRawPricesUpdate(): 

    old_dict = getOldData()
    new_dict = getPriceUpdates()
    
    new_entries = []
    # if the key is not in the old dict, add it to the new entries list
    for key in new_dict:
        if key not in old_dict:
            new_entries.append(new_dict[key])
    
    # entry dates are str '2020/01/01'
    # we want to add the year_month and year_week to the entry
    # yeah month is formatted: 2020-01
    # yeah week is formatted: 2020-W01
    for entry in new_entries: 
        date = datetime.strptime(entry['date'], '%Y/%m/%d').date()
        entry['year_month'] = datetime.strftime(date, '%Y-%m')
        entry['year_week'] = datetime.strftime(date, '%Y-W%W')
        old_dict[entry['date']] = entry

    # data in the csv file is now in the below format
    # date,price,url,year_month,year_week

    # re-write the csv file with the new data
    # to-do: only write new rows ? 
    # to-do: check that all graphs ect are still working
    with open('./nzu-edited-raw-prices-data.csv', 'w') as csvfile:
        fieldnames = ['date','price','url','year_month','year_week']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        for key in sorted(old_dict.keys()):
            writer.writerow(old_dict[key])
    
doRawPricesUpdate()
