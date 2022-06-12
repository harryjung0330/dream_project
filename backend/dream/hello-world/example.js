var AWS = require("aws-sdk");

exports.lambdaHandler = async (event, context) => {
    console.log(event);
    if(event.source  === 'aws.events')
    {
        console.log("invoked by scheduler to warm");
        return {};
    }

    var response = {
        statusCode: 200,
        body: {
            status:0,
            msg:"successs"
        },
    };


    return response
};
