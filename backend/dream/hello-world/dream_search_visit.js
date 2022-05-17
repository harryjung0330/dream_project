const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');

const VISIT_TAG_TABLE = process.env.VISIT_TAG_TABLE_NAME;
const LIKE_VISIT_TABLE_NAME = process.env.LIKE_VISIT_TABLE_NAME;

//Msgs to send to client
const SuccessMsg = "successfully get visits";         //0
const FailMsg = "failed to get visits";                    //1


exports.lambdaHandler = async (event) => {
    
    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:SuccessMsg
        },
    };
    
    const email = getEmail(event.authorization);
    const keyword = event.keyword;
    
    try{
        const promList = [];
        promList.push(searchVisit(keyword));
        promList.push(getHeartVisit(email));
        
        const res = await Promise.all(promList);
        var visits = res[0];
        const heartedVisitsSet = res[1];
        visits = putHeart(visits, heartedVisitsSet);
        
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

async function searchVisit(keyword)
{
    const params = {
        TableName: VISIT_TAG_TABLE,
        Key:{
            tag: keyword
        }
    };
    
    const res = await DOC_CLIENT.get(params).promise();

    if(res.Item === undefined)
    {
        return [];
    }
    
    const listOfVisit = res.Item.listOfVisit
    for(var index = 0; index < listOfVisit.length; index++)
    {
        listOfVisit[index] = JSON.parse(listOfVisit[index]);    
    }
    
   listOfVisit.sort(function(v1, v2){
       return v2.writtenTime - v1.writtenTime;
   });
   
    return listOfVisit;
}

async function getHeartVisit(email)
{  
   
   const params = {
       TableName: LIKE_VISIT_TABLE_NAME,
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

function putHeart(visits, heartedVisitsSet)
{
    const delimeter = "ㅅㅁㅇ"
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