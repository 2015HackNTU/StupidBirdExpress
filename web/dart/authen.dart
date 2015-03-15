library client.authen;

import 'dart:html';
//import 'package:StupidBirdExpress/client/email_send.dart';

void main() {
  String sequence;
  InputElement receiverNameInput = querySelector('#receiverName');
  InputElement receiverEmailInput = querySelector('#receiverName');
  //is reply
  if (!window.location.search.isEmpty) {
    //get sequence
    String search = window.location.search.substring(1);
    int position = search.indexOf('=');
    if (search.substring(0, position) == 'id') {
      sequence = search.substring(position);
    }
    //set receiverName, receiverEmail(not alloewd to chage)
    receiverNameInput.value = "";
    
  }
  
  ButtonElement btn = querySelector('.submit-btn');
  btn.onClick.listen((_) {
    String receiverName = receiverNameInput.value;
    String receiverEmail = (querySelector('#receiverEmail') as InputElement).value;
    String userName = receiverEmailInput.value;
    String userEmail = (querySelector('#userEmail') as InputElement).value;
    //determine massage type
    InputElement massageInput= querySelector('.tab-content .active input');
    String massage;
    File massageFile;
    switch(massageInput.type) {
      case 'text':
        break;
      case 'file':
        break;
    }
    try { 
      
    } catch(e) {
      
    }

  });
}