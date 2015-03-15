library clienr.parse;

import "dart:async";
import "dart:html";
import "dart:js" as js;

/**
 * upload your message, text or file
 * @param  {string}  email    email
 * @param  {Boolean} isFile   text->false; file->true
 * @param  {object}  content  text->the text, 
 *                            file->html5 file object, see sample.html for details
 * @param  {string}  filename text->don't care; file->filename, see sample.html
 * @param  {func}    onSuccess function(string msgId) 
 * @param  {func}    onFailure function(string errmsg)
 * @return {void}
 */
Future uploadMsg(String sendname, String sendemail, String recvname, String recvemail, bool isFile, String textMessage, File file, String filename) {
  Completer cmpl = new Completer();
  var ok = (response) => cmpl.complete(response);
  var fail = (error) => cmpl.completeError(error);
  var content;
  if (isFile)
    content = file;
  else
    content = textMessage;
  js.context.callMethod('uploadMsg', [sendname, sendemail, recvname, recvemail, isFile, content, filename, ok, fail]);
  return cmpl.future;
}


/**
 * check if the message is ... DONE ?
 * @param  {string}   msgId     the id got from uploadMsg
 * @param  {func  }   onSuccess function(boolean done)   
 * @param  {func  }   onFailure functoin(string errmsg)
 * @return {void  }
 */
Future isDone(String msgId) {
    Completer cmpl = new Completer();
    var ok = (response) => cmpl.complete(response);
    var fail = (error) => cmpl.completeError(error);
    
    js.context.callMethod('isDone', [msgId, ok, fail]);
    return cmpl.future;
  }


/**
 * set done of not done, usually done?
 * @param {string }  msgId   got from uploadMsg
 * @param {Boolean}  isDone  the new status
 * @param {func}     onSuccess function(void)
 * @param {func}     onFailure function(string errmsg)
 */
Future setStatus(String msgId, bool isDone) {
  Completer cmpl = new Completer();
  var ok = (response) => cmpl.complete(response);
  var fail = (error) => cmpl.completeError(error);
  
  js.context.callMethod('setStatus', [msgId, isDone, ok, fail]);
  return cmpl.future;
}

/**
 * download the message, text or file
 * @param  {string}   msgId     message id, frmo uploadMsg
 * @param  {func}     onSuccess function({isFile: bool isFile, content: string content, email: string email})
 *                              isFile: file->true; text->false
 *                              content: file->url; text->text message
 * @param  {func}     onFailure function(string errmsg)
 * @return {void}
 */
Future downloadMsg(msgId) {
  Completer cmpl = new Completer();
  var ok = (response) => cmpl.complete(new Message(response['isFile'], response['content'],
      response['sendname'], response['sendemail'], response['recvname'], response['recvemail']));
  var fail = (error) => cmpl.completeError(error);
  
  js.context.callMethod('downloadMsg', [msgId, ok, fail]);
  return cmpl.future;
}

class Message {
   bool isFile;
   File file;
   String textMessage;
   String sendname;
   String sendemail;
   String recvname;
   String recvemail;
   var content;
   
   Message(this.isFile, this.content, this.sendname, this.sendemail, this.recvname, this.recvemail) {
     if (isFile)
       file = content;
     else 
       textMessage = content;
   }
}