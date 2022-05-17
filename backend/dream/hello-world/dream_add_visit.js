const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();
const parser = require('lambda-multipart-parser');
const jwt = require('jsonwebtoken');


const USER_TABLE_NAME = process.env.USER_TABLE_NAME;
const VISIT_TABLE_NAME = process.env.VISIT_TABLE_NAME
const BUCKET_NAME = process.env.BUCKET_NAME;


//Msgs to send to client
const verifiedMsg = "successfully added visit";         //0
const FailMsg = "failed to add visit";                    //1


exports.lambdaHandler = async (event) => {
    
    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:verifiedMsg
        },
    };
    const parsedResult = await parser.parse(event);
    
    var files = parsedResult.files;
    
    console.log(parsedResult);
    
    
    const writer = getEmail(event.headers.Authorization);
    const title = parsedResult.title;
    const address = parsedResult.address;
    const tags = JSON.parse(parsedResult.tags);
    const detailAddress = parsedResult.detailAddress;
    const content = JSON.parse(parsedResult.content);
    
    try{
        
        const keyNamesForFiles = [];
        var index = 0;
        for(var file of files)
        {
            index++;
            keyNamesForFiles.push(getKeyNameForFile(writer, title, index, file));
        }
        
        var curKey = 0;
        
        for(var cont of content)
        {
            if(cont.type == "image")
            {
                cont.content = getUrl(keyNamesForFiles[curKey]);
                curKey++;
            }
        }
        
        var visit = await addNewVisit(writer, title, address, detailAddress, content, tags);
        await uploadAllPictToS3(files, keyNamesForFiles);
        
        
        response.body.visit = visit;
        
    }
    catch(e)
    {
        console.log(e);
        response = failSignupResponse(response);
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


//get email from token
function getEmail(token)
{
    var payload = jwt.decode(token);
    console.log("payload: " + payload);
    return payload.emailAddress;
}

async function getNickname(writer)
{
    const params ={
        TableName: USER_TABLE_NAME,
        Key:{
            email:writer
        }
    }
    var res = await DOC_CLIENT.get(params).promise();
    console.log("got nickname");
    
    return res.Item.nickname;
}
async function addNewVisit(writer, title, address, detailAddress, content, tags)
{
    const visit = {};
    const writtenTime = (Math.floor(Date.now() / 1000));
    const stringifiedContent = JSON.stringify(content);
    const readView = 0;
    const nickname = await getNickname(writer);
    console.log("nickname is : " + nickname);
    
    
    const params = {
        TableName: VISIT_TABLE_NAME,
        Item:{
            writer: writer,
            title: title,
            address: address,
            detailAddress, detailAddress,
            content: stringifiedContent,
            readView :readView,
            nickname: nickname,
            tags: tags,
            writtenTime: writtenTime,
            is: 1
        },
        ConditionExpression: "attribute_not_exists(writer) AND attribute_not_exists(title)"
    }
    
    
    console.log("params: ");
    console.log(params);
    
    await DOC_CLIENT.put(params).promise();

    console.log("finish uploaded visit");
    
    visit.title = title;
    visit.address = address;
    visit.detailAddress = detailAddress;
    visit.content = content;
    visit.readView = readView;
    visit.nickname = nickname;
    visit.tags = tags;
    
    return visit;
    
}
async function uploadAllPictToS3(files, keyNamesForFiles)
{
    var promList = [];
    var index = 0
    for(var file of files)
    {
        promList.push(putObjectToS3(file, keyNamesForFiles[index] ));
        index++;
    }
    
    await Promise.all(promList);
}
//upload picture to S3------------------------------
//return name of the file
async function putObjectToS3(file, key)
{
    const S3 = new AWS.S3();
    const BUCKET_PARAMS = {
        Bucket: BUCKET_NAME,
        ACL:'public-read'
        };
    
    
    var data = file.content

    //get binary data of file
    BUCKET_PARAMS.Body = data;
    //get file type from file
    BUCKET_PARAMS.Key = key;
    await S3.putObject(BUCKET_PARAMS).promise();
    
    console.log("finished uploading picture")
    return BUCKET_PARAMS.Key;
}

function getUrl(key)
{
    return `https://${BUCKET_NAME}.s3.ap-northeast-2.amazonaws.com/` + key;
}

//get key name for the file to be stored in s3
function getKeyNameForFile( writer,title,orderNumb, file)
{
    const BUCKET_VISIT_FOLDER = 'visit/' + writer + '$' + title + '/';
    
    return BUCKET_VISIT_FOLDER + orderNumb +  "." + getFileTypeFromFile(file);
}

//get file type from file
function getFileTypeFromFile(file)
{
    return file.contentType.split("/")[1];
}