var AWS = require("aws-sdk");
const TABLE_ARNS = process.env["TABLE_NAMES"];
var lambda = new AWS.Lambda();

exports.lambdaHandler = async (event, context) => {

    var tableString = "";

    for(var i = 0; i < TABLE_ARNS.length; i++)
    {
        if(TABLE_ARNS.charAt(i) !== " ")
        {
            tableString += TABLE_ARNS.charAt(i);
        }    
    }

    var tableList = tableString.split(',');
    console.log("tableList:");
    console.log(tableList);

    console.log(event); 

    var promList = [];

    for(let arn of tableList)
    {
        try{
        promList.push(invokeLambda(arn));
        }
        catch(e)
        {
            console.log("error occurred while warming:"  + arn);
            console.log(e);
        }
    }
    
    console.log("promiseList: " );
    console.log(promList);
    
    try{
    await Promise.all(promList);
    }
    catch(e)
    {
        console.log(e);
    }

    console.log("done!");

    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:"successs"
        },
    };


    return response
};


async function invokeLambda(table_arn)
{   
    var temp = table_arn.split(":")
    var name = temp[temp.length - 1]; 
    console.log("name: " + name );
    
    var params = {
        FunctionName: name, // the lambda function we are going to invoke
        InvocationType: 'Event',
        Payload: '{ "source" : "DreamWarmLambdas" }'
      };
    return new Promise((resolve, reject) => lambda.invoke(params , (err, result) => ((err) ? reject(err) :
  (result.FunctionError) ? reject({ statusCode: 502, body: result.Payload })
   : resolve(result))));
}
