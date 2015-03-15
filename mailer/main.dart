library mailer.main;

import 'dart:io';
import 'dart:convert';
import 'package:StupidBirdExpress/mailer/args.dart';
import 'package:StupidBirdExpress/mailer/email_send.dart';

void main(List<String> arguments) {
  final FilePathArgs args = parseArgsFilePath(arguments);
  if (args == null)
      return;
  print(args.path);
  
  File file = new File(args.path);
  String json = file.readAsStringSync();
  print(json);
  var messages =  JSON.decode(json);
  print(messages);
}