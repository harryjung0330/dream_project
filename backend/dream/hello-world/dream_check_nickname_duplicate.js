var AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const NICKNAME_TABLE_NAME = process.env.NICKNAME_TABLE_NAME;


//response msgs
const successMsg = "the nickname could be used";        //0
const duplicateMsg = "the nickname cannot be used";         //1

//handler function
exports.lambdaHandler = async (event) => {
    console.log(event);
    
    var nickname = event.nickname;
    
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
        const isDuplicate = await checkIfDuplicate(nickname);
        if(isDuplicate)
        {
            response = duplicateNicknameResponse(response);
        }

    }
    catch(e)
    {

        response = duplicateNicknameResponse(response);
    }
    

    response = formatResponse(response);
    console.log("response is : " + response.toString());
    
    return response;
};

async function checkIfDuplicate(nickname)
{
    const params = {
        TableName: NICKNAME_TABLE_NAME,
        Key:{
            "nickname": nickname

        }
        
    };

    const res = await DOC_CLIENT.get(params).promise();
    
    console.log("query result: ");
    console.log(res);

    if(res.Item === undefined)
    {
        return false;
    }
    else{
        return true;
    }
}

function formatResponse(response)
{
    response.body = JSON.stringify(response.body);
    return response;
}

//modify response
function duplicateNicknameResponse(response)
{
    response.body.status = 1;
    response.body.msg = duplicateMsg;
    return response;
}

