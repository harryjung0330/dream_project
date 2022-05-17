const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');

const LIKE_VISIT_TABLE = process.env.LIKE_VISIT_TABLE;

//Msgs to send to client
const SuccessMsg = "successfully unliked visit";         //0
const FailMsg = "failed to unlike visit";                    //1

const delimeter = "ㅅㅁㅇ";

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
    const writer = event.writer;
    
    try{
        
        await unlikeVisit(title, writer, email);
    
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

async function unlikeVisit(title, writer, email)
{
    var params = {
        TableName: LIKE_VISIT_TABLE,
        Key:{
            email: email,
            visit: title + delimeter +  writer
        }
    };
    
    await DOC_CLIENT.delete(params).promise();
}
