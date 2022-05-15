const nodemailer = require('nodemailer');

const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const SIGNUP_EMAIL_VALIDATION_TABLE_NAME = process.env.SIGNUP_EMAIL_VALIDATION_TABLE_NAME;


//messages to send
const successMsg = "successfully sent verification code.";                     //0                       
const errorSendingMSg = "error while sending code";                            //1


exports.lambdaHandler = async (event) => {
    
    
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

        var code = generateFourRand();
        const promList = [];
        promList.push(sendMail(code, email));
        promList.push(recordSentCode(email, code));
        await Promise.all(promList);
        

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

//-----------------------------------------------

function formatResponse(response)
{
    response.body = JSON.stringify(response.body);
    return response;
}

function sendCodeErrorResponse(response)
{
    response.body.status = 1;
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
        subject: '인증번호 발송',
        text: '인증번호는 ' + code + " 입니다."
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
        TableName: SIGNUP_EMAIL_VALIDATION_TABLE_NAME,
        Item:{
            email:email,
            code: code,
            state: state, 
            setTime:(Math.floor(Date.now() / 1000 ) + 180)
        }  
    };
    
    return DOC_CLIENT.put(params).promise();
}