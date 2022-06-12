const language = require('@google-cloud/language');
const AWS = require("aws-sdk");
const DOC_CLIENT = new AWS.DynamoDB.DocumentClient();

const CREDENTIALS = JSON.parse(JSON.stringify({
  
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