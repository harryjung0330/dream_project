const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');



const ARTICLE_INDEX_TABLE_NAME = process.env.ARTICLE_INDEX_TABLE_NAME;

//Msgs to send to client
const SuccessMsg = "successfully got articles";         //0
const FailMsg = "failed to get articles";                    //1


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
    
    const keyword = event.keyword;
    
    try{
       var res = await getListofArticles(keyword);
       response.body.articles = res;
       console.log(res);
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

async function getListofArticles(keyword)
{
    const params ={
        TableName: ARTICLE_INDEX_TABLE_NAME,
        Key:{
            "keyword": keyword
        },
        ProjectionExpression: "listOfArticle"
    };
    
    const res = await DOC_CLIENT.get(params).promise();
    
    console.log("query result");
    console.log(res);
    
    if(res.Item === undefined)
    {
        return [];
    }
    
    var retList = [];
    var pathSet = new Set();

    for(var index = 0; index < res.Item.listOfArticle.length; index++)
    {
        var article = JSON.parse(res.Item.listOfArticle[index]);
        if(!pathSet.has(article.path))
        {
            pathSet.add(article.path);
            retList.push(article);
        }
    }

    console.log("returning articles: ");
    console.log(retList);
    
    return retList;
    
}