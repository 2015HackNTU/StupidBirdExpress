library client.field_name;

import 'dart:html';

const String LEFT_M_IMG = "";
const String RIGHT_M_IMG = "";
const String TOP_M_IMG = "";
const String DOWN_M_IMG = "";
const String BOMB_M_IMG = "";
const String WAIT_M_IMG = "";
const String DANCE_M_IMG = "";


final List<DivElement> Actions = [GoLeft, GoRight, GoTop, GoDown, UseBomb, Wait, Dance];
final List<String> ActionsText = ['Go Left', 'Go Right', 'Go Top', 'Go Down', 'Use Bomb', 'Wait', 'Dance'];

final DivElement GoLeft = querySelector('').clone(true);

final DivElement GoRight = querySelector('').clone(true);

final DivElement GoTop = querySelector('').clone(true);

final DivElement GoDown = querySelector('').clone(true);

final DivElement UseBomb = querySelector('').clone(true);

final DivElement Wait = querySelector('').clone(true);

final DivElement Dance = querySelector('').clone(true);
