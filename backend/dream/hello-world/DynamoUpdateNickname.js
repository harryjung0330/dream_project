var AWS = require("aws-sdk");
AWS.config.update({region: "ap-northeast-2"});

const TABLE_NAME = process.env.VISIT_TABLE_NAME;
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();

exports.lambdaHandler = async (event, context) => {
    const parsedResult = event.Records[0].dynamodb.NewImage;

    console.log("parsedResult is " + parsedResult);
    console.log("table name is " + TABLE_NAME);
    
    var nickname;
    var email;

    var response;
    try {
        
        nickname = parsedResult.nickname.S;
        email = parsedResult.email.S;

        await updateAllVisits(DOC_CLIENT, email, nickname)
        console.log("result is "); 

        response = {
            'statusCode': 200,
            'body': JSON.stringify(
                    {} 
                       )
        }

    } catch (err) {
        console.log(err);
        return err;
    }

    return response
};


async function updateVisit(DOC_CLIENT, writer, title, newNickname){
    var params = {
        TableName: TABLE_NAME,
        Key:{
            "writer": writer,
            "title": title,

        },
        UpdateExpression: "set #nickname = :nickname",
        ExpressionAttributeValues:{
            ":nickname": newNickname
        },
        ExpressionAttributeNames:{
            "#nickname" : "nickname"
        }
        
    }

    return DOC_CLIENT.update(params).promise();

}

async function getAllRecords(DOC_CLIENT, writer)
{
    var params = {
        TableName: TABLE_NAME,
        KeyConditionExpression: "#writer = :writer",
        ExpressionAttributeValues:{
            ":writer":writer
        },
        ExpressionAttributeNames: {
            "#writer": "writer"
        } 
    };

    const res = await DOC_CLIENT.query(params).promise();

    return res.Items;
}

async function updateAllVisits(DOC_CLIENT, writer, newNickname)
{
    const records = await getAllRecords(DOC_CLIENT, writer);

    const promiseList = [];

    for(var record of records)
    {
        promiseList.push(updateVisit(DOC_CLIENT, record.writer, record.title, newNickname));
    }

    await Promise.all(promiseList);

}