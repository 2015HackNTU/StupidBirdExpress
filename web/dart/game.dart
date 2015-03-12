library client.game;

import 'dart:html';

import 'package:StupidBirdExpress/client/action_dropper.dart';

void main() {
  print('haha');
  ActionDropper dropper = new ActionDropper.start();
  Element runBtn = querySelector('.your-code .run-btn');
  runBtn.onClick.listen((_) {
       print('clicked!');
       dropper.allowDragging = false;
  });
}