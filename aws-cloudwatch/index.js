// Defines the main Lambda function, called a handler.
// The handler is the entry point of the Lambda function, that is, what AWS executes when Lambda is invoked.
// The event parameter contains the input data that triggered the Lambda (e.g., API Gateway call, S3 event, etc.).
// The function is asynchronous, allowing the use of await for asynchronous operations (such as HTTP calls or database queries).
exports.handler = async (event) => {
    console.log("Lambda Log Working!");
    return { statusCode: 200, body: "Lambda executed successfully!" };
};
