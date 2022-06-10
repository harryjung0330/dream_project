const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');


const USER_KEYWORDS_TABLE_NAME = process.env.USER_KEYWORDS_TABLE_NAME;
const ARTICLE_TABLE_NAME = process.env.ARTICLE_TABLE_NAME;
const READ_ARTICLE_TABLE_NAME = process.env.READ_ARTICLE_TABLE_NAME;

//Msgs to send to client
const SuccessMsg = "successfully got recent articles";         //0
const FailMsg = "failed to get recent articles";                    //1


exports.lambdaHandler = async (event) => {
    
    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:SuccessMsg
        },
    };
    
    const email = getEmail(event.authorization);
    
    try{
       const res = await getRecentViewArticles(email);
       response.body.articles= res;
        
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

async function getRecentViewArticles(email)
{
    const readParams = {
        TableName: READ_ARTICLE_TABLE_NAME,
        ExpressionAttributeValues: {
            ':e': email
          },
          KeyConditionExpression: 'email = :e'
    }
    
    const res = await DOC_CLIENT.query(readParams).promise();

    if(res.Items == undefined || res.Items == null)
    {
        return [];
    }

    const viewArticle = res.Items
    
    console.log("viewArticle");
    console.log(viewArticle);

    viewArticle.sort(function(a1, a2){
        return a2.readTime - a1.readTime;
    });

    const refinedList = [];
    
    for(var article of viewArticle)
    {
        
            let temp = article.article;
            console.log("temp");
            console.log(temp);
            refinedList.push(JSON.parse(temp));

    }
    
    console.log("refinedList: ");
    console.log(refinedList);
    
    const articles = await getDetailsForArticles(refinedList);
    console.log("articles:");
    console.log(articles);
    
    return articles;
    
}

async function getDetailsForArticles(articleKeys)
{
    const params = {
    "RequestItems": {
        }    
    };
    
    params.RequestItems[`${ARTICLE_TABLE_NAME}`] = {
            Keys: articleKeys,
            AttributesToGet: [ // option (attributes to retrieve from this table)
            'title',
            'fetchTime',
            'pictUrl',
            'path'
            // ... more attribute names ...
        ]
        };
        
    var res = await DOC_CLIENT.batchGet(params).promise();
    const retList = res.Responses[`${ARTICLE_TABLE_NAME}`];
    retList.sort(function(a1, a2)
    {
        a2.fetchTime - a1.fetchTime;
    });

    var aDict = {};
    for(var article of retList)
    {
        aDict[article.fetchTime  + "" + article.title] = article;
    }

    for(var article of articleKeys)
    {
        var temp = aDict[article.fetchTime + "" + article.title];
        if(temp == null || temp == undefined)
        {
            continue;
        }

        article.path = temp.path;
        article.pictUrl = temp.pictUrl
    }
    
    return articleKeys;
}
