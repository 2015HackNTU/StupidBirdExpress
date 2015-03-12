library client.action_dropper;

import 'dart:html';

import "field_name.dart";

class ActionDropper {
  DivElement parent;
  List<DivElement> actionDraggers;
  
  int _actionsCount;
  int _lastPos;
  bool _isApplying;
  DivElement _blankDragger;
  
  ActionDropper.start() {
    _initValues();
    _startDragListener();
  }
  
  List<List<int>> getActionValues() {
    List<List<int>> actions = new List();
    List<DivElement> children = parent.children;
    
    children.forEach((child) {
      String type = child.querySelector('.action-type').text;
      if (child.classes.contains('turn')) {
        int degree = child.querySelector('select selected').value;
        int times = degree.abs() ~/ DEGREE_UNIT;
        int direction = degree > 0 ? 1 : -1;
        actions.add([ACTION_TURN, times, direction]); 
      } else if (child.classes.contains('walk')) {
        int steps = int.parse(child.querySelector('input').value.toString());
        actions.add([ACTION_WALK, steps]);
      } else if (child.classes.contains('fly')) {
        actions.add([ACTION_FLY]);
      } else if (child.classes.contains('paddle')) {
        int steps = int.parse(child.querySelector('input').value.toString());
        actions.add([ACTION_PADDLE, steps]);
      } else if (child.classes.contains('hatch')) {
        actions.add([ACTION_HATCH]);
      } else
        print('unknown action type');
    });
    
    return actions;
  }
  
  void _initValues() {
    parent = querySelector('.your-code .list-group');
    actionDraggers = querySelectorAll('.code-sample .b-action');
    
    _blankDragger = actionDraggers[0].clone(false);
    _blankDragger.id = BLANK_DRAGGER_ID;
    _actionsCount = 0;
    _isApplying = false;
  }
  
  void _startDragListener() {
    int type, offset_x, offset_y, left, top, pos;
    bool isOnDrag = false, isFirst = true;
    DivElement dragged;
    
    for (int i = 0; i < actionDraggers.length; i++) {
      actionDraggers[i].onMouseDown.listen((evt) {
        if (!_isApplying) {
          type = i;
          offset_x = evt.client.x;
          offset_y = evt.client.y;
          
          dragged = actionDraggers[i].clone(true);
          dragged.style.position = 'absolute';
          parent.children.insert(0, dragged);
          
          isOnDrag = true;
        }
      });
    }
    
    document
      ..onMouseUp.listen((evt) {
        if (isOnDrag) {
          _removeBlankDragger();
          dragged.remove();
          
          if (_isInDropbox(evt.client.x, evt.client.y))
            _appendAction(_getValidPos(evt.client.y), actionDraggers[type]);
          isOnDrag = false;
        }
      })
      ..onMouseMove.listen((evt) {
        if (isOnDrag) {
          left = evt.client.x - offset_x;
          top = evt.client.y - offset_y;
          _renderDraggedItem(dragged, left, top);
        }
        if (_isInDropbox(evt.client.x, evt.client.y)) {
          if (isFirst) {
            _lastPos = _getValidPos(evt.client.y);
            _insertBlankDragger(_lastPos);
            }
          else
            _renderBlankDragger(_getValidPos(evt.client.y));
        }
      });
  }
  
  void _removeBlankDragger() {
    if (parent.querySelector('.$BLANK_DRAGGER_ID') != null)
      parent.querySelector('.$BLANK_DRAGGER_ID').remove();
  }
  
  void _renderBlankDragger(int pos) {
    if (_lastPos == pos)
      return;
    _removeBlankDragger();
    _insertBlankDragger(pos);
  }
  
  void _insertBlankDragger(int pos) {
    parent.children.insert(pos, _blankDragger);
  }
  
  void _renderDraggedItem(DivElement dragged, int left, int top) {
    dragged.style..left = _px(left)
                 ..top = _px(top);
  }
  
  bool _isInDropbox(int x, int y)
    => x >= DRAGGER_PARENT_LEFT && x <= DRAGGER_PARENT_RIGHT && 
       y >= DRAGGER_PARENT_TOP && y <= DRAGGER_PARENT_BOTTOM;
  
  int _getValidPos(int y) {
    int tempPos = (y - DRAGGER_PARENT_TOP) ~/ DRAGGER_CHILD_HEIGHT;
    return tempPos <= _actionsCount ? tempPos : _actionsCount;
  }
  
  void _appendAction(int pos, DivElement elem) {
    DivElement newElement = elem.clone(true);
    parent.children.insert(pos, newElement);
    _startDeleteActionListener(newElement);
    _actionsCount++;
  }
  
  void _startDeleteActionListener(DivElement newElement) {
    var listener;
    newElement.querySelector('.del-icon').classes.remove('hidden');
    listener = newElement.querySelector('.del-icon').onClick.listen((_) {
      newElement.remove();
      listener.cancel();
    });
  }

  String _px(int n) => '${n}px';
}