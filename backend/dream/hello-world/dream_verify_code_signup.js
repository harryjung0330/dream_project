const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const SIGNUP_EMAIL_VALIDATION_TABLE_NAME = process.env.SIGNUP_EMAIL_VALIDATION_TABLE_NAME;

//Msgs to send to client
const verifiedMsg = "the code is successfully verfied";      //0
const wrongCodeMsg = "the code is wrong";                    //2
const emailNotFoundMsg = "did not send code to the email";   //1

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
            msg:verifiedMsg
        },
    };
    
    const email = event.email;
    const code = event.code.toString();
    
    try{
        
        var queryResult = await getItem(email);
        console.log("resulted queryResult: ");
        console.log(queryResult);
        
        if(queryResult === undefined || queryResult === null)
        {
            response = emailNotFoundResponse(response);
            console.log( email + " not found on dynamoDB");
        }
        else{
            
            //check if the code is expired!
           
           if( isExpired(queryResult.setTime))
           {
               response = emailNotFoundResponse(response);
               console.log(email + " is expired");
           }
           else if(code !== queryResult.code){
                //if code is not same, send appropriate msg.
                response = wrongCodeResponse(response);
                console.log(email + " wrong code.");
            }
            else{
                //if code is correct and not expired, save it to DynamoDB
                console.log( email + ": code was correct and not expired");
                var updateResult = await verifyCode(email, code);
                console.log( "update Result is ");
                console.log(updateResult);
            }
        }
        
    }
    catch(e)
    {
        //if there is an error, say it is server-side error
        console.log(email + " : " + e);
        response.statusCode = 500; 
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
function wrongCodeResponse(response)
{
    response.body.status = 2;
    response.body.msg = wrongCodeMsg;
    return response;
}

function emailNotFoundResponse(response)
{
    response.body.status = 1;
    response.body.msg = emailNotFoundMsg;
    return response;
}


//accessing and deleting item from dynamodb
async function getItem(email)
{
    var params = {
        TableName: SIGNUP_EMAIL_VALIDATION_TABLE_NAME,
        Key: {
            email: email
        },
       
    };
    
    var res = await DOC_CLIENT.get(params).promise();
    
    console.log("getItem() result: ");
    console.log(res);

    return  res.Item;
}


//tell dynamoDB that it is verified
async function verifyCode( email, code)
{
   return updateItem(email, code, 1, getExpiringTimestamp());
}

async function updateItem(email, code, state, timestamp)
{
    var params = {
        TableName: SIGNUP_EMAIL_VALIDATION_TABLE_NAME,
        Key:{
            email: email
        },
        UpdateExpression :"set #code = :c, #state = :s",
        ExpressionAttributeNames:{
            "#code": "code",
            "#state": "state",
            "#setTime" : "setTime"
        },
        ExpressionAttributeValues:{
            ":c": code,
            ":s": state,
            ":t": timestamp
        },
        ReturnValues: "UPDATED_NEW"
    };
    
    if(!(timestamp === undefined || timestamp === null) )
    {
        params.UpdateExpression = params.UpdateExpression + ", #setTime = :t";
    }
    
    return DOC_CLIENT.update(params).promise();
    
    
}

//check if it is expired: expiredTime is 3 min
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

function getExpiringTimestamp()
{
    return (Math.floor(Date.now() / 1000) + 180 );
}
