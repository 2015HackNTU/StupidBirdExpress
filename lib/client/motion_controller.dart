library client.motion_cotroller;

import "field_name.dart";

class MotionGenerator {
  
  int get _projectW {
    if (degree == 45 || degree == 90 || degree == 135)
      return 1;
    else if (degree == 0 || degree == 180)
      return 0;
    else
      return -1;
  }
  
  int get _projectH {
    if (degree == 135 || degree == 180 || degree == 225)
      return 1;
    else if (degree == 90 || degree == 270)
      return 0;
    else
      return -1;
  }
  
  int degree;
  
  List<List<int>> generatePos(List<List<int>> actions) {
    List<List<int>> actionsPos = new List();
    
    actions.forEach((action) {
      switch (action[ACTION_TYPE]) {
        case ACTION_TURN:
          degree = (degree + action[ACTION_DIRECTION] * action[ACTION_TIMES] * DEGREE_UNIT) % 360;
          print('degree: $degree');
          for (int i = 0; i < action[ACTION_TIMES]; i++)
            actionsPos.add([0, 0, ACTION_TURN]);
          break;
        case ACTION_WALK:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsPos.add([_projectW, _projectH, ACTION_WALK]);
          break;
        case ACTION_FLY:
          actionsPos.add([_projectW, _projectH, ACTION_FLY]);
          actionsPos.add([_projectW, _projectH, ACTION_LAND]);
          break;
        case ACTION_PADDLE:
          for (int i = 0; i < action[ACTION_STEPS]; i++)
            actionsPos.add([_projectW, _projectH, ACTION_PADDLE]);
          break;
        case ACTION_HATCH:
          actionsPos.add([0, 0, ACTION_HATCH]);
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
          actionsAnimate.add([ACTION_LAND]);
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

