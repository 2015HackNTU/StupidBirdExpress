library client.action_dropper;

import 'dart:html';

import "util.dart";
import "field_name.dart";

class ActionDropper {
  bool allowDragging;
  UListElement parent;
  List<LIElement> actionDraggers;
  
  bool _isOnDrag;
  LIElement _dragged;
  LIElement _inserted;
  
  int _ChildHeight = 40;
  bool infoIsClicked;
  
  int get _windowW => window.innerWidth;
  
  int get _windowH => window.innerHeight;
  

  int get _ParentLeft => (_windowW * 0.05 + _windowW * 0.9 * (1/6 + 0.03)).ceil() - 10;
  int get _ParentRight => _ParentLeft + ((_windowW * 0.9) / 6 - 8).floor() + 20;
  int get _ParentTop => (_windowH * 0.03).ceil() + 160 + (infoIsClicked ? 62 : 0);
  int get _ParentBottom => _ParentTop + 580;
    
  List<LIElement> get _children => parent.querySelectorAll('.b-action');
  
  int get _actionsCount => _children == null ? 0 : _children.length;
  
  ActionDropper.start() {
    _initValues();
    _startDragListener();
    
    //test();
  }
  
  List<List<int>> getActionValues() {
    List<List<int>> actions = new List();
    
    _children.forEach((child) {
      if (child.classes.contains('b-turn')) {
        int degree = numParser(child.querySelector('select').value, 1);
        int times = degree.abs() ~/ DEGREE_UNIT;
        int direction = degree > 0 ? 1 : -1;
        actions.add([ACTION_TURN, times, direction]);
      } else if (child.classes.contains('b-walk')) {
        int steps = int.parse(child.querySelector('input').value);
        actions.add([ACTION_WALK, steps]);
      } else if (child.classes.contains('b-fly')) {
        actions.add([ACTION_FLY]);
      } else if (child.classes.contains('b-paddle')) {
        int steps = int.parse(child.querySelector('input').value);
        actions.add([ACTION_PADDLE, steps]);
      } else if (child.classes.contains('b-hatch')) {
        actions.add([ACTION_HATCH]);
      } else
        print('unknown action type');
    });
    
    return actions;
  }
  
  void _initValues() {
    parent = querySelector('.your-code .list-group');
    actionDraggers = querySelectorAll('.code-sample .b-action');
    allowDragging = true;
    _isOnDrag = false;
    infoIsClicked = false;
    
    DivElement pad = querySelector('.your-code');
  }
  
  void _startDragListener() {
    int offset_x, offset_y, left, top, pos;
    bool isFirst = true;
    
    void startMouseDownListener(Element elem, bool isSample) {
      elem.querySelector('.move-tag').onMouseDown.listen((evt) {
        if (allowDragging) {
          offset_x = evt.offset.x;
          offset_y = evt.offset.y;
          left = evt.page.x - offset_x;
          top = evt.page.y - offset_y;
          
          _dragged = elem.clone(true);
          _inserted = elem.clone(true);
          _dragged.style..position = 'absolute'
                       ..zIndex = 1000.toString();
          querySelector('body').children.insert(0, _dragged);
          _renderDraggedItem(_dragged, left, top);
          
          if (!isSample)
            elem.remove();
          
          _isOnDrag = true;
        }
      });
    }
    
    for (int i = 0; i < actionDraggers.length; i++)
      startMouseDownListener(actionDraggers[i], true);
    
    document
      ..onMouseUp.listen((evt) {
        if (_isOnDrag) {
          _dragged.remove();
          
          if (_isInDropbox(evt.page.x, evt.page.y)) {
            LIElement newElem = _appendAction(_getValidPos(evt.page.y), _inserted);
            startMouseDownListener(newElem, false);
          }
          _isOnDrag = false;
          isFirst = true;
          _clearBorder();
        }
      })
      ..onMouseMove.listen((evt) {
      _clearBorder();
        if (_isOnDrag) {
          left = evt.page.x - offset_x;
          top = evt.page.y - offset_y;
          _renderDraggedItem(_dragged, left, top);
          
          if (_isInDropbox(evt.page.x, evt.page.y)) {
            if (_actionsCount >= 1) {
              if (_getValidPos(evt.page.y) == 0)
                _children[0].style.borderTop = '2px solid #cc0000';
              else {
                for (int i = 0; i < _children.length; i++) {
                  if (_getValidPos(evt.page.y) == i + 1)
                    _children[i].style.borderBottom = '2px solid #cc0000';
                }
              }
            }
          }
        }
      });
  }
  
  void _clearBorder() {
    for (int i = 0; i < _children.length; i++) {
      _children[i].style..borderTop = '0'
                        ..borderBottom = '1px dashed #cc0000';
    }
  }
  
  void _renderDraggedItem(LIElement dragged, int left, int top) {
    dragged.style..left = px(left)
                 ..top = px(top);
  }
  
  bool _isInDropbox(int x, int y)
    => x >= _ParentLeft && x <= _ParentRight && y >= _ParentTop && y <= _ParentBottom;
  
  int _getValidPos(int y) {
    int tempPos = ((y - _ParentTop - 10) / _ChildHeight).round();
    return tempPos <= _actionsCount ? tempPos : _actionsCount;
  }
  
  LIElement _appendAction(int pos, LIElement elem) {
//    print('insert ${elem.text}');
    
    LIElement newElement = elem.clone(true);
    parent.children.insert(pos, newElement);
    _startDeleteActionListener(newElement);
    return newElement;
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