const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const jwt = require('jsonwebtoken');

const VISIT_TABLE_NAME = process.env.VISIT_TABLE_NAME;
const LIKE_VISIT_TABLE_NAME = process.env.LIKE_VISIT_TABLE_NAME;

//Msgs to send to client
const SuccessMsg = "successfully get liked visits";         //0
const FailMsg = "failed to get liked visits";                    //1


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
    
    const email = getEmail(event.authorization);

    
    try{
        
        var likedVisits = await getLikedVisit(email);
        var detailResponse = await getVisits(likedVisits);
        console.log(detailResponse);
        
        response.body.visits = detailResponse;
    
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

async function getVisits(likedVisits)
{
    const params = {
    "RequestItems": {
        }    
    };
    
    params.RequestItems[`${VISIT_TABLE_NAME}`] = {
            Keys: likedVisits,
            AttributesToGet: [ // option (attributes to retrieve from this table)
            'title',
            'writer',
            'address',
            'tags'
            // ... more attribute names ...
        ]
        };
    var res = await DOC_CLIENT.batchGet(params).promise();
    
    
    return res.Responses.visit;
}


async function getLikedVisit(email)
{
    const params ={
        TableName: LIKE_VISIT_TABLE_NAME,
        KeyConditionExpression: '#email= :email',
        ExpressionAttributeNames: {
          "#email": "email"
        },
        ExpressionAttributeValues: {
            ":email": email
        }
    }
    
    const res = await DOC_CLIENT.query(params).promise();
    
    const retList = [];
    res.Items.sort(function(v1, v2){
        return v2.likedTime - v1.likedTime; 
    });
    
    const delimeter = "ㅅㅁㅇ";
    
    for(var re of res.Items)
    {
        let tempArr = re.visit.split(delimeter);
        
        let writer = tempArr[tempArr.length - 1];
        let title = re.visit.substring(0, re.visit.length - (delimeter.length + writer.length));
       
        let temp ={
            writer: writer,
            title: title
        };
        
        retList.push(temp);
    }
    
    return retList;
}