library client.motion_cotroller;

import 'dart:html';
import 'dart:async';

import "util.dart";
import "field_name.dart";

class MotionGenerator {
  
  int get _projectW {
    if (_degree == 45 || _degree == 90 || _degree == 135)
      return 1;
    else if (_degree == 0 || _degree == 180)
      return 0;
    else
      return -1;
  }
  
  int get _projectH {
    if (_degree == 135 || _degree == 180 || _degree == 225)
      return 1;
    else if (_degree == 90 || _degree == 270)
      return 0;
    else
      return -1;
  }
  
  int _degree;
  
  MotionGenerator() {
    _degree = 0;
  }
  
  List<List<int>> generatePos(List<List<int>> actions) {
    List<List<int>> actionsPos = new List();
    
    actions.forEach((action) {
      switch (action[ACTION_TYPE]) {
        case ACTION_TURN:
          _degree = (_degree + action[ACTION_DIRECTION] * action[ACTION_TIMES] * DEGREE_UNIT) % 360;
          print('degree: $_degree');
          for (int i = 0; i < action[ACTION_TIMES]; i++)
            actionsPos.add([0, 0]);
          break;
        case ACTION_WALK:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsPos.add([_projectW, _projectH]);
          break;
        case ACTION_FLY:
          actionsPos.add([_projectW * 2, _projectH * 2]);
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
          break;
        case ACTION_WALK:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsAnimate.add([ACTION_WALK]);
          break;
        case ACTION_FLY:
          actionsAnimate.add([ACTION_FLY]);
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
          for (int j = 0; j < actions[i][ACTION_TIMES]; j++)
            actionsHighlighted.add(i);
          break;
        case ACTION_WALK:
        case ACTION_PADDLE:
          for (int j = 0; j < actions[i][ACTION_STEPS]; j++)
            actionsHighlighted.add(i);
          break;
        case ACTION_FLY:
          actionsHighlighted.add(i);
          actionsHighlighted.add(i);
          break;
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
  
  int _state;
  
  MotionDisplayer() {
    mainActor = querySelector('')
      ..style.left = px(MAINACTOR_POS_LEFT)
      ..style.top = px(MAINACTOR_POS_TOP);
    
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
