const language = require('@google-cloud/language');
const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();

const CREDENTIALS = JSON.parse(JSON.stringify({
    "type": "service_account",
    "project_id": "sendemail-345213",
    "private_key_id": "05f28db13e4e31659ca45b0b044364d6faa9ba6d",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCbvnJOhitTOMyI\nm34y0QkIxo4NPzyQT2ilbKwBd9UR1n2ExDly4bGgJOmOc4e+wYlZPT/AtUDBMKvk\nUBh2gr9YcIFWDGNy9sVu7kvP9un3ocSBG/asw1m6cQ7Q1wmDt4zd7G+Q7ooOqW6t\nANCQLzeqK+32MfP4EDOmGUUFFxNckehsIoOC1vuvqIuH6OVp+MGJk8tNWpgUTFOd\nkdARoMRmLy3gh6r+SsjeewLvsrSsEswkcYbvbsTO45nAqCBZFTDeJO5u2G9L7FKA\n7cntgkAjrMjoZ1dwWJoNOc+n8S9XhtSMXl0V24KGZTXCeDg3nad22/4dwqcDdm/S\nF6jFHKgPAgMBAAECggEAL/rmACb5ZfQTnuo4YLNhUyDIVnBq2hJ8rKnj+7fNHmez\n15kUEb5SGIIGqeoRocTB6Yoi/91XC61Q5099mdUB2d8fGUFLyfkYLeqf1Hu+7Jkb\njqLsxaCRHg0CgXgd6EQ904ipfj7erVGpVQbxOdoyDezmrHgLLxrerocOalkHj/aw\nL1PQXrpHJ1hYrQvaI5zIOyZGG4gLG5UHoLYirBDOoWTHmJCaQyBJpLGKDDFkVKH2\n1vLzVWR+5xK7cf+VUCVpAJRaMKFfNPJsDJQP0mopzLxFLtCWzPLCbnf5brhxgrfT\n2ev5bSYVe88Le5ZKJ+JBuRcwNs0CJAA1Gr4vSO+bYQKBgQDSWkbkP6GMnbvZv8Tl\n4nzGAK1Lf31Urigtko7A91y73RbwI9twoBeuGQNP8ynlSboGdYXIDRFg6yUS47jf\nHZ69ocNKG1hi8ZtUe/lh3JVQ6kXkX2UcF8jK6t1NxXh2ZbM70+/doGBpVX09k7vR\nt3kTHaiYN/10eC/ml1JHo/kmhwKBgQC9in24o96OHUQ1WjpGFcMxX3uLRNjktoCe\nLBvKu2DvEoxmCnjQjEUmholj8hF2rYHizy4oUq6wDGZFRnDSuIZI9l+G/6SrOTO9\nmDaqK9TqrG4LhhHomugeCUAuuTBEwopNNEmiUDwMNWNTNrOaovsl0QLLIZOvP0uY\nBviuNPVMOQKBgQCLCWzONVjcju25cc39fQSoA46H1o7KyAp6hOKinV3INsyQkcLb\n4JWGV7YexEUu7tpspoV0w153RzXMFIT/xJ5GDYP9mbGERNo8r20YyCpRv2fPGVbF\niNsJdNAuNZX3/CTKKL3lKbpQJVeQufNtHO6EOhhT9L4sm7xdmCukereWRQKBgEIo\nQ8ed0wGxr2wb6TkrQW1LUZkD19zE4tHSvYSesK/hvoWjZBYOz9gpn2z2Qig1WZ+s\nBwVmDrk+KrhFZP34EE8JR8CcHILzPV8Q8QumrvOWafa1vix9XUWWnwNv+iwV5yYZ\neRYhgUQVomyaLEhuWNETSjFSr/S8WAtha42KyI/pAoGAHQQRqfUm2vH/jnnOFgFu\nQLLcG/NeFk+eKDIWpqKrj/GiBnUj/MC3y8agt0IzpQ27VWTRufwU4H4ccWoP+96U\n7ngRt7oSCn6MVhorofM7kbV9NOMlRFxoiexqOerp/gcpYMzSN4J91jwFIvr6kirg\n+D4GQA2bwAtS8wfJBS+hJI4=\n-----END PRIVATE KEY-----\n",
    "client_email": "gcp-service@sendemail-345213.iam.gserviceaccount.com",
    "client_id": "100943159994153039620",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gcp-service%40sendemail-345213.iam.gserviceaccount.com"
  }));
  
const CONFIG = {
      credentials: {
          private_key: CREDENTIALS.private_key,
          client_email: CREDENTIALS.client_email
      }
  };
  
const CLIENT = new language.LanguageServiceClient(CONFIG);
const ARTICLE_TABLE_NAME = process.env.ARTICLE_TABLE_NAME;
  

  const CONTENT_DOCUMENT = {
    type: 'PLAIN_TEXT',
  };
  

  
exports.lambdaHandler = async (event) => {
    // TODO implement
    const pictUrl = event.pictUrl;
    const path = event.path;
    const title = event.title;
    const content = event.content;
    
    CONTENT_DOCUMENT.content = content;
    try{
        var keywords = await getKeywords(CLIENT, CONTENT_DOCUMENT);
        console.log(keywords);
        
        await addNewArticle(title, pictUrl, path, keywords);
        
    } 
    catch(e)
    {
        console.log(e);
    }
    
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
    return response;
};

async function getKeywords(CLIENT, DOCUMENT)
{
    const [result] = await CLIENT.analyzeEntities({document: DOCUMENT});
    
    const retList = [];
    console.log("raw result:");
    console.log(result);
    console.log("--------------------");
    for(var entity of result.entities)
    {
        retList.push(entity.name);
    }
    
    return retList;
}

async function addNewArticle( title, pictUrl, path, keywords)
{
   
    const fetchTime = (Math.floor(Date.now() / 1000));

    
    const params = {
        TableName: ARTICLE_TABLE_NAME,
        Item:{
            title: title,
            fetchTime: fetchTime,
            pictUrl: pictUrl,
            path: path,
            keywords: keywords,
            is: 1
        },
        ConditionExpression: "attribute_not_exists(title) AND attribute_not_exists(fetchTime)"
    }
    
    
    console.log("params: ");
    console.log(params);
    
    await DOC_CLIENT.put(params).promise();

    console.log("finish uploaded article");
    
    
}