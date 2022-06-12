const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');



const ARTICLE_INDEX_TABLE_NAME = process.env.ARTICLE_INDEX_TABLE_NAME;
const USER_KEYWORDS_TABLE_NAME = process.env.USER_KEYWORDS_TABLE_NAME;
const ARTICLE_TABLE_NAME = process.env.ARTICLE_TABLE_NAME;
const ARTICLE_FETCHTIME_INDEX = process.env.ARTICLE_FETCHTIME_INDEX;

//Msgs to send to client
const SuccessMsg = "successfully recommended articles";         //0
const FailMsg = "failed to recommend articles";                    //1


exports.lambdaHandler = async (event) => {
    console.log(event);
    if(event.source  === 'DreamWarmLambdas')
    {
        console.log("invoked by scheduler to warm");
        return {};
    }
    
    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:SuccessMsg
        },
    };
    
    const email = getEmail(event.authorization);
    
    
    try{
       var res = await getRecommendedArticles(email);
       console.log("recommend final:")
       console.log(res);
       
       response.body.articles = res;
    }
    catch(e)
    {
        console.log(e);
        response = failResponse(response);
    }
    // TODO implement

    response = formatResponse(response);    
    return response;
};

function formatResponse(response)
{
    response.body = JSON.stringify(response.body);
    return response;
}

//modifying response msg
function failResponse(response)
{
    response.body.status = 1;
    response.body.msg = FailMsg;
    return response;
}


//get email from token
function getEmail(token)
{
    var payload = jwt.decode(token);
    console.log("payload: " + payload);
    return payload.emailAddress;
}

async function getUserKeyWords(email)
{
    const params = {
        TableName: USER_KEYWORDS_TABLE_NAME,
        Key:{
            email: email
        }
    }
    
    const res = await DOC_CLIENT.get(params).promise();
    
    return res.Item;
}

async function getRecommendedArticles(email)
{
    const result = await getUserKeyWords(email);
    //var seenArticles = new Set(result.seenArticle);
    
    if(result === undefined)
    {
        var res = await getArticlesInFetchOrder();
        return res;
    }

    console.log("seen Articles:");
    console.log(result.seenArticle);
    
    const keywords = [];
    
    delete result["seenArticle"];
    delete result["email"];
    
    for(var key in result)
    {
        let temp = {
            keyword: key,
            count: result[key]
        };
        
        keywords.push(temp);
    }
    
    const keywordsToUse = [];
    
    if(keywords.length > 15)
    {
        keywords.sort(function(e1, e2){
            return e2.count - e1.count;
        });
        
        for(var index = 0; index< 15; index++)
        {
            keywordsToUse.push({
                keyword: keywords[index].keyword});          
        }
    }
    else{
        for(var keyword of keywords)
        {
            keywordsToUse.push({
                keyword: keyword.keyword
            })
        }
    }
    
    console.log("sorted keywords");
    console.log(keywords);
    
    console.log("keywordsToUse");
    console.log(keywordsToUse);
    
    const articlesToRec = await getArticles(keywordsToUse);
    
    const retList = [];
    
    for(let article of articlesToRec)
    {

        retList.push(JSON.parse(article));
    
    }

    retList.sort(function(a1, a2){
        return a2.fetchTime - a1.fetchTime;
    });
    
    return retList;
}

async function getArticlesInFetchOrder(){
    const params = {
        TableName: ARTICLE_TABLE_NAME,
        IndexName: ARTICLE_FETCHTIME_INDEX,
        KeyConditionExpression: '#is = :is',
        ExpressionAttributeNames: {
          "#is": "is"
        },
        ExpressionAttributeValues: {
            ":is" : 1
        },
        ScanIndexForward: "false"
    }; 

    var res = await DOC_CLIENT.query(params).promise();

    return res.Items;
}

async function getArticles(keywordsToUse)
{
    const params = {
    "RequestItems": {
        }    
    };
    
    params.RequestItems[`${ARTICLE_INDEX_TABLE_NAME}`] = {
            Keys: keywordsToUse,
            AttributesToGet: [ // option (attributes to retrieve from this table)
            'listOfArticle'
            // ... more attribute names ...
        ]
        };
        
    var res = await DOC_CLIENT.batchGet(params).promise();
    var responseLists  = res.Responses[`${ARTICLE_INDEX_TABLE_NAME}`];
    
    const articleSet = new Set();
    
    for(var list of responseLists)
    {
        for(var article of list.listOfArticle)
        {
            articleSet.add(article);
        }
    }
    
    var ret = Array.from(articleSet);
    
    console.log("article recommend list");
    console.log(ret);
    
    return ret;
    
}
