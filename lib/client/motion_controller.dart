library client.motion_cotroller;

import 'dart:html';
import 'dart:math';

import "field_name.dart";

class MotionController {
  DivElement mainActor;
  
  int get _windowW => window.innerWidth;
  
  int get _iwndowH => window.innerHeight;
  
  int get _curL => int.parse(mainActor.style.left.substring(0, mainActor.style.left.length - 2));

  int get _curT => int.parse(mainActor.style.top.substring(0, mainActor.style.top.length - 2));
  
  int get _projectW => (_stepL * sin(_degree)).toInt();
  
  int get _projectH => -(_stepL * cos(_degree)).toInt();
  
  int _stepL;
  int _degree;
  
  MotionController() {
    mainActor = querySelector('')
      ..style.left = _px(MAINACTOR_POS_LEFT)
      ..style.top = _px(MAINACTOR_POS_TOP);
    
    _stepL = (_windowW * 0.09).toInt();
    _degree = 0;
  }
  
  List<List<int>> generatePos(List<List<int>> actions) {
    List<List<int>> actionsPos = new List();
    
    actions.forEach((action) {
      switch (action[TYPE]) {
        case TURN: 
          actionsPos.add([_curL, _curT]);
          break;
        case WALK:
          for (int i = 0; i < action[STEPS]; i++)
            actionsPos.add([_curL + _projectW, _curT + _projectH]);
          break;
        case FLY:
          actionsPos.add([_curL + _projectW, _curT + _projectH]);
          break;
        case PADDLE:
          for (int i = 0; i < action[STEPS]; i++)
            actionsPos.add([_curL + _projectW, _curT + _projectH]);
          break;
        case HATCH:
          actionsPos.add([_curL, _curT]);
          break;
      }
    });
    return actionsPos;
  }
  
  List<List<int>> generateAnimation(List<List<int>> actions) {
    List<List<int>> actionsAnimate = new List();
    
    actions.forEach((action) {
      switch (action[TYPE]) {
        case TURN:
          for (int i = 0; i < action[TIMES]; i++)
            actionsAnimate.add([TURN, action[DIRECTION]]);

          _degree = (_degree + action[DIRECTION] * action[TIMES] * DEGREE_UNIT) % 360;
          break;
        case WALK:
          for (int i = 0; i < action[STEPS]; i++)
            actionsAnimate.add([WALK]);
          break;
        case FLY:
          actionsAnimate.add([FLY]);
          break;
        case PADDLE:
          for (int i = 0; i < action[STEPS]; i++)
            actionsAnimate.add([PADDLE]);
          break;
        case HATCH:
          actionsAnimate.add([HATCH]);
          break;
      }
    });
    return actionsAnimate;
  }
  
  List<int> generateHighlight(List<List<int>> actions) {
    List<int> actionsHighlighted = new List();
    
    for (int i = 0; i < actions.length; i++) {
      switch (actions[i][TYPE]) {
        case TURN:
          for (int i = 0; i < actions[i][TIMES]; i++)
            actionsHighlighted.add(i);
          break;
        case WALK:
        case PADDLE:
          for (int i = 0; i < actions[i][STEPS]; i++)
            actionsHighlighted.add(i);
          break;
        case FLY:
        case HATCH:
          actionsHighlighted.add(i);
          break;
      }
    }
    return actionsHighlighted;
  }

  String _px(int n) => '${n}px';
}