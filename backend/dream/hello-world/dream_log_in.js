const jwt = require('jsonwebtoken');
var AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const USER_TABLE_NAME = process.env.USER_TABLE_NAME;



//expiring time for the token.            
const expiringSeconds = 300000;

//response msgs
const successMsg = "login successful";        //0
const notFoundMsg = "user not found";         //1

//handler function
exports.lambdaHandler = async (event) => {
    console.log(event);
    
    var email = event.email;
    var password = event.pswd;
    
    var response = {
        statusCode: 200,
        body:{
            status: 0,
            msg:successMsg,
            token: null
        }
    };
    
    // TODO implement
    try
    {
        const isRight = await isRightUser(DOC_CLIENT, email, password);
        if(isRight)
        {
            response.body.token = generateToken(email);
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


async function isRightUser(DOC_CLIENT, email, pswd)
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
    
    const queryPswd = res.Item.password;

    if(pswd === queryPswd)
    {
        return true;
    }
    else false;
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

//generate token and store email address of user in the token!
function generateToken(email)
{
    
    const secretKey = "my_secret_key";
    
    const header = {
      algorithm : "HS256",
      expiresIn: expiringSeconds
    };
    
    var token = jwt.sign({emailAddress:email}, secretKey, header);
    
    
    return token;
}

