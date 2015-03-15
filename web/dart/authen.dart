library client.authen;

import 'dart:html';
import 'dart:convert';

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
    String filename;
    File massageFile;
    bool isFile = false;
    switch(massageInput.type) {
      case 'text':
        massage = massageInput.value;
        break;
      case 'file':
        isFile = true;
        if(massageInput.files.length > 0) {
          massageFile = massageInput.files[0];
          filename = UTF8.encode(massageFile.name).toString();
          print(filename);
        }
        break;
    }
    try { 
      
    } catch(e) {
      
    }

  });
}