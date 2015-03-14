library client.level_map;

import 'dart:html';
import 'dart:math';
import "field_name.dart";

class LevelMap {
  List<List<int>> map;
  List<List<DivElement>> mapBlock;

  List<ImageElement> mainActorImgs;
  DivElement mainActor;
  int mainActorLeft;
  int mainActorTop;
  int degree;

  bool isMap2;

  DivElement _boat;
  int _boatLeft = 7;
  int _boatTop = 6;
  
  
  LevelMap(List actorInfo, this.map, this.isMap2) {
    this.mainActorTop = actorInfo[0];
    this.mainActorLeft = actorInfo[1];
    this.degree = actorInfo[2];
    
    _createBlocks();
    _genImgs();
    if (isMap2) {
      DivElement boat = querySelector('.boat');
      boat.querySelector('img').classes.remove('disappear');
      boat.style..left = '${_boatLeft * STEP_UNIT}px'
                ..top = '${_boatTop * STEP_UNIT}px';
    }
  }

  void setMainActorPos() {
    mainActorImgs = querySelectorAll('.game-blocks .stupid-bird img');
    mainActorImgs[IMG_ORIGIN].classes.remove('disappear');
    
    mainActor = querySelector('.stupid-bird');
    mainActor.style..left = '${mainActorLeft * STEP_UNIT}px'
                   ..top = '${mainActorTop * STEP_UNIT}px'
                   ..transform = 'rotate(${degree}deg)';
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
                   ..height = '45px';
          
          mapBlock[i][j].children.insert(0, img);
          
          if (map[i][j] == MAP_FLIPPED_ARBOR_3) {
            ImageElement img = new ImageElement();
            img.src = BlockImgs[MAP_EGG];
            img.style..width = '45px'
                     ..height = '45px'
                     ..position = 'absolute';
            
            mapBlock[i][j].children.insert(0, img);
          }
        }
      }
    }
  }
  
  void _move(int hor, int ver) {
    mainActorLeft += hor;
    mainActorTop += ver;
  }
  
  List _isValidMove(int hor, int ver, int type) {
    int x = mainActorLeft + hor;
    int y = mainActorTop + ver;
    if (x < 0 || x >= MAP_WIDTH || y < 0 || y >= MAP_HEIGHT)
      return [false, ERROR_OUT_OF_BORDER, "I can't go out of the map!"];
    
    switch (type) {
      case ACTION_TURN:
        return [true];
        
      case ACTION_WALK:
      case ACTION_LAND:
        if (map[y][x] == MAP_RIVER) {
          if (isMap2) {
            //TODO: boat
          } else
            return [false, ERROR_DRAWN, "Help me brabrabra......!"];
        } else if (map[y][x] == MAP_EGG || map[y][x] == MAP_FLIPPED_ARBOR_3)
          return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
        else if (map[y][x] == MAP_FLIPPED_BUSH || map[y][x] == MAP_FLIPPED_STRAW)
          return [false, ERROR_NOT_FLY, "I should fly through it!!!"];
        else if (map[y][x] == MAP_UNFLIPPED_ARBOR_1 ||
                 map[y][x] == MAP_UNFLIPPED_ARBOR_2 ||
                 map[y][x] == MAP_UNFLIPPED_ARBOR_4 ||
                 map[y][x] == MAP_UNFLIPPED_TREE ||
                 map[y][x] == MAP_BACKGROUND_TREE ||
                 map[y][x] == MAP_UNFLIPPED_WALL)
          return [false, ERROR_HIT_WALL, "I hurt my face Q_q(#"];
        return [true];
        
      case ACTION_FLY:
        if (map[y][x] == MAP_UNFLIPPED_ARBOR_1 ||
            map[y][x] == MAP_UNFLIPPED_ARBOR_2 ||
            map[y][x] == MAP_UNFLIPPED_ARBOR_4 ||
            map[y][x] == MAP_UNFLIPPED_TREE ||
            map[y][x] == MAP_BACKGROUND_TREE ||
            map[y][x] == MAP_UNFLIPPED_WALL)
          return [false, ERROR_HIT_WALL, "I hurt my face Q_q(#"];
        return [true];
        
      case ACTION_PADDLE:
        if (isMap2) {
          //TODO:
          return([false]);
        }
        else {
          if (map[y][x] == MAP_GROUND)
            return [false, ERROR_DRAWN, "My wings get dirty QAQ"];
          else if (map[y][x] == MAP_RIVER)
            return [false, ERROR_DRAWN, "Help me brabrabra......!"];
          else if (map[y][x] == MAP_EGG || map[y][x] == MAP_FLIPPED_ARBOR_3)
            return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
          else if (map[y][x] == MAP_FLIPPED_BUSH || map[y][x] == MAP_FLIPPED_STRAW)
            return [false, ERROR_NOT_FLY, "I should fly through it!!!"];
          else if (map[y][x] == MAP_UNFLIPPED_ARBOR_1 ||
                   map[y][x] == MAP_UNFLIPPED_ARBOR_2 ||
                   map[y][x] == MAP_UNFLIPPED_ARBOR_4 ||
                   map[y][x] == MAP_UNFLIPPED_TREE ||
                   map[y][x] == MAP_BACKGROUND_TREE ||
                   map[y][x] == MAP_UNFLIPPED_WALL)
          return [false, ERROR_HIT_WALL, "I hurt my face Q_q(#"];
        }
        return([false]);        
      case ACTION_HATCH:
        if (map[y][x] != MAP_EGG && map[y][x] != MAP_FLIPPED_ARBOR_3)
          return [false, ERROR_NO_EGG, "Oops my bun bun!"];
        return [true];
        
      default:
        return([false]);
    } 
  }
}
