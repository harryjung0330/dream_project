var AWS = require("aws-sdk");
AWS.config.update({region: "ap-northeast-2"});

const TABLE_NAME = process.env.VISIT_TAG_TABLE_NAME;
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();

exports.lambdaHandler = async (event, context) => {
    const newVisit = event.Records[0].dynamodb.NewImage;

    console.log("parsedResult is ");
    console.log(newVisit);
    console.log("table name is " + TABLE_NAME);
    
    var rawtags;
    var title;
    var writer;
    var address;
    var writtenTime;

    var response;
    try {

        var keywords = new Set();
        
        rawtags = newVisit.tags.L;
        title = newVisit.title.S;
        writer = newVisit.writer.S;
        address = newVisit.address.S;
        writtenTime = newVisit.writtenTime.N;
        
        if(title !== undefined)
        {
            const titleKeys = title.split(" ");

            for(var word of titleKeys)
            {
                keywords.add(word);
            }
        }
        
        for(var tag of rawtags)
        {
            keywords.add(tag.S);
        }

        console.log("keywords: ");
        keywords = Array.from(keywords);
        console.log(keywords);

        //await createAllIfKeywordsDoesNotExist(DOC_CLIENT, keywords);
        await updateAllVisitTag(DOC_CLIENT, title, writer, address, keywords, writtenTime);

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

async function updateAllVisitTag(DOC_CLIENT, title, writer, address, tags, writtenTime)
{
    console.log("stringified value: ");
    
    const jsonVal = {
        title: title,
        writer: writer,
        address: address,
        tags: tags,
        writtenTime: writtenTime
    };

    console.log(jsonVal);

    const stringified = JSON.stringify(jsonVal);

    const promList = [];

    for(var tag of tags)
    {
        promList.push(updateVisitTag(DOC_CLIENT, tag, stringified));    
    }

    await Promise.all(promList);

}


//add to visit to one document
async function updateVisitTag(DOC_CLIENT, keyword, stringifiedJson){
    var params = {
        TableName: TABLE_NAME,
        Key:{
            "tag": keyword

        },
        UpdateExpression: "SET listOfVisit = list_append(listOfVisit, :value)",
        ExpressionAttributeValues:{
            ":value": [stringifiedJson]
        }
        
    }

    try
    {
        await DOC_CLIENT.update(params).promise();
    }
    catch(e)
    {
        console.log(e);
        await initializeTagDocument(DOC_CLIENT, keyword);
        await DOC_CLIENT.update(params).promise();

    }
}

//initialize documents if not exist before
async function createAllIfKeywordsDoesNotExist(DOC_CLIENT, keywords)
{
    const promList = [];

    for(var keyword of keywords)
    {
        promList.push(createIfKeywordDoesNotExist(DOC_CLIENT, keyword));
    }

    await Promise.all(promList);
}

async function createIfKeywordDoesNotExist(DOC_CLIENT, keyword)
{
   var doesItExist = await checkIfKeywordExist(DOC_CLIENT, keyword);
   if(!doesItExist)
   {
        await initializeTagDocument(DOC_CLIENT, keyword);
   }
   return; 
}

//return true if it exist!
async function checkIfKeywordExist(DOC_CLIENT, keyword)
{
    var getItemParams = {
        TableName: TABLE_NAME,
        Key:{
            "tag": keyword
        },
        ProjectExpression: 'tag'
    };

    var res = await DOC_CLIENT.get(getItemParams).promise();
    
    console.log("checked result for " + keyword);
    console.log(res);

    if(res.Item === undefined)
    {
        return false;
    }
    else{
        return true;
    }

}

async function initializeTagDocument(DOC_CLIENT, keyword)
{
    console.log("tag initialized: " + keyword);
    var dynamodb = new AWS.DynamoDB();
    
    var params = { 
        TableName: TABLE_NAME,
        Item:{
            tag : keyword,
            listOfVisit: []
        }
    }
    await DOC_CLIENT.put(params).promise();
}


