library client.level_map;

import 'dart:html';
import 'dart:math';
import "field_name.dart";

class LevelMap {
  List<List<int>> map;
  List<List<DivElement>> mapBlock;

  DivElement mainActor;
  int mainActorLeft;
  int mainActorTop;
  
  LevelMap(this.mainActorTop, this.mainActorLeft, this.map) {
    _createBlocks();
    _genImgs();
    _setMainActorPos();
  }
  
  List generateMockMove(List<List<int>> pos) {
    List mockMove = new List();
    
    for (int i = 0; i < pos.length; i++) {
      int left = pos[i][0];
      int top = pos[i][1];
      int type = pos[i][2];
      List response = _isValidMove(left, top, type);
      
      if (response[0])
        _move(left, top);
      mockMove.add(response);
    }
    
    return mockMove;
  }
  
  void _createBlocks() {
    DivElement gameBlocks = querySelector('.game-blocks');
    
    mapBlock = new List(MAP_HEIGHT);
    for (int i = 0; i < MAP_HEIGHT; i++) {
      mapBlock[i] = new List(MAP_WIDTH);
      for (int j = 0; j < MAP_WIDTH; j++) {
        mapBlock[i][j] = new DivElement();
        mapBlock[i][j]
          ..style.left = '${j * STEP_UNIT}px'
          ..style.top = '${i * STEP_UNIT}px'
          ..classes.add('block');
               
       gameBlocks.children.insert(0, mapBlock[i][j]);
      }
    }
    
  }
  
  void _genImgs() {
    for (int i = 0; i < MAP_HEIGHT; i++) {
      for (int j = 0; j < MAP_WIDTH; j++) {
        if (map[i][j] <= MAP_ITEMS_COUNT) {
          ImageElement img = new ImageElement();
          img.src = map[i][j] != MAP_UNFLIPPED_TREE ? BlockImgs[map[i][j]] 
                                                    : BlockImgs[map[i][j] + new Random().nextInt(4)];
          img.style..width = '45px'
                   ..height = map[i][j] == MAP_BOAT ? 'auto 45px' : '45px 45px';
          
          mapBlock[i][j].children.insert(0, img);
        }
      }
    }
  }
  
  void _setMainActorPos() {
    mainActor = querySelector('.stupid-bird');
    mainActor.style..left = '${mainActorLeft * STEP_UNIT}px'
                   ..top = '${mainActorTop * STEP_UNIT}px';
  }
  
  void _move(int hor, int ver) {
    mainActorLeft += hor;
    mainActorTop += ver;
  }
  
  List _isValidMove(int hor, int ver, int type) {
    int x = mainActorLeft + hor;
    int y = mainActorTop + ver;
    if (x >= 0 && x < MAP_WIDTH && y >= 0 && y < MAP_HEIGHT)
      return [false, ERROR_OUT_OF_BORDER, "I can't go out of the map!"];
    
    switch (type) {
      case ACTION_TURN:
        return [true];
      case ACTION_WALK:
        if (map[x][y] == MAP_RIVER)
          return [false, ERROR_DRAWN, "Help me brabrabra......!"];
        else if (map[x][y] == MAP_BOAT)
          return [false, ERROR_HIT_WALL, "I hurt my face Q_q(#"];
        else if (map[x][y] == MAP_EGG)
          return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
        return [true];
        
      case ACTION_FLY:
        if (map[x][y] == MAP_RIVER)
          return [false, ERROR_DRAWN, "Help me brabrabra......!"];
        else if (map[x][y] == MAP_BOAT)
          return [false, ERROR_HIT_WALL, "I can see so far ~~~"];
        else if (map[x][y] == MAP_EGG)
          return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
        return [true];
        
      case ACTION_PADDLE:
        if (map[x][y] == MAP_GROUND)
          return [false, ERROR_DRAWN, "My wings get dirty QAQ"];
        else if (map[x][y] == MAP_BOAT)
          return [false, ERROR_HIT_WALL, "I hurt my face Q_q(#"];
        else if (map[x][y] == MAP_EGG)
          return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
        return [true];
        
      case ACTION_HATCH:
        if (map[x][y] != MAP_EGG)
          return [false, ERROR_NO_EGG, "Sexy squat >.0"];
        return [true];
        
      default:
        return([false]);
    } 
  }
}
