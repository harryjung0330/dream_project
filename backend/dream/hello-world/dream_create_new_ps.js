const AWS = require("aws-sdk");

const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const USER_TABLE_NAME = process.env.USER_TABLE_NAME;
const PS_EMAIL_VALIDATION_TABLE_NAME = process.env.PS_EMAIL_VALIDATION_TABLE_NAME;



            

const createdPswdMsg = "successfully created pswd";       //0
const unverifiedMsg = "the email is not verified";        //1
const notSendCodeMsg = "code was not sent to the email";  //2
const wrongCodeMsg = "code is not correct";               //3
exports.lambdaHandler = async (event) => {
    
    const email = event.email;
    const code = event.code.toString();
    const password = event.password;
    
    // TODO implement
    var response = {
        statusCode: 200,
        body: {
            status: 0,
            msg: createdPswdMsg
        }
    };
    
    try{
        //returns email, code, timestamp
        var dynamoResult = await getItem(email);
        
        //the email is not in dynamoDB or expired
        if(dynamoResult === undefined || dynamoResult === null || dynamoResult.state === undefined || isExpired(dynamoResult.setTime))
        {
            console.log(email + " : code was not sent or expired");
            response = notSendCodeResponse(response);
        }
        //email was not verified
        else if(dynamoResult.state !== 1)
        {
            console.log(email + " : code not verified");
            response = unverifiedResponse(response);
        }
        //the code is not matching
        else if(dynamoResult.code !== code)
        {
            console.log(email + " : code not matched");
            response = wrongCodeResponse(response);
        }
        //ready to update pswd. code to update ps
        else
        {
            console.log("about to change ps: " + email);
           await changePs(email, password);
        }
        
    }
    catch(e)
    {
        response.statusCode = 500;
        console.log(e);
    }
    
    response = formatResponse(response);
    
    return response;
};

function formatResponse(response)
{
    response.body = JSON.stringify(response.body);
    return response;
}

//modify response msg
function unverifiedResponse(response)
{
    response.body.status = 1;
    response.body.msg = unverifiedMsg;
    return response;
}

function notSendCodeResponse(response)
{
    response.body.status = 2;
    response.body.msg = notSendCodeMsg;
    return response;
}

function wrongCodeResponse(response)
{
    response.body.status = 3;
    response.body.msg = wrongCodeMsg;
    return response;
}

//getItem from psEmailValidation
async function getItem(email)
{
    var params = {
        TableName: PS_EMAIL_VALIDATION_TABLE_NAME,
        Key: {
            email: email
        }
    };
    
    var res = await DOC_CLIENT.get(params).promise();
   
    return  res.Item;
}


//check if took too long to change the pswd
function isExpired(sentTime)
{
    const current_in_min = Math.ceil( Date.now() / 1000);
    
    if((current_in_min > sentTime))
    {
        return true;
    }
    else
    {
        return false;
    }
}

//update user table to change ps

async function changePs(email, ps)
{
    var params = {
        TableName: USER_TABLE_NAME,
        Key:{
            "email": email
        },
        UpdateExpression: "SET #ps = :ps",
        ExpressionAttributeValues: {
            ":ps": ps
        },
        ExpressionAttributeNames: {
            "#ps": "password"
        }
    }

    await DOC_CLIENT.update(params).promise();
}