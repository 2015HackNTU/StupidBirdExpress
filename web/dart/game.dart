library client.game;

import 'dart:html';
import 'dart:math';

import 'package:StupidBirdExpress/client/field_name.dart';
import 'package:StupidBirdExpress/client/level_map.dart';
import 'package:StupidBirdExpress/client/action_dropper.dart';
import 'package:StupidBirdExpress/client/motion_controller.dart';

int rand;
LevelMap map;

MotionGenerator mGenerator = new MotionGenerator();
MotionDisplayer mDisplayer = new MotionDisplayer();

void main() {
  rand = new Random().nextInt(Maps.length);
  map = new LevelMap(MAINACTOR_POS[rand], Maps[rand], rand == 1);
  setMapBackground();
  map.setMainActorPos();
  
  ActionDropper dropper = new ActionDropper.start();
  startRunBtnListener(dropper);
}

void setMapBackground() {
  ImageElement img = querySelector('.map-image');
  img.src = MapBackground[rand];
}

void startRunBtnListener(ActionDropper dropper) {
    querySelector('.your-code .run-btn').onClick.listen((_) {
    dropper.allowDragging = false;
    List<List<int>> actions = dropper.getActionValues();
//print('actions: $actions');
    
    List<List<int>> pos = mGenerator.generatePos(actions);
    List<List<int>> animate = mGenerator.generateAnimation(actions);
    List<int> highlight = mGenerator.generateHighlight(actions);
    //List mockMove = map.generateMockMove(pos);
    
    print(pos);
    print(animate);
    print(highlight);
    //print(mockMove);

    dropper.allowDragging = true;
  });
}