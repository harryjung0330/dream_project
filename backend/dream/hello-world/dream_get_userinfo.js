const jwt = require('jsonwebtoken');
var AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const USER_TABLE_NAME = process.env.USER_TABLE_NAME;



//response msgs
const successMsg = "successfuly send user info";        //0
const notFoundMsg = "user not found";         //1

//handler function
exports.lambdaHandler = async (event) => {
    console.log(event);
    if(event.source  === 'DreamWarmLambdas')
    {
        console.log("invoked by scheduler to warm");
        return {};
    }
    
    var email = getEmail(event.authorization);
    

    var response = {
        statusCode: 200,
        body:{
            status: 0,
            msg:successMsg
        }
    };
    
    // TODO implement
    try
    {
        const nickname = await getNickname(DOC_CLIENT, email);
        if(nickname != null && nickname != undefined)
        {
            response.body.nickname = nickname;
            response.body.email = email;
        }
        else{
            throw "no user found";
        }

    }
    catch(e)
    {

        response = notFoundResponse(response);
        console.log(email + " : " +  e);
    }
    

    response = formatResponse(response);
    console.log("response is : " + response.toString());
    
    return response;
};


async function getNickname(DOC_CLIENT, email)
{
    const params = {
        TableName: USER_TABLE_NAME,
        Key:{
            "email": email

        }
        
    };

    const res = await DOC_CLIENT.get(params).promise();
    
    console.log("queried reuslt: ");
    console.log(res);
    
    if(res.Item == undefined)
    {
        return null;
    }

    const nickname = res.Item.nickname;

    return nickname;
}

function formatResponse(response)
{
    response.body = JSON.stringify(response.body);
    return response;
}

//modify response
function notFoundResponse(response)
{
    response.body.status = 1;
    response.body.msg = notFoundMsg;
    response.body.token = null;
    return response;
}

//get email from token
function getEmail(token)
{
    var payload = jwt.decode(token);
    console.log("payload: " + payload);
    return payload.emailAddress;
}
