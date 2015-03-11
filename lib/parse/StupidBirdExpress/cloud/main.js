
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


/**
 * request: 
 * 		{
 * 			 msgId:"jasdfasd;fjsdf"
 * 		}
 */
Parse.Cloud.define("isFinished", function(request, response) {

	var msgId = request.megId;


	var Message = Parse.Object.extend("Message");
	var query = Parse.Query(Message);

	query.get(msgId).then(function(msg) {
		if (msg.get("isDone")) {
			response.success("done");
		}
		else {
			response.success("not done");
		}
	}, function(error) {
		response.error("query failed");
	});
});
