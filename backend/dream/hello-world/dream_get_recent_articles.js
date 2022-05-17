const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');


const USER_KEYWORDS_TABLE_NAME = process.env.USER_KEYWORDS_TABLE_NAME;
const ARTICLE_TABLE_NAME = process.env.ARTICLE_TABLE_NAME;

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
        TableName: USER_KEYWORDS_TABLE_NAME,
        Key:{
            email: email
        },
        ProjectionExpression: "seenArticle"
    }
    
    const res = await DOC_CLIENT.get(readParams).promise();
    const viewArticle = res.Item.seenArticle;
    
    console.log("viewArticle");
    console.log(viewArticle);
    const aSet = new Set();
    const refinedList = [];
    
    for(var index = viewArticle.length - 1; index >=0 ; index--)
    {
        if(!aSet.has(viewArticle[index]))
        {
            let temp = viewArticle[index];
            console.log("temp");
            console.log(temp);
            aSet.add(temp);
            refinedList.push(JSON.parse(temp));
        }
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
    
    return retList;
}
