library client.field_name;


///actions list attributes

const int    ACTION_TURN = 0;
const int    ACTION_WALK = 1;
const int     ACTION_FLY = 2;
const int    ACTION_LAND = 3;
const int  ACTION_PADDLE = 4;
const int   ACTION_HATCH = 5;

const int      ACTION_TYPE = 0;
const int     ACTION_TIMES = 1;
const int ACTION_DIRECTION = 2;
const int     ACTION_STEPS = 1;

const int DEGREE_UNIT = 45;


///game timer attributes

const int       TIME_UNIT_PER_IMG = 1;
const int       TIME_UNIT_PER_POS = 4;
const int TIME_UNIT_PER_HIGHLIGHT = 4;
const int               STEP_UNIT = 45;


///main actor attributes

const int IMG_ORIGIN = 0;
const int IMG_WALK = 1;
const int IMG_FLY_1 = 2;
const int IMG_FLY_2 = 3;
const int IMG_FLY_3 = 4;
const int IMG_PADDLE_1 = 5;
const int IMG_PADDLE_2 = 6;
const int IMG_PADDLE_3 = 7;


///map attributes

final List<List<int>> MainActorPos = [[11, 6, 0], [9, 13, 270], [2, 0, 90]];
final List<int> BoatPos = [7, 6];

const int          MAP_WIDTH = 14;
const int         MAP_HEIGHT = 12;

const int MAP_UNFLIPPED_ARBOR_1 = 0;
const int MAP_UNFLIPPED_ARBOR_2 = 1;
const int   MAP_FLIPPED_ARBOR_3 = 2;
const int MAP_UNFLIPPED_ARBOR_4 = 3;
const int      MAP_FLIPPED_BUSH = 4;
const int     MAP_FLIPPED_STRAW = 5;
const int               MAP_EGG = 6;
const int    MAP_UNFLIPPED_TREE = 7;
const int   MAP_BACKGROUND_TREE = 8;
const int            MAP_GROUND = 9;
const int             MAP_RIVER = 10;
const int    MAP_UNFLIPPED_WALL = 11;

const int MAP_POS_ACTION_TYPE = 2;
const int MAP_ITEMS_COUNT = 8;


const int ERROR_OUT_OF_BORDER = 0;
const int         ERROR_DRAWN = 1;
const int      ERROR_HIT_WALL = 2;
const int       ERROR_NOT_FLY = 3;
const int        ERROR_NO_EGG = 4;

///img url

final List<String> MapBackground = [MAPBG_1, MAPBG_2, MAPBG_3];

///path for launching
const String       BOAT = '../source/boat.png';
const String    ARBOR_3 = '../source/arbor3.png';
const String  U_ARBOR_1 = '../source/arbor1.png';
const String  U_ARBOR_2 = '../source/arbor2.png';
const String  U_ARBOR_4 = '../source/arbor4.png';
const String       BUSH = '../source/bush.png';
const String      STRAW = '../source/straw.png';
const String        EGG = '../source/egg.png';
const String     TREE_1 = '../source/tree1.png';
const String     TREE_2 = '../source/tree2.png';
const String     TREE_3 = '../source/tree3.png';
const String     TREE_4 = '../source/tree4.png';

const String    MAPBG_1 = '../source/map1.png';
const String    MAPBG_2 = '../source/map2.png';
const String    MAPBG_3 = '../source/map3.png';

///path for developing
//const String       BOAT = '../../source/boat.png';
//const String    ARBOR_3 = '../../source/arbor3.png';
//const String  U_ARBOR_1 = '../../source/arbor1.png';
//const String  U_ARBOR_2 = '../../source/arbor2.png';
//const String  U_ARBOR_4 = '../../source/arbor4.png';
//const String       BUSH = '../../source/bush.png';
//const String      STRAW = '../../source/straw.png';
//const String        EGG = '../../source/egg.png';
//const String     TREE_1 = '../../source/tree1.png';
//const String     TREE_2 = '../../source/tree2.png';
//const String     TREE_3 = '../../source/tree3.png';
//const String     TREE_4 = '../../source/tree4.png';
//
//const String    MAPBG_1 = '../../source/map1.png';
//const String    MAPBG_2 = '../../source/map2.png';
//const String    MAPBG_3 = '../../source/map3.png';

final List<String> BlockImgs = [U_ARBOR_1, U_ARBOR_2, ARBOR_3, U_ARBOR_4, BUSH, STRAW, EGG, TREE_1, TREE_2, TREE_3, TREE_4];

///static map

final List<List<List<int>>> Maps = [Map_1, Map_2, Map_3];
final List<List<int>> Map_1 = 
[[        MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, 		     MAP_EGG,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, 		  MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, 		  MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, 		  MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE,   MAP_FLIPPED_BUSH,   MAP_FLIPPED_BUSH, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE,   MAP_FLIPPED_BUSH,   MAP_FLIPPED_BUSH, MAP_UNFLIPPED_TREE, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_TREE,         MAP_GROUND,         MAP_GROUND],
 [MAP_UNFLIPPED_WALL,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_WALL],
 [        MAP_GROUND, MAP_UNFLIPPED_WALL,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_WALL,         MAP_GROUND],
 [        MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_WALL,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND,         MAP_GROUND, MAP_UNFLIPPED_WALL,         MAP_GROUND,         MAP_GROUND]];

final List<List<int>> Map_2 = 
[[MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_GROUND, MAP_GROUND, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE],
 [MAP_RIVER, MAP_UNFLIPPED_ARBOR_1, MAP_UNFLIPPED_ARBOR_2, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_GROUND,          MAP_GROUND, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE],
 [MAP_RIVER,   MAP_FLIPPED_ARBOR_3, MAP_UNFLIPPED_ARBOR_4, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER, MAP_GROUND, MAP_GROUND,          MAP_GROUND, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER, MAP_GROUND, MAP_GROUND,          MAP_GROUND, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER, MAP_GROUND, MAP_GROUND,          MAP_GROUND,          MAP_GROUND, MAP_BACKGROUND_TREE, MAP_BACKGROUND_TREE],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER, MAP_GROUND, MAP_GROUND,          MAP_GROUND,          MAP_GROUND,          MAP_GROUND, MAP_BACKGROUND_TREE],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER, MAP_GROUND, MAP_GROUND,          MAP_GROUND,          MAP_GROUND,          MAP_GROUND,          MAP_GROUND],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER, MAP_GROUND,          MAP_GROUND,          MAP_GROUND,          MAP_GROUND,          MAP_GROUND],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,           MAP_RIVER,          MAP_GROUND,          MAP_GROUND,          MAP_GROUND],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,           MAP_RIVER,           MAP_RIVER,          MAP_GROUND,          MAP_GROUND],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,           MAP_RIVER,           MAP_RIVER,          MAP_GROUND,          MAP_GROUND],
 [MAP_RIVER,             MAP_RIVER,             MAP_RIVER, MAP_RIVER, MAP_RIVER, MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,           MAP_RIVER,           MAP_RIVER,          MAP_GROUND,          MAP_GROUND]];


final List<List<int>> Map_3 = 
[[MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_FLIPPED_STRAW,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_FLIPPED_STRAW, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_FLIPPED_STRAW,        MAP_GROUND,        MAP_GROUND,           MAP_EGG,        MAP_GROUND,        MAP_GROUND, MAP_FLIPPED_STRAW, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_FLIPPED_STRAW,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_FLIPPED_STRAW, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW,        MAP_GROUND, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_FLIPPED_STRAW, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER, MAP_GROUND, MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND,  MAP_RIVER,  MAP_RIVER,  MAP_RIVER,         MAP_RIVER,         MAP_RIVER,         MAP_RIVER,         MAP_RIVER,         MAP_RIVER,         MAP_RIVER,         MAP_RIVER,  MAP_RIVER,  MAP_RIVER],
 [MAP_GROUND, MAP_GROUND, MAP_GROUND, MAP_GROUND, MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_GROUND, MAP_GROUND],
 [MAP_GROUND, MAP_GROUND, MAP_GROUND, MAP_GROUND, MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND,        MAP_GROUND, MAP_GROUND, MAP_GROUND]];

