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
  
  if (id == null)
    window.location.href = 'error.html';
  else if(id == 'demo')
    startGame();
  else {
    checkID().then((bool isDoneID) {
      if (!isDoneID)
        startGame();
      else
      window.location.href = 'complete.html';
    }).catchError((ex) {
      window.location.href = 'error.html';
    });
  }
}

String getPlayerId(Location location) 
  => location.search.isEmpty ? null : location.search.substring(4);

Future checkID() {
  final Completer cmpl = new Completer();
  
  var ok = (response) => cmpl.complete(response);
  var fail = (error) => cmpl.completeError(error);
  
  js.context.callMethod('isDone', [id, ok, fail]);
  
  return cmpl.future;
}

void startGame() {
  rand = new Random().nextInt(Maps.length);
  map = new LevelMap(id, MainActorPos[rand], Maps[rand], rand == 1);
  mGenerator = new MotionGenerator();
  setMapBackground();
  
  dropper = new ActionDropper.start();
  startRunBtnListener();
  
}

void setMapBackground() {
  ImageElement img = querySelector('.map-image');
  img.src = MapBackground[rand];
}

void startRunBtnListener() {
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
