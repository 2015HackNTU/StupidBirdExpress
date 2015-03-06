library client.motion_cotroller;

import 'dart:html';
import 'dart:math';

import "field_name.dart";

class MotionController {
  DivElement mainActor;
  ImageElement img;
  List<String> imgSrcs;
  
  int get _windowW => window.innerWidth;
  
  int get _iwndowH => window.innerHeight;
  
  int get _curL => int.parse(mainActor.style.left.substring(0, mainActor.style.left.length - 2));

  int get _curT => int.parse(mainActor.style.top.substring(0, mainActor.style.top.length - 2));
  
  int get _projectW => sin(_stepL).toInt();
  
  int get _projectH => -cos(_stepL).toInt();
  
  int _stepL;
  
  MotionController() {
    _stepL = (_windowW * 0.09).toInt();
  }
  
  void turn(double degree) {}
  
  void walk(int steps) {
    
  }
  
  void goLeft() {
    mainActor.style.left = _px(_curL - _stepL);
    _replaceImg(LEFT_M_IMG);
  }
  
  void goRight() {
    mainActor.style.left = _px(_curL + _stepL);
    _replaceImg(RIGHT_M_IMG);
  }
  
  void goTop() {
    mainActor.style.top = _px(_curT - _stepL);
    _replaceImg(TOP_M_IMG);
  }
  
  void goDown() {
    mainActor.style.top = _px(_curT + _stepL);
    _replaceImg(DOWN_M_IMG);
  }
  
  void useBomb() {
    _replaceImg(BOMB_M_IMG);
  }
  
  void wait() {
    _replaceImg(WAIT_M_IMG);
  }
  
  void dance() {
    _replaceImg(DANCE_M_IMG);
  }
  
  void _replaceImgs(List<String> srcs) {
    imgSrcs = [];
    //TODO: add image field names
  }
  
  String _px(int n) => '${n}px';
}