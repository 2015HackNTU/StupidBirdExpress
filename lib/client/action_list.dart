library client.action_list;

import 'dart:html';

import "field_name.dart";

class ActionList {
  DivElement parent;
  List<DivElement> actionDraggers;
  List<int> acts;

  List<DivElement> get actionElems => parent.children;
  
  List _listeners;
  
  ActionList() {
    parent = querySelector('');
    actionDraggers = querySelectorAll('');
  }
  
  void appendAction(int actionType) {
    DivElement target = Actions[actionType].clone(true);
    target.classes.remove('.hidden');
    target.text = ActionsText[actionType];
    parent.children.add(target);
  }
  
  void startDragListener() {
    actionDraggers.forEach((dragger) {
      dragger.onDragEnd.listen((e) {
        if (e.screen.x) {}
      });
    });
  }
  
  void startDeleteActionListener() {
    _listeners.forEach((listener) => listener.cancel());
    
    actionElems.forEach((e) {
      var listener = e.querySelector('.remove').onClick.listen((_) {
        e.remove();
      });
      _listeners.add(listener);
    });
  }
  
  void applyAction() {
    acts = new List(actionElems.length);
  }
  
  bool _isValidDrag(int left, int top)
    => left > parent.style.left && left < parent.style.right; 
}