import json
import requests
from article import Article
from bs4 import BeautifulSoup
from datetime import date
from datetime import datetime
import time
import boto3
import os

lambda_client = boto3.client('lambda')

def getTimestamp(year, month, day):
    return int(datetime(year, month, day, 0,0,0).timestamp())

def getCurrentTimestamp():
    today = date.today()

    d1 = today.strftime("%Y/%m/%d")
    temp = d1.split('/')

    year = int(temp[0])
    month = int(temp[1])
    day = int(temp[2])

    return getTimestamp(year, month, day)

def lambda_handler(event, context):
    print("scheduler works!")

    URL = os.environ['URL']
    functName = os.environ['FUNCTION_NAME']
    r = requests.get(URL)
    
    soup = BeautifulSoup(r.content, 'html5lib') # If this line causes an error, run 'pip install html5lib' or install html5lib

    list = soup.find_all("dl", {"class": ["article_list", "article_list pt0"]})

    listOfArticle = []
    currentTimeStamp = getCurrentTimestamp()

    print("current timestamp: ", currentTimeStamp)

    for e in list:
        pictUrl = e.find("a", {"ga-evnt-act": "section:기사리스트_섬네일"}).find("img")["src"]
        path = e.find("a", {"ga-evnt-act": "section:기사리스트_제목"})["href"]
        title = e.find("a", {"ga-evnt-act": "section:기사리스트_제목"}).get_text()
        date1 = e.find("span", {"class": "date"}).get_text()
        date1 = date1[0:10]
        temp = date1.split('.')

        timestamp = getTimestamp(int(temp[0]), int(temp[1]), int(temp[2]))

        if timestamp == currentTimeStamp:
            listOfArticle.append(Article(pictUrl, path, title, timestamp ))


    print("---------------------------")
    time.sleep(0.5)

    for article in listOfArticle:
        URL = article.path
        r = requests.get(URL)
        soup = BeautifulSoup(r.content,'html5lib')  # If this line causes an error, run 'pip install html5lib' or install html5lib
        articleBody = soup.find("div", {"class": "art_txt"})
        print(article.title)
        article.content = articleBody.get_text()
        print(article)
        
        
        lambda_client.invoke(FunctionName=functName, 
                     InvocationType='Event',
                     Payload=json.dumps(article.__dict__))
                     
        print("-----------")


    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
