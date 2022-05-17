const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');

const READ_ARTICLE_TABLE_NAME = process.env.READ_ARTICLE_TABLE_NAME;

//Msgs to send to client
const SuccessMsg = "successfully marked read article";         //0
const FailMsg = "failed to mark read article";                    //1


exports.lambdaHandler = async (event) => {
    
    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:SuccessMsg
        },
    };
    
    const email = getEmail(event.authorization);
    const title = event.title;
    const fetchTime = event.fetchTime;

    
    try{
        await markReadArticle(email, title, fetchTime);
        
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

async function markReadArticle(email, title, fetchTime)
{
    
    const stringified = JSON.stringify(
        {
            title: title,
            fetchTime: fetchTime
        })
    const putParams ={
        TableName: READ_ARTICLE_TABLE_NAME,
        Item:{
            email: email,
            article: stringified,
            readTime : (Math.floor(Date.now() / 1000))
        },
        ConditionExpression: "attribute_not_exist(email) AND attribute_not_exist(article)"
    };
    
    
    try{
        await DOC_CLIENT.put(putParams).promise();
    }
    catch(e)
    {
        const updateParams = {
            TableName: READ_ARTICLE_TABLE_NAME,
            Key:{
                email: email,
                article: stringified
            },
            UpdateExpression: "SET readTime = :readTime",
            ExpressionAttributeValues:{
            ":readTime": (Math.floor(Date.now() / 1000))
            }
        };
        await DOC_CLIENT.update(updateParams).promise();
    }
    
}