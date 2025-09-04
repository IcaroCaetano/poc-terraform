exports.handler = async (event) => {
    console.log("Lambda Log Working!");
    return { statusCode: 200, body: "Lambda executed successfully!" };
};
