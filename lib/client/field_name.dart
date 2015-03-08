library client.field_name;

import 'dart:html';

const int TURN = 0,
          WALK = 1,
          FLY = 2,
          PADDLE = 3,
          HATCH = 4;

const int TYPE = 0,
          TIMES = 1,
          DIRECTION = 2,
          STEPS = 1;

const int ANIMATION_UNIT = 5;

const int DRAGGER_PARENT_LEFT = 0;
const int DRAGGER_PARENT_RIGHT = 0;
const int DRAGGER_PARENT_TOP = 0;
const int DRAGGER_PARENT_BOTTOM = 0;
const int DRAGGER_CHILD_HEIGHT = 0;

const int MAINACTOR_POS_LEFT = 0;
const int MAINACTOR_POS_TOP = 0;

const int DEGREE_UNIT = 45;

//Map id to dragger type
final Map<String, int> Draggers = {"0" : 0, "1" : 1, "2" : 2, "3" : 3, "4" : 4};

//final List<DivElement> ValidAnimations= querySelectorAll('');
//
//final List<DivElement> ValidActions = [Turn, Walk, Fly, Paddle, Hatch];
//
//final DivElement Turn = querySelector('');
//
//final DivElement Walk = querySelector('');
//
//final DivElement Fly = querySelector('');
//
//final DivElement Paddle = querySelector('');
//
//final DivElement Hatch = querySelector('');
