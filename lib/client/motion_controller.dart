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
  
  double get _curL => doubleParser(mainActor.style.left, 2);

  double get _curT => doubleParser(mainActor.style.top, 2);
  
  List<LIElement> get _children => querySelectorAll('.your-code .list-group .b-action');
  
  int _state;
  
  MotionDisplayer() {
    //TODO: assign selector
    mainActor = querySelector('');
    _setMainActorPos(MAINACTOR_POS_LEFT.toDouble(), MAINACTOR_POS_TOP.toDouble());
  }
  
  void startMotionDisplayer(List<List<int>> pos, List<List<int>> imgs, List<int> highlight) {
    Timer timer;
    int imgState = 0;
    
    _state = 0;
    
    timer = new Timer.periodic(new Duration(milliseconds: 100), (_) {
      if (_isInChangeImgState) { 
        switch (imgs[_state][ACTION_TYPE]) {
          case ACTION_TURN:
            break;
          case ACTION_WALK:
            break;
          case ACTION_FLY:
            break;
          case ACTION_PADDLE:
            break;
          case ACTION_HATCH:
            break;
        }
        
        imgState = (++imgState) % 4;
      }
      
      if (_isInChangePosState) {
        double left = _curL + pos[_state][0] * STEP_UNIT;
        double top = _curT + pos[_state][1] * STEP_UNIT;
        _setMainActorPos(left, top);
      }
      
      if (_isInChangeBoxState) {
        if (highlight[_state] != highlight[_state - 1]) {
          _removeRunningStatus(_children[_state - 1]);
          _addRunningStatus(_children[_state]);
        }
      }
      
      if (imgState == imgs.length)
        timer.cancel();
      
      _state++;
    });
  }
  
  void _setMainActorPos(double left, double top) {
    mainActor.style..left = pxD(left)
                   ..top = pxD(top);
  }
  
  void _addRunningStatus(Element elem) {}

  void _removeRunningStatus(Element elem) {}
  
  bool get _isInChangePosState => _state.remainder(TIME_UNIT_PER_POS) == 0;
  
  bool get _isInChangeImgState => _state.remainder(TIME_UNIT_PER_IMG) == 0;
  
  bool get _isInChangeBoxState => _state.remainder(TIME_UNIT_PER_HIGHLIGHT) == 0;
  
}
