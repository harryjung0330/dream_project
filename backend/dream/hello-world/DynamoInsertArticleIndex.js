var AWS = require("aws-sdk");
AWS.config.update({region: "ap-northeast-2"});

const TABLE_NAME = process.env.ARTICLE_INDEX_TABLE_NAME;
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();

exports.lambdaHandler = async (event, context) => {
    const newArticle = event.Records[0].dynamodb.NewImage;

    console.log("parsedResult is ");
    console.log(newArticle);
    console.log("table name is " + TABLE_NAME);
    
    var rawKeywords;
    var title;
    var pictUrl;
    var path;
    var fetchTime;

    var response;
    try {

        var keywords = new Set();
        
        rawKeywords = newArticle.keywords.L;
        title = newArticle.title.S;
        pictUrl = newArticle.pictUrl.S;
        path = newArticle.path.S;
        fetchTime = newArticle.fetchTime.N;
        
        if(title !== undefined)
        {
            const titleKeys = title.split(" ");

            for(var word of titleKeys)
            {
                keywords.add(word);
            }
        }
        
        for(var keyword of rawKeywords)
        {
            keywords.add(keyword.S);
        }

        console.log("keywords: ");
        keywords = Array.from(keywords);
        console.log(keywords);

        //await createAllIfKeywordsDoesNotExist(DOC_CLIENT, keywords);
        await updateAllArticleIndex(DOC_CLIENT, title, fetchTime, pictUrl, path, keywords);

        response = {
            'statusCode': 200,
            'body': JSON.stringify(
                    {} 
                       )
        }

    } catch (err) {
        console.log(err);
        return err;
    }

    return response
};

async function updateAllArticleIndex(DOC_CLIENT, title, fetchTime, pictUrl, path, keywords)
{
    console.log("stringified value: ");
    
    const jsonVal = {
        title: title,
        fetchTime: fetchTime,
        pictUrl: pictUrl,
        path: path
    };

    console.log(jsonVal);

    const stringified = JSON.stringify(jsonVal);

    const promList = [];

    for(var keyword of keywords)
    {
        promList.push(updateArticleIndex(DOC_CLIENT, keyword, stringified));    
    }

    await Promise.all(promList);

}


//add to visit to one document
async function updateArticleIndex(DOC_CLIENT, keyword, stringifiedJson){
    var params = {
        TableName: TABLE_NAME,
        Key:{
            "keyword": keyword

        },
        UpdateExpression: "SET listOfArticle = list_append(listOfArticle, :value)",
        ExpressionAttributeValues:{
            ":value": [stringifiedJson]
        }
        
    }
    try{
        await DOC_CLIENT.update(params).promise();
    }
    catch(e)
    {
        console.log(e);
        await initializeIndexDocument(DOC_CLIENT, keyword);
        await DOC_CLIENT.update(params).promise();
    }

}

//initialize documents if not exist before
async function createAllIfKeywordsDoesNotExist(DOC_CLIENT, keywords)
{
    const promList = [];

    for(var keyword of keywords)
    {
        promList.push(createIfKeywordDoesNotExist(DOC_CLIENT, keyword));
    }

    await Promise.all(promList);
}

async function createIfKeywordDoesNotExist(DOC_CLIENT, keyword)
{
   var doesItExist = await checkIfKeywordExist(DOC_CLIENT, keyword);
   if(!doesItExist)
   {
        await initializeIndexDocument(DOC_CLIENT, keyword);
   }
   return; 
}

//return true if it exist!
async function checkIfKeywordExist(DOC_CLIENT, keyword)
{
    var getItemParams = {
        TableName: TABLE_NAME,
        Key:{
            "keyword": keyword
        },
        ProjectExpression: 'keyword'
    };

    var res = await DOC_CLIENT.get(getItemParams).promise();
    
    console.log("checked result for " + keyword);
    console.log(res);

    if(res.Item === undefined)
    {
        return false;
    }
    else{
        return true;
    }

}

async function initializeIndexDocument(DOC_CLIENT, keyword)
{
    console.log("keyword initialized: " + keyword);
    var dynamodb = new AWS.DynamoDB();
    
    var params = { 
        TableName: TABLE_NAME,
        Item:{
            keyword : keyword,
            listOfArticle: []
        }
    }
    await DOC_CLIENT.put(params).promise();
}

