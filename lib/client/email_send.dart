library client.email_send;

import 'dart:async';
import 'package:mailer/mailer.dart';

const String SENDER_EMAIL = 'radleaf@gmail.com';//'hackntu@gmail.com';
const String SENDER_PASSWORD = 'rfvgy7';//'ilovehackntu2015';
const String EMAIL_SUBJECT = '【黑客週】您有一則HackMessage';

Future sendEmail(String receiverName, String receiverEmail, String senderName) {
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
    ..html = getEmailHtml(receiverName, senderName);

  // Email it.
  return emailTransport.send(envelope);
}

String getEmailHtml(String receiverName, String senderName) {
  String template = 
      '<img ' +
      '' +
      '';
  return template;
}