library client.game;

import 'dart:html';
import 'dart:math';

import 'package:StupidBirdExpress/client/field_name.dart';
import 'package:StupidBirdExpress/client/level_map.dart';
import 'package:StupidBirdExpress/client/action_dropper.dart';
import 'package:StupidBirdExpress/client/motion_controller.dart';

int rand;
LevelMap map;

MotionGenerator mGenerator;

void main() {
  rand = new Random().nextInt(Maps.length);
  map = new LevelMap(MainActorPos[rand], Maps[rand], rand == 1);
  mGenerator = new MotionGenerator();
  setMapBackground();
  
  ActionDropper dropper = new ActionDropper.start();
  startRunBtnListener(dropper);
}

void setMapBackground() {
  ImageElement img = querySelector('.map-image');
  img.src = MapBackground[rand];
}

void startRunBtnListener(ActionDropper dropper) {
    querySelector('.your-code .run-btn').onClick.listen((_) {
    reset();
    
    dropper.allowDragging = false;
    
    try {
      List<List<int>> actions = dropper.getActionValues();
      
      if (actions.isNotEmpty) {
        List<List<int>> pos = mGenerator.generatePos(actions);
        List<List<int>> animate = mGenerator.generateAnimation(actions);
        List<int> highlight = mGenerator.generateHighlight(actions);
        
        map.startMove(pos, animate, highlight);
      }
    } catch (e) {
      querySelector('.invalid').classes.remove('disappear');
    }

    dropper.allowDragging = true;
  });
}

void reset() {
  map.resetPos();
  mGenerator.degree = MainActorPos[rand][2];
  querySelector('.invalid').classes.add('disappear');
}