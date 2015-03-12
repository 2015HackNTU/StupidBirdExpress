library client.motion_cotroller;

import 'dart:html';
import 'dart:math';
import 'dart:async';

import "util.dart";
import "field_name.dart";

class MotionGenerator {
  
  int get _projectW => sin(_degree).ceil();
  
  int get _projectH => -cos(_degree).ceil();
  
  int _degree;
  
  MotionGenerator() {
    _degree = 0;
  }
  
  List<List<int>> generatePos(List<List<int>> actions) {
    List<List<int>> actionsPos = new List();
    
    actions.forEach((action) {
      switch (action[ACTION_TYPE]) {
        case ACTION_TURN: 
          for (int i = 0; i < action[ACTION_TIMES]; i++)
            actionsPos.add([0, 0]);
          break;
        case ACTION_WALK:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsPos.add([_projectW, _projectH]);
          break;
        case ACTION_FLY:
          actionsPos.add([_projectW, _projectH]);
          break;
        case ACTION_PADDLE:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsPos.add([_projectW, _projectH]);
          break;
        case ACTION_HATCH:
          actionsPos.add([0, 0]);
          break;
      }
    });
    return actionsPos;
  }
  
  List<List<int>> generateAnimation(List<List<int>> actions) {
    List<List<int>> actionsAnimate = new List();
    
    actions.forEach((action) {
      switch (action[ACTION_TYPE]) {
        case ACTION_TURN:
          for (int i = 0; i < action[ACTION_TIMES]; i++)
            actionsAnimate.add([ACTION_TURN, action[ACTION_DIRECTION]]);

          _degree = (_degree + action[ACTION_DIRECTION] * action[ACTION_TIMES] * DEGREE_UNIT) % 360;
          break;
        case ACTION_WALK:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsAnimate.add([ACTION_WALK]);
          break;
        case ACTION_FLY:
          actionsAnimate.add([ACTION_FLY]);
          break;
        case ACTION_PADDLE:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsAnimate.add([ACTION_PADDLE]);
          break;
        case ACTION_HATCH:
          actionsAnimate.add([ACTION_HATCH]);
          break;
      }
    });
    return actionsAnimate;
  }
  
  List<int> generateHighlight(List<List<int>> actions) {
    List<int> actionsHighlighted = new List();
    
    for (int i = 0; i < actions.length; i++) {
      switch (actions[i][ACTION_TYPE]) {
        case ACTION_TURN:
          for (int i = 0; i < actions[i][ACTION_TIMES]; i++)
            actionsHighlighted.add(i);
          break;
        case ACTION_WALK:
        case ACTION_PADDLE:
          for (int i = 0; i < actions[i][ACTION_STEPS]; i++)
            actionsHighlighted.add(i);
          break;
        case ACTION_FLY:
        case ACTION_HATCH:
          actionsHighlighted.add(i);
          break;
      }
    }
    return actionsHighlighted;
  }

}


class MotionDisplayer {
  DivElement mainActor;
  
  int get _windowW => window.innerWidth;
  
  int get _windowH => window.innerHeight;
  
  int get _curL => int.parse(mainActor.style.left.substring(0, mainActor.style.left.length - 2));

  int get _curT => int.parse(mainActor.style.top.substring(0, mainActor.style.top.length - 2));
  
  int _stepL;
  int _state;
  
  MotionDisplayer() {
    mainActor = querySelector('')
      ..style.left = px(MAINACTOR_POS_LEFT)
      ..style.top = px(MAINACTOR_POS_TOP);
    
    _stepL = (_windowW * 0.09).toInt();
    _state = 0;
  }
  
  void startMotionDisplayer(List<List<int>> pos, List<List<int>> imgs, List<int> highlight) {
    Timer timer;
    int i = 0, j = 0;
    
    timer = new Timer.periodic(new Duration(milliseconds: 250), (_) {
      if (_isInChangeImgState) {
        j = (++j) % 2;
//        if (_isDone) {
//          
//          timer.cancel();
//        }
      }
      
      if (_isInChangePosState) {
        
      }
      
      if (_isInChangeBoxState) {
        i++;
      }
      
      _state++;
    });
  }
  
  bool get _isInChangePosState => _state.remainder(TIME_UNIT_PER_POS) == 0;
  
  bool get _isInChangeImgState => _state.remainder(TIME_UNIT_PER_IMG) == 0;
  
  bool get _isInChangeBoxState => _state.remainder(TIME_UNIT_PER_HIGHLIGHT) == 0;
  
}
