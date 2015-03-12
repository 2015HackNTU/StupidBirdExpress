library client.action_dropper;

import 'dart:html';

import "util.dart";
import "field_name.dart";

class ActionDropper {
  UListElement parent;
  List<LIElement> actionDraggers;
  
  int _actionsCount;
  int _lastPos;
  bool _isApplying;
  LIElement _blankDragger;
  
  int _ParentLeft;
  int _ParentRight;
  int _ParentTop;
  int _ParentBottom;
  int _ChildHeight = 40;
  
  int get _windowW => window.innerWidth;
  
  int get _windowH => window.innerHeight;
  
  ActionDropper.start() {
    _initValues();
    _startDragListener();
    
    test();
  }
  
  List<List<int>> getActionValues() {
    List<List<int>> actions = new List();
    List<DivElement> children = parent.children;
    
    children.forEach((child) {
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
    
    DivElement pad = querySelector('.your-code');
    _ParentLeft = (_windowW * 0.05 + _windowW * 0.9 * (1/6 + 0.03)).ceil();
    _ParentRight = _ParentLeft + ((_windowW * 0.9) / 6 - 8).floor();
    _ParentTop = (_windowH * 0.03).ceil() + 170;
    _ParentBottom = _ParentTop + 560;
  }
  
  void _startDragListener() {
    int type, offset_x, offset_y, left, top, pos;
    bool isOnDrag = false, isFirst = true;
    LIElement dragged;
    
    for (int i = 0; i < actionDraggers.length; i++) {
      actionDraggers[i].onMouseDown.listen((evt) {
        if (!_isApplying) {
          type = i;
          offset_x = evt.offset.x;
          offset_y = evt.offset.y;
          left = evt.page.x - offset_x;
          top = evt.page.y - offset_y;
          
          dragged = actionDraggers[i].clone(true);
          dragged.style..position = 'absolute'
                       ..zIndex = 1000.toString();
          querySelector('body').children.insert(0, dragged);
          _renderDraggedItem(dragged, left, top);
          
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
          left = evt.page.x - offset_x;
          top = evt.page.y - offset_y;
          _renderDraggedItem(dragged, left, top);
          //_renderDraggedItem(dragged, evt.page.x, evt.page.y);
        }
//        if (_isInDropbox(evt.client.x, evt.client.y)) {
//          if (isFirst) {
//            _lastPos = _getValidPos(evt.client.y);
//            _insertBlankDragger(_lastPos);
//            }
//          else
//            _renderBlankDragger(_getValidPos(evt.client.y));
//        }
      });
  }
  
  void _removeBlankDragger() {
    if (parent.querySelector('#$BLANK_DRAGGER_ID') != null)
      parent.querySelector('#$BLANK_DRAGGER_ID').remove();
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
  
  void _renderDraggedItem(LIElement dragged, int left, int top) {
    dragged.style..left = px(left)
                 ..top = px(top);
  }
  
  bool _isInDropbox(int x, int y)
    => x >= _ParentLeft && x <= _ParentRight && 
       y >= _ParentTop && y <= _ParentBottom;
  
  int _getValidPos(int y) {
    int tempPos = (y - _ParentTop) ~/ _ChildHeight;
    return tempPos <= _actionsCount ? tempPos : _actionsCount;
  }
  
  void _appendAction(int pos, LIElement elem) {
    LIElement newElement = elem.clone(true);
    parent.children.insert(pos, newElement);
    _startDeleteActionListener(newElement);
    _actionsCount++;
  }
  
  void _startDeleteActionListener(LIElement newElement) {
    var listener;
    newElement.querySelector('.del-icon').classes.remove('hidden');
    listener = newElement.querySelector('.del-icon').onClick.listen((_) {
      newElement.remove();
      listener.cancel();
    });
  }

  void test() {
    DivElement a = new DivElement();
    a.style..position = "absolute"
           ..left = px(_ParentLeft)
           ..top = px(_ParentTop)
           ..width = px(_ParentRight - _ParentLeft)
           ..height = px(_ParentBottom - _ParentTop)
           ..backgroundColor = 'pink'
           ..zIndex = '2000';
    querySelector('body').children.insert(0, a);
  }
  
}