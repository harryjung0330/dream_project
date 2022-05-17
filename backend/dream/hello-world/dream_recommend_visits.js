const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');


    
const VISIT_TABLE_NAME = process.env.VISIT_TABLE_NAME;
const SORT_VISIT_INDEX = process.env.SORT_VISIT_INDEX;
const LIKE_VISIT_TABLE = process.env.LIKE_VISIT_TABLE;

//Msgs to send to client
const verifiedMsg = "successfully fetched visit";         //0
const FailMsg = "failed to fetched visit";                    //1

const delimeter = "ㅅㅁㅇ";

exports.lambdaHandler = async (event) => {
    
    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:verifiedMsg
        },
    };
    
    const email = getEmail(event.authorization);
    
    try{
        
        var promList = [];
        promList.push(querySortedVisit());
        promList.push(getHeartVisit(email));
        var res = await Promise.all(promList);
        
        const visits = res[0];                //get queried visits without heart
        const heartedVisitsSet = res[1];
        
        putHeart(visits, heartedVisitsSet);
       
        response.body.visits = visits;
        
        console.log(visits);
        
    
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

function putHeart(visits, heartedVisitsSet)
{
    for(var visit of visits)
        {
                var temp = visit.title + delimeter +visit.writer;
                
                if(heartedVisitsSet.has(temp))
                {
                    visit.heart = 1;
                }
                else{
                    visit.heart = 0;
                }
        }
        
    return visits;
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
   /*   logic for separating!
   for(var ret of retList)
   {
       var tempArr = ret.visit.split(delimeter);
       const writer = tempArr[tempArr.length - 1];
       
       var title = ret.visit.substring(0, ret.visit.length - (delimeter.length + writer.length));

       
       ret.visit = {
           title : title,
           writer: writer 
       };
       
   }
   
   */
   return retSet;
}

//get visits in descending order
async function querySortedVisit()
{
    const params = {
        TableName: VISIT_TABLE_NAME,
        IndexName: SORT_VISIT_INDEX,
        KeyConditionExpression: '#is = :is',
        ExpressionAttributeNames: {
          "#is": "is"
        },
        ExpressionAttributeValues: {
            ":is" : 1
        },
        ScanIndexForward: "false"
    };
    
    var res = await DOC_CLIENT.query(params).promise();
    
    return res.Items;
}
