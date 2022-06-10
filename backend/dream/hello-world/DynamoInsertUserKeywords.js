var AWS = require("aws-sdk");
AWS.config.update({region: "ap-northeast-2"});

const USER_KEYWORDS_TABLE_NAME = process.env.USER_KEYWORDS_TABLE_NAME;
const ARTICLE_TABLE_NAME = process.env.ARTICLE_TABLE_NAME;
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();

exports.lambdaHandler = async (event, context) => {
    const eventName = event.Records[0].eventName;
    const readArticle = event.Records[0].dynamodb.NewImage;


    console.log("parsedResult is ");
    console.log(readArticle);
    console.log("table names are " + USER_KEYWORDS_TABLE_NAME + " , " + ARTICLE_TABLE_NAME);
    
    var email;
    var article;
    

    var response;
    try {

        var keywords = new Set();
        
        email = readArticle.email.S;
        article = JSON.parse(readArticle.article.S);

        if(eventName === "INSERT")
        {
            console.log("INSERT event");
            await handleInsertCase(DOC_CLIENT, email,article);
        
        }
        else{
            console.log("MODIFY event");
            await handleModifyEvent(DOC_CLIENT, email, article);
        }


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

//functions for handling modify event ------------------------------------
async function handleModifyEvent( DOC_CLIENT, email, article)
{
    console.log("handleModifyEvent started");

    const stringified = JSON.stringify(article);
    
    await addNewSeenArticle(DOC_CLIENT, email, stringified);

    console.log("handleModifyEvent ended");
}

async function addNewSeenArticle(DOC_CLIENT, email, seenArticle)
{
    console.log("addNewSeenArticle started");
    var params = {
        TableName: USER_KEYWORDS_TABLE_NAME,
        Key:{
            "email": email

        },
        UpdateExpression: "SET seenArticle = list_append(seenArticle, :value)",
        ExpressionAttributeValues:{
            ":value": [seenArticle]
        }
        
    };

    try
    {
        await DOC_CLIENT.update(params).promise();
    }
    catch(e)
    {
        console.log(e);
        await initializeUserKeywordDocumentForSeenArticle(DOC_CLIENT, email, seenArticle);
    }

    console.log("addNewSeenArticle ended");
}

async function initializeUserKeywordDocumentForSeenArticle(DOC_CLIENT, email, seenArticle)
{
    console.log("email initialized: " + email);

    var params = { 
        TableName: USER_KEYWORDS_TABLE_NAME,
        Item:{
            email : email,
            seenArticle: [seenArticle]
        }
    }
    await DOC_CLIENT.put(params).promise();
}

//-----------------------------------------------------------------------------------------------

async function handleInsertCase(DOC_CLIENT, email, article)
{
    console.log("handleInsertCase started");
    const title = article.title;
    const fetchTime = article.fetchTime;

    const articleKeywords = await getKeywordsForArticle(DOC_CLIENT, title, fetchTime);
    const stringifiedSeenArticle = JSON.stringify(article);
    const incKeyword = ':n'

    const updateExp = createUpdateExpression(articleKeywords, incKeyword) + " " + "SET seenArticle = list_append(seenArticle, :value)"; 
    
    console.log("updateExp: " + updateExp);

    const expressionAttributeValues = {
        ":n" : 1,
        ":value": [stringifiedSeenArticle]
    };

    const expressionAttributeNames = {};

    var index = 0;
    for(const keyword of articleKeywords)
    {
        index++;
        expressionAttributeNames[`#k${index}`] = keyword;
    }

    console.log("expression attribute names:");
    console.log(expressionAttributeNames);

    var updateParams = {
        TableName: USER_KEYWORDS_TABLE_NAME,
        Key:{
            "email": email
        },
        UpdateExpression: updateExp,
        ExpressionAttributeValues: expressionAttributeValues,
        ExpressionAttributeNames: expressionAttributeNames
        
    };

    try{
        await DOC_CLIENT.update(updateParams).promise();

    }
    catch(e)
    {
        console.log(e);
        await createNewUserKeywords(DOC_CLIENT, email, stringifiedSeenArticle, articleKeywords);
    }

    console.log("handleInsertCase ended");

}

//create update expression for above function
function createUpdateExpression(keywords, incWord)
{   
    var aSet = new Set(keywords);
    keywords = Array.from(aSet);

    var exp = "ADD";
    var index = 0;
    for(var keyword of keywords)
    {
        index++;
        exp += ` #k${index} ${incWord},`;
    }

    return exp.substring(0, exp.length - 1);
}

//create new user keyword document in case document does not exist
async function createNewUserKeywords(DOC_CLIENT, email, stringifiedSeenArticle, keywords)
{
    console.log("createNewUserKeywords started");
    console.log("initialized : " + email);

    var Item = {
        email: email,
        seenArticle: [stringifiedSeenArticle]
    }

    for(var keyword of keywords)
    {
        Item[keyword] = 1;
    }

    var params = { 
        TableName: USER_KEYWORDS_TABLE_NAME,
        Item: Item
    };

    await DOC_CLIENT.put(params).promise();

    console.log("createNewUserKeywords ended");
}

//get keywords of an article
async function getKeywordsForArticle(DOC_CLIENT, title, fetchTime)
{
    console.log("getKeywordsForArticle started");
    const getItemParams = {
        TableName: ARTICLE_TABLE_NAME,
        Key:{
            "title": title,
            "fetchTime": fetchTime
        },
        ProjectExpression: 'keywords'
    };

    const res = await DOC_CLIENT.get(getItemParams).promise();
    console.log("keywords for article are: ");
    console.log(res.Item.keywords);

    console.log("getKeywordsForArticle ended");
    return res.Item.keywords;
}




