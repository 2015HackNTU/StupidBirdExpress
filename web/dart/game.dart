library client.game;

import 'dart:html';

import 'package:StupidBirdExpress/client/field_name.dart';
import 'package:StupidBirdExpress/client/level_map.dart';
import 'package:StupidBirdExpress/client/action_dropper.dart';
import 'package:StupidBirdExpress/client/motion_controller.dart';

MotionGenerator mGenerator = new MotionGenerator();
MotionDisplayer mDisplayer = new MotionDisplayer();
LevelMap map = new LevelMap(MAINACTOR_POS_LEFT, MAINACTOR_POS_TOP);
    
void main() {
  ActionDropper dropper = new ActionDropper.start();
  Element runBtn = querySelector('.your-code .run-btn');
  runBtn.onClick.listen((_) {
    dropper.allowDragging = false;
    List<List<int>> actions = dropper.getActionValues();
//print('actions: $actions');
    
    List<List<int>> pos = mGenerator.generatePos(actions);
    List<List<int>> animate = mGenerator.generateAnimation(actions);
    List<int> highlight = mGenerator.generateHighlight(actions);
    List mockMove = map.generateMockMove(pos);
    
    print(pos);
    print(animate);
    print(highlight);
    print(mockMove);

    dropper.allowDragging = true;
  });
}