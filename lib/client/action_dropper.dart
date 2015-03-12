library client.action_dropper;

import 'dart:html';

import "field_name.dart";

class ActionDropper {
  DivElement parent;
  List<DivElement> actionDraggers;
  
  int _actionsCount;
  int _insertPos;
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
      switch (type) {
        case 'Turn':
          int degree = child.querySelector('select selected').value;
          int times = degree.abs() ~/ DEGREE_UNIT;
          int direction = degree > 0 ? 1 : -1;
          actions.add([ACTION_TURN, times, direction]);
          break;
        case 'Walk':
          int steps = int.parse(child.querySelector('input').value.toString());
          actions.add([ACTION_WALK, steps]);
          break;
        case 'Fly':
          actions.add([ACTION_FLY]);
          break;
        case 'Paddle':
          int steps = int.parse(child.querySelector('input').value.toString());
          actions.add([ACTION_PADDLE, steps]);
          break;
        case 'Hatch':
          actions.add([ACTION_HATCH]);
          break;
        default:
          print('unknown action type: $type');
      }
    });
    
    return actions;
  }
  
  void _initValues() {
    parent = querySelector('');
    actionDraggers = querySelectorAll('');
    
    _blankDragger = querySelector('');
    _actionsCount = 0;
  }
  
  void _startDragListener() {
    int type, offset_x, offset_y;
    bool isOnDrag;
    
    actionDraggers.forEach((DivElement dragger) {
      type = Draggers[dragger.id];
      isOnDrag = false;
      dragger.onMouseDown.listen((evt) {
        offset_x = evt.client.x;
        offset_y = evt.client.y;
        
        _insertBlankDragger();
        isOnDrag = true;
      });
    });
    
    document
      ..onMouseUp.listen((evt) {
        _removeBlankDragger();
        if (_isInDropbox(evt.client.x, evt.client.y)) {
          _insertPos = _getValidPos(evt.client.y);
          _insertBlankDragger();
        }
        isOnDrag = false;
      })
      ..onMouseMove.listen((evt) {
        if (isOnDrag) 
          _renderBlankDragger(evt.client.x - offset_x, evt.client.y - offset_y);
        });
  }
  
  void _removeBlankDragger() {
    if (parent.querySelector('.blank-dragger') != null)
      parent.querySelector('.blank-dragger').remove();
  }
  
  void _renderBlankDragger(int left, int top) {
    parent.querySelector('.blank-dragger')
    .style..left = _px(left)
          ..top = _px(top);
  }
  
  void _insertBlankDragger() {
    parent.children.insert(_insertPos, _blankDragger.clone(true));
  }
  
  bool _isInDropbox(int x, int y)
    => x >= DRAGGER_PARENT_LEFT && x <= DRAGGER_PARENT_RIGHT && 
       y >= DRAGGER_PARENT_TOP && y <= DRAGGER_PARENT_BOTTOM;
  
  int _getValidPos(int y) {
    int tempPos = ((y - DRAGGER_PARENT_TOP) / DRAGGER_CHILD_HEIGHT).round();
    return tempPos <= _actionsCount ? tempPos : _actionsCount;
  }
  
  void _appendAction(DivElement dragger) {
    _removeBlankDragger();
    
    DivElement newElement = dragger.clone(true);
    parent.children.insert(_insertPos, newElement);
    _startDeleteActionListener(newElement);
    _actionsCount++;
  }
  
  void _startDeleteActionListener(DivElement newElement) {
    var listener;
    listener = newElement.querySelector('.remove').onClick.listen((_) {
      newElement.remove();
      listener.cancel();
    });
  }

  String _px(int n) => '${n}px';
}