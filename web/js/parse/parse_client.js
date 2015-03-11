var init = false;

/**
 * Parse SDK initializaiton. You must call this before any function below is called.
 * Remember to add the <script> of Parse SDK to your html file.
 */
function initParse() {
  if (isNullOrUndef(Parse)) {
    console.error("'Parse' is undefined. Please check if you've added PARSE SDK into your html file.");
  }

  var appId = "ppfEmWTXVnkhZFfJI7ciVAF7LktBxzUqVT9OB2vI";
  var jsKey = "l72d8xkku9s0JCfPkHRHsjrrVlIvzLum9Lb7cwIc";
  Parse.initialize(appId, jsKey);
  init = true;
}


/**
 * upload your message, text or file
 * @param  {Boolean} isFile   text->false; file->true
 * @param  {object}  content  text->the text, 
 *                            file->html5 file object, see sample.html for details
 * @param  {string}  filename text->don't care; file->filename, see sample.html
 * @param  {func}    onSuccess function(string msgId) 
 * @param  {func}    onFailure function(string errmsg)
 * @return {void}
 */
function uploadMsg(isFile, content, filename, onSuccess, onFailure) {
  if (!init) {
    initParse();
  }

  var promise = Parse.Promise.as();
  var Message = Parse.Object.extend("Message");
  var msg = new Message();
  msg.set("isDone", false);
  msg.set("isFile", isFile);

  promise.then(function() {
    if (isFile) {
      console.log("saving file:" + filename);
      var parseFile = new Parse.File(filename, content);
      return parseFile.save().then(function() {
        console.log("saved");
        msg.set("file", parseFile);
        return Parse.Promise.as();
      }, function(error) {
        console.log("save file failed: " + error.message);
        return Parse.Promise.error("save file failed: " + error.message);
      });
    }
    else {
      msg.set("text", content);
      return Parse.Promise.as()   
    }  
  }).then(function() {
    return msg.save();
  }).then(function(msgSaved){
    console.log("saved, response=" + JSON.stringify(msgSaved));
    onSuccess(msgSaved.id);
  }, function(error) {
    onFailure(error.message);
  });
}


/**
 * check if the message is ... DONE ?
 * @param  {string}   msgId     the id got from uploadMsg
 * @param  {func  }   onSuccess function(boolean done)   
 * @param  {func  }   onFailure functoin(string errmsg)
 * @return {void  }
 */
function isDone(msgId, onSuccess, onFailure) {
  if (!init) {
    initParse();
  }

  Parse.Cloud.run("isFinished", {
    "msgId":msgId
  }).then(function(response) {
    console.log("isDone:response=" + response);
    onSuccess(response == "done");
  }, function(error) {
    onFailure(error.message);
  });
}


/**
 * set done of not done, usually done?
 * @param {string }  msgId   got from uploadMsg
 * @param {Boolean}  isDone  the new status
 * @param {func}     onSuccess function(void)
 * @param {func}     onFailure function(string errmsg)
 */
function setStatus(msgId, isDone, onSuccess, onFailure) {
  if (!init) {
    initParse();
  }

  var Message = Parse.Object.extend("Message");
  var query = new Parse.Query(Message);

  query.get(msgId).then(function(msg) {
    
    // set status to isDone
    console.log("query message succeeded");
    msg.set("isDone", isDone);

    // save modified msg
    return msg.save();
  }).then(function(response) {

    // saved done
    console.log("save done");
    onSuccess();
  }, function(error) {
    console.log("set status failed");
    onFailure(error.message);
  });
}

/**
 * download the message, text or file
 * @param  {string}   msgId     message id, frmo uploadMsg
 * @param  {func}     onSuccess function({isFile: bool isFile, content: string content})
 *                              isFile: file->true; text->false
 *                              content: file->url; text->text message
 * @param  {func}     onFailure function(string errmsg)
 * @return {void}
 */
function downloadMsg(msgId, onSuccess, onFailure) {
  if (!init) {
    initParse();
  }

  var Message = Parse.Object.extend("Message");
  var query = new Parse.Query(Message);

  query.get(msgId).then(function(msg) {

    if (msg.get("isFile")) {
      console.log("download: isFile, url=" + msg.get("file").url());
      onSuccess({isFile:true, content:msg.get("file").url()});
    }
    else {
      console.log("download: text, text=" + msg.get("text"));
      onSuccess({isFile:false, content:msg.get("text")});
    }
  }, function(error) {
    console.log("query failed");
    onFailure(error.message);
  });

}


function isNullOrUndef(obj) {
  return (typeof obj === 'undefined' || obj == null);
}