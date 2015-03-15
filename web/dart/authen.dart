library client.authen;

import 'dart:html';
import 'package:StupidBirdExpress/client/parse.dart';

void main() {
  String sequence;
  InputElement receiverNameInput = querySelector('#receiverName');
  InputElement receiverEmailInput = querySelector('#receiverEmail');
  ButtonElement submitButton = querySelector('.submit-btn');
  //  is reply
  if (!window.location.search.isEmpty) {
    //protect form
    submitButton.disabled = true;
    //get sequence
    String search = window.location.search.substring(1);
    int position = search.indexOf('=');
    if (search.substring(0, position) == 'id') {
      sequence = search.substring(position);
    }
    //set receiverName, receiverEmail(not alloewd to chage)
    downloadMsg(sequence).then((Message msg) {
      receiverNameInput.value = msg.sendname;
      querySelector('#receiverEmailInfo').text = '寄件者是不公開的喔！我們會直接幫你/妳回傳給對方。';
      querySelector('#receiverEmailInfoEn').text = "The sender's email is private, and we have already filled in  his/her email address.";
      receiverEmailInput.type = "hidden";
      receiverEmailInput.value = msg.sendemail;
    }).catchError((e){
      querySelector("#reply-error-alter").classes.remove('disappear');
    }).whenComplete(() {
      submitButton.disabled = false;
    });
  }
  
  querySelector('#form-alert-close').onClick.listen((_) {
    querySelector('#form-error-alert').classes.add('disappear');
  });
  
  submitButton.onClick.listen((_) {
    String receiverName = receiverNameInput.value;
    String receiverEmail = receiverEmailInput.value;
    String userName = (querySelector('#userEmail') as InputElement).value;
    String userEmail = (querySelector('#userEmail') as InputElement).value;
    //determine massage type
    InputElement messageInput= querySelector('.tab-content .active input');
    String message;
    String filename;
    File messageFile;
    bool isFile = false;
    switch(messageInput.type) {
      case 'text':
        message = messageInput.value;
        break;
      case 'file':
        isFile = true;
        if(messageInput.files.length > 0) {
          messageFile = messageInput.files[0];
          filename = Uri.decodeComponent(messageFile.name);
          print(filename);
        }
        break;
    }
    uploadMsg(userName, userEmail, receiverName, receiverEmail, isFile, message, messageFile, filename)
    .then((_) {
      window.location.href = '../authen_done';
    })
    .catchError((_) {
      querySelector('#form-error-alert').classes.remove('disappear');
    });
  });
}