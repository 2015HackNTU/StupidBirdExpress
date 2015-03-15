library client.email_send;

import 'dart:async';
import 'package:mailer/mailer.dart';

const String SENDER_EMAIL = 'radleaf@gmail.com';//'hackntu@gmail.com';
const String SENDER_PASSWORD = 'rfvgy7';//'ilovehackntu2015';
const String EMAIL_SUBJECT = '【黑客週】您有一則HackMessage';

Future sendEmail(String receiverName, String receiverEmail, String senderName, String id) {
  var options = new GmailSmtpOptions()
    ..username = SENDER_EMAIL
    ..password = SENDER_PASSWORD;
  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'hackNTU@gmail.com'
    ..fromName = 'HackNTU'
    ..recipients.add(receiverEmail)
    ..subject = EMAIL_SUBJECT
    ..html = getEmailHtml(receiverName, senderName, id);

  // Email it.
  return emailTransport.send(envelope);
}

String getEmailHtml(String receiverName, String senderName, String id) {
  String template = '<body>'+
      '<style>'+
          '@import url(http://fonts.googleapis.com/css?family=Coming+Soon);'+
      '</style>'+
      '<div style="width:100%;height:200%;background-color:ffe530;">'+
      '<img src="hackcover-3-2.jpg" width="100%" style="margin-bottom:30px;">'+
      '<div class="title" width="100%">'+
        '<img src="bird_whole_r.png" width="10%" style="float:left;margin:5%;">'+
        '<img src="bird_whole.png" width="10%" style="float:right;margin:5%;">'+
        '<h1 style="display:inline-block;width:60%;text-align:center;margin-top:100px;font-size:30px;font-family: "Coming Soon", "微軟正黑體";">笨鳥快遞'+
        '<span style="color:#7a4f2d;">Stupid Bird Express</span></h1>'+
      '</div>'+
      "<div style='margin:5%;text-align:center;background-color:white;border-radius:5px;padding:20px;font-family: 'Coming Soon','Hannotate SC','微軟正黑體';'>"+
      "親愛的<span style='color:#7a4f2d;'>$receiverName</span>，<br/>你收到一封來自<span style='color:#7a4f2d;'>$senderName</span>的HackMessage！<br/>"+
      "點擊<a href='http://2015hackntu.github.io/StupidBirdExpress.github.io/html/game?id=$id'>這裡</a>玩遊戲並破關取得你的訊息吧！"+
      "截下或拍下破關畫面還可以來攤位抽獎喔！<br/>想瞭解更多嗎？來黑客週吧！<br/><br/>Dear <span style='color:#7a4f2d;'>$receiverName</span>,<br/>You've got a HackMessage from "+
      "<span style='color:#7a4f2d;'>$senderName</span>!<br/>Click <a  href='http://2015hackntu.github.io/StupidBirdExpress.github.io/html/game?id=$id'>here</a>"+
      " to access who deliver this message to you and read what he/she wants to tell you! <br/>"+
      "Remember to screen shot the winning page to join the lottery!<br>Come to 黑客週 to learn more about HackNTU and MessageHunt.</div>"+
      '<img src="logo.png" width="90%" style="margin:5%;margin-bottom:1%;">'+
      '<p style="text-align:center">copyright &copy 2015 HackNTU</p>'+
      '</div>'+
    '</body>';
  return template;
}