library client.field_name;

const int ACTION_TURN = 0;
const int ACTION_WALK = 1;
const int ACTION_FLY = 2;
const int ACTION_PADDLE = 3;
const int ACTION_HATCH = 4;

const int ACTION_TYPE = 0;
const int ACTION_TIMES = 1;
const int ACTION_DIRECTION = 2;
const int ACTION_STEPS = 1;

const int TIME_UNIT_PER_IMG = 1;
const int TIME_UNIT_PER_POS = 4;
const int TIME_UNIT_PER_HIGHLIGHT = 4;
const int DEGREE_UNIT = 45;

const int DRAGGER_PARENT_LEFT = 0;
const int DRAGGER_PARENT_RIGHT = 0;
const int DRAGGER_PARENT_TOP = 0;
const int DRAGGER_PARENT_BOTTOM = 0;
const int DRAGGER_CHILD_HEIGHT = 0;

const int MAINACTOR_POS_LEFT = 0;
const int MAINACTOR_POS_TOP = 0;

//Map id to dragger type
final Map<String, int> Draggers = {"0" : 0, "1" : 1, "2" : 2, "3" : 3, "4" : 4};


///map attributes

const int MAP_WIDTH = 0;
const int MAP_HEIGHT = 0;

const int OBSTICLE_NONE = 0;
const int OBSTICLE_BORDER = 1;
const int OBSTICLE_ROCK = 2;
const int OBSTICLE_RIVER = 3;
const int OBSTICLE_EGG = 4;

const String BLANK_DRAGGER_ID = "blank-dragger";

