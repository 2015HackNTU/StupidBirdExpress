library client.authen;

import 'dart:html';
import 'dart:async';
import 'package:StupidBirdExpress/client/parse.dart';

void main() {
  String sequence;
  InputElement receiverNameInput = querySelector('#receiverName');
  InputElement receiverEmailInput = querySelector('#receiverEmail');
  InputElement senderNameInput = querySelector('#userName');
  InputElement senderEmailInput = querySelector('#userEmail');
  ButtonElement submitButton = querySelector('.submit-btn');
  //  is reply
  if (!window.location.search.isEmpty) {
    //protect form
    submitButton.disabled = true;
    //get sequence
    String search = window.location.search.substring(1);
    int position = search.indexOf('=');
    if (search.substring(0, position) == 'id') {
      sequence = search.substring(position + 1);
    }
    //set receiverName, receiverEmail(not alloewd to chage)
    downloadMsg(sequence).then((Message msg) {
      receiverNameInput.value = msg.sendname;
      querySelector('#receiverEmailInfo').text = '寄件者是不公開的喔！我們會直接幫你/妳回傳給對方。';
      querySelector('#receiverEmailInfoEn').text = "The sender's email is private, and we have already filled in  his/her email address.";
      receiverEmailInput.type = "hidden";
      receiverEmailInput.value = msg.sendemail;
      senderNameInput.value = msg.recvname;
      senderEmailInput.value = msg.recvemail;
    }).catchError((e){
      querySelector("#reply-error-alter").classes.remove('disappear');
    }).whenComplete(() {
      submitButton.disabled = false;
    });
  }
  //close X btn litsener
  querySelector('#form-alert-close').onClick.listen((_) {
    querySelector('#form-error-alert').classes.add('disappear');
  });
  querySelector('#send-email-alert-close').onClick.listen((_) {
    querySelector('#send-email-alert').classes.add('disappear');
  });
  querySelector('#recv-email-alert-close').onClick.listen((_) {
    querySelector('#recv-email-alert').classes.add('disappear');
  });
  
  submitButton.onClick.listen((_) {
    String receiverName = receiverNameInput.value;
    String receiverEmail = receiverEmailInput.value;
    String userName = senderNameInput.value;
    String userEmail = senderEmailInput.value;
    if(receiverName.isEmpty || receiverEmail.isEmpty || userName.isEmpty || userEmail.isEmpty) {
      querySelector('#form-error-alert').classes.remove('disappear');
      return new Future.value(null);
    }
    //check email valid
    if (!_EMAIL_FORMAT.hasMatch(receiverEmail)) {
      querySelector('#recv-email-alert').classes.remove('disappear');
      return new Future.value(null);     
    }
    if (!_EMAIL_FORMAT.hasMatch(userEmail)) {
      querySelector('#send-email-alert').classes.remove('disappear');
      return new Future.value(null);  
    }
      
    //determine massage type
    InputElement messageInput= querySelector('.tab-content .active input');
    String message;
    String filename;
    File messageFile;
    bool isFile = false;
    switch(messageInput.type) {
      case 'text':
        message = messageInput.value;
        if (message == ""){
          querySelector('#form-error-alert').classes.remove('disappear');
          return new Future.value(null);
        }
        break;
      case 'file':
        isFile = true;
        if(messageInput.files.length > 0) {
          messageFile = messageInput.files[0];
          int pos = messageFile.name.indexOf('.');
          filename = 'HackMessage' + messageFile.name.substring(pos);
          print(filename);
        } else {
          querySelector('#form-error-alert').classes.remove('disappear');
          return new Future.value(null);
        }
        break;
    }
    return uploadMsg(userName, userEmail, receiverName, receiverEmail, isFile, message, messageFile, filename)
    .then((_) {
      window.location.href = '../authen_done';
    })
    .catchError((_) {
      querySelector('#form-error-alert').classes.remove('disappear');
    });
  });
}

final RegExp _EMAIL_FORMAT = new RegExp(r"^[a-zA-Z0-9.!#$%&’*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");