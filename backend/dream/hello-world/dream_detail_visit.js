const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');

const VISIT_TABLE = process.env.VISIT_TABLE_NAME;
const LIKE_VISIT_TABLE = process.env.LIKE_VISIT_TABLE;

//Msgs to send to client
const SuccessMsg = "successfully get visit";         //0
const FailMsg = "failed to get visit";                    //1


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
            msg:SuccessMsg
        },
    };
    console.log("event:");
    console.log(event);
    

    const email = getEmail(event.authorization);
    const title = event.title;
    const writer = event.writer;
    
    try{
        
        const promList = [];
        promList.push(getVisit(title, writer));
        promList.push(getHeartVisit(email));
        promList.push(incrementReadView(title, writer));
        
        const res = await Promise.all(promList);
        const visit = res[0];
        const heartVisits = res[1];
        
        
        putHeart(visit, heartVisits);
        
        console.log(visit);
        
        response.body.visit = visit;
        
    
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

async function getVisit(title, writer)
{
    const params = {
        TableName: VISIT_TABLE,
        Key:{
            title: title,
            writer: writer
        }
    };
    
    const res = await DOC_CLIENT.get(params).promise();
    
    res.Item.content = JSON.parse(res.Item.content);
    return res.Item;
}

async function getHeartVisit(email)
{  
   
   const params = {
       TableName: LIKE_VISIT_TABLE,
       KeyConditionExpression : "#email = :email",
       ExpressionAttributeNames: {
          "#email": "email"
        },
        ExpressionAttributeValues: {
            ":email" : email
        },
       
   } 
   
   var res = await DOC_CLIENT.query(params).promise();
   
   var retSet = new Set();
   
   for(var ret of res.Items)
   {
       retSet.add(ret.visit);
   }
   
   return retSet;
}

function putHeart(visit, heartedVisitsSet)
{
 
    const delimeter = "ㅅㅁㅇ";
        
    var temp = visit.title + delimeter +visit.writer;
                
    if(heartedVisitsSet.has(temp))
    {
        visit.heart = 1;
    }
    else{
        visit.heart = 0;
    }
        
        
    return visit;
}

async function incrementReadView(title, writer)
{
    var params = {
        TableName: VISIT_TABLE,
        Key:{
            title: title,
            writer: writer
        },
        UpdateExpression :"ADD #readView :val",
        ExpressionAttributeNames:{
            "#readView": "readView"
        },
        ExpressionAttributeValues:{
            ":val": 1
        },
        ReturnValues: "UPDATED_NEW"
    };

    await DOC_CLIENT.update(params).promise();
}