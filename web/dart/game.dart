library client.game;

import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'dart:js' as js;

import 'package:StupidBirdExpress/client/field_name.dart';
import 'package:StupidBirdExpress/client/level_map.dart';
import 'package:StupidBirdExpress/client/action_dropper.dart';
import 'package:StupidBirdExpress/client/motion_controller.dart';

String id;

int rand;
LevelMap map;
ActionDropper dropper;
MotionGenerator mGenerator;

void main() {
  id = getPlayerId(window.location);
  
  if (id == null) {
      window.location.replace('../error/');
      return;
  }
  
  checkID().then((bool isValidID) {
    if (isValidID) {
      startGame();
    }
  }).catchError((ex) {
    window.location.replace('../error/');
    return;
  });
}

String getPlayerId(Location location) 
  => location.search.isEmpty ? null : location.search.substring(1);

Future checkID() {
  final Completer cmpl = new Completer();
  
  var ok = (response) => cmpl.complete(response);
  var fail = (error) => cmpl.completeError(error);
  
  js.context.callMethod('isDone', [id, true, ok, fail]);
  
  return cmpl.future;
}

void startGame() {
  rand = new Random().nextInt(Maps.length);
  map = new LevelMap(MainActorPos[rand], Maps[rand], rand == 1);
  mGenerator = new MotionGenerator();
  setMapBackground();
  
  dropper = new ActionDropper.start();
  startInfoBtnListener();
  startRunBtnListener(dropper);
}

void setMapBackground() {
  ImageElement img = querySelector('.map-image');
  img.src = MapBackground[rand];
}

void startInfoBtnListener() {
  querySelector('#show-alert').onClick.listen((_) => dropper.infoIsClicked = !dropper.infoIsClicked);
}

void startRunBtnListener(ActionDropper dropper) {
    querySelector('.your-code .run-btn').onClick.listen((_) {
    reset();
    
    dropper.allowDragging = false;
    
    try {
      List<List<int>> actions = dropper.getActionValues();
      
      if (actions.isNotEmpty) {
        List<List<int>> pos = mGenerator.generatePos(actions);
        List<List<int>> animate = mGenerator.generateAnimation(actions);
        List<int> highlight = mGenerator.generateHighlight(actions);
        
        map.startMove(pos, animate, highlight);
      }
    } catch (e) {
      querySelector('.invalid').classes.remove('disappear');
    }

    dropper.allowDragging = true;
  });
}

void reset() {
  map.resetPos();
  mGenerator.degree = MainActorPos[rand][2];
  querySelector('.invalid').classes.add('disappear');
}