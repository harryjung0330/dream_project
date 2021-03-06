const nodemailer = require('nodemailer');

const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const USER_TABLE_NAME = process.env.USER_TABLE_NAME;
const PS_EMAIL_VALIDATION_TABLE_NAME = process.env.PS_EMAIL_VALIDATION_TABLE_NAME;


//messages to send
const successMsg = "successfully sent verification code.";                     //0
const notRegisteredMsg = "email is not registered";                            //1
const errorSendingMSg = "error while sending code";                            //2


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
            status: 0,                                        //0 -> success, 1-> email not registered, 2-> error while sending code
            msg: successMsg
        }
    };
    
    var email = event.email;
    
    var connection;
    try
    {
        if(await checkIfEmailExist(email))
        {
            var code = generateFourRand();
            const promList = [];
            promList.push(sendMail(code, email));
            promList.push(recordSentCode(email, code));
            await Promise.all(promList);
        }
        else{
            response = notRegisteredEmailResponse(response);
        }

    }
    catch(e)
    {
        response = sendCodeErrorResponse(response);
        console.log(e);
    }
    
    

    response = formatResponse(response);    
    //response = stringifyResponse(response);
    
    return response;
};

async function checkIfEmailExist(email)
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
    
    if(res.Item === undefined)
    {
        return false;
    }
    else{
        return true;
    }

}

//-----------------------------------------------

function formatResponse(response)
{
    response.body = JSON.stringify(response.body);
    return response;
}

function notRegisteredEmailResponse(response)
{
    response.body.status = 1;
    response.body.msg = notRegisteredMsg;
    return response;
}

function sendCodeErrorResponse(response)
{
    response.body.status = 2;
    response.body.msg = errorSendingMSg;
    return response;
}

//--------------------------------------------------
async function sendMail(code, reciever )
{
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'buckybucket2022@gmail.com',
            pass: 'Insukkim!6810'
        }
    });

    var mailOptions = {
        from: 'buckybucket2022@gmail.com',
        to: reciever,
        subject: '???????????? ??????',
        text: '??????????????? ' + code + " ?????????."
    };

    return transporter.sendMail(mailOptions );
}

function generateFourRand()
{
    var randNumb = "";
    for(var index = 0; index < 4; index++ )
    {
        randNumb = randNumb + Math.floor(Math.random() * 9);
    }
    
    return randNumb
}

//record that the email was sent!
async function recordSentCode(email, code)
{
    return putItem(email, code, 0);
}

async function putItem(email, code, state)
{
     var params = {
        TableName: PS_EMAIL_VALIDATION_TABLE_NAME,
        Item:{
            email:email,
            code: code,
            state: state, 
            setTime:(Math.floor(Date.now() / 1000 ) + 180)
        }  
    };
    
    return DOC_CLIENT.put(params).promise();
}