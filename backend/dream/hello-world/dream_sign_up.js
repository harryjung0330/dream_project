const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const SIGNUP_EMAIL_VALIDATION_TABLE_NAME = process.env.SIGNUP_EMAIL_VALIDATION_TABLE_NAME;
const USER_TABLE_NAME = process.env.USER_TABLE_NAME;;
const NICKNAME_TABLE_NAME = process.env.NICKNAME_TABLE_NAME;;

//Msgs to send to client
const verifiedMsg = "successfully signed up";      //0
const FailMsg = "fail signing up";                    //2


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
    const password = event.pswd;
    const nickname = event.nickname;
    const name = event.name;
    
    try{
        
        const verified = await isVerified(email, code);
        if(!verified)
        {
            throw "not verified email!"
        }
        
        await addNewUser(email, password, name, nickname);
        
        
        
    }
    catch(e)
    {
        response = failSignupResponse(response);
        //if there is an error, say it is server-side error
        console.log(email + " : " + e);
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
function failSignupResponse(response)
{
    response.body.status = 1;
    response.body.msg = FailMsg;
    return response;
}




//accessing and deleting item from dynamodb
async function isVerified(email, code)
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

    if(res.Item === undefined || res.Item.state.toString() !== '1' || res.Item.code !== code)
    {
        return false;
    }
    
    return true;
}

async function addNewUser(email, password, name, nickname)
{
  if(password === undefined || name === undefined || nickname === undefined)
    {
        throw "undefined property exist!";
    }
    
    await DOC_CLIENT.transactWrite({
  TransactItems: [
    {
      Put: { // Write an item to the Cart table
        Item: { // Actual Item
          email: email,
          password: password,
          name: name,
          nickname: nickname
        },
        TableName: USER_TABLE_NAME,
        ConditionExpression: "attribute_not_exists(email)"
      },
    },
    {
      Put: { // Write an item to the Cart table
        Item: { // Actual Item
          nickname: nickname
          
        },
        TableName: NICKNAME_TABLE_NAME,
        ConditionExpression: "attribute_not_exists(nickname)"
      },
    }
    ],
  }).promise();
  
  
}
