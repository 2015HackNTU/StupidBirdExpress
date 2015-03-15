library client.level_map;

import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'dart:js' as js;

import "field_name.dart";

class LevelMap {
  String id;
  bool isText;
  
  List<List<int>> map;
  List<List<DivElement>> mapBlock;

  List<ImageElement> mainActorImgs;
  DivElement mainActor;
  int mainActorLeft;
  int mainActorTop;
  int degree;

  bool isMap2;

  DivElement _boat;
  DivElement _flower;
  DivElement _message;
  ButtonElement _completeBtn;
  int _boatLeft;
  int _boatTop;
  bool _isOnBoat;
  bool _isComplete;
  
  List _actorInfo;
  
  List<LIElement> get _children => querySelectorAll('.your-code .list-group .b-action');  
  
  LevelMap(this._actorInfo, this.map, this.isMap2) {
    mainActor = querySelector('.stupid-bird');
    mainActorImgs = querySelectorAll('.game-blocks .stupid-bird img');
    _boat = querySelector('.boat');
    _flower = querySelector('.flower');
    _message = querySelector('.message');
    _completeBtn = querySelector('.complete-btn');
    _isOnBoat = false;
    
    _createBlocks();
    _genImgs();

    resetPos();

    //TODO: remove it
    _completeBtn.click();
  }
  
  void resetPos() {
    mainActorTop = _actorInfo[0];
    mainActorLeft = _actorInfo[1];
    degree = _actorInfo[2];
    
    _hideImgs();
    _showImg(IMG_ORIGIN);
    
    mainActorImgs[IMG_ORIGIN].classes.remove('disappear');
    _flower.querySelector('img').classes.add('disappear');
    _message.classes.add('disappear');
    
    mainActor.style..left = '${mainActorLeft * STEP_UNIT}px'
                   ..top = '${mainActorTop * STEP_UNIT}px'
                   ..transform = 'rotate(${degree}deg)';
    
    if (isMap2) {
      _boatLeft = BoatPos[0];
      _boatTop = BoatPos[1];
      _isOnBoat = false;
      _isComplete = false;
      
      _boat.querySelector('img').classes.remove('disappear');
      _boat.style..left = '${_boatLeft * STEP_UNIT}px'
                 ..top = '${_boatTop * STEP_UNIT}px'
                 ..transform = 'rotate(0deg)';
    }   
  }
  
  void startMove(List<List<int>> pos, List<List<int>> imgs, List<int> highlight) {
    Timer timer;
    int state = 0;
    List response;
    
    timer = new Timer.periodic(new Duration(milliseconds: 150), (_) {
      int posState = state ~/ TIME_UNIT_PER_POS;
      int imgState = state % TIME_UNIT_PER_POS;
      bool isValid = true;
      
      if (imgState == 0) {   
        //add highlight
        if (highlight[posState] == 0)
          _addRunningStatus(_children[highlight[posState]]);
        else if (highlight[posState] != highlight[posState - 1]) {
          _removeRunningStatus(_children[highlight[posState - 1]]);
          _addRunningStatus(_children[highlight[posState]]);
        }
        
        //checkPos        
        response = _isValidMove(pos[posState][0], pos[posState][1], pos[posState][2]);
        isValid = response[0];
        //print(response);   
      }
      
      if (isValid) {
        _setPos(pos[posState][0], pos[posState][1], imgState, _isOnBoat && imgs[posState][ACTION_TYPE] == ACTION_PADDLE);
        
        switch (imgs[posState][ACTION_TYPE]) {
          case ACTION_TURN:
            _hideImgs();
            _showImg(IMG_ORIGIN);
            
            if (imgState == 0) {
              degree += imgs[posState][1] * 12;
              mainActor.style.transform = 'rotate(${degree}deg)';
              if (_isOnBoat)
                _boat.style.transform = 'rotate(${degree - 270}deg)';
            } else {
              degree += imgs[posState][1] * 11;
              mainActor.style.transform = 'rotate(${degree}deg)';
              if (_isOnBoat)
                _boat.style.transform = 'rotate(${degree - 270}deg)';
            }
            break;
            
          case ACTION_WALK:
            _hideImgs();
            _showImg(state % 2 == 0 ? IMG_ORIGIN : IMG_WALK);
            break;
            
          case ACTION_FLY:
            _hideImgs();
            if (imgState == 0)
              _showImg(IMG_ORIGIN);
            else if (imgState == 1)
              _showImg(IMG_FLY_1);
            else if (imgState == 2)
              _showImg(IMG_FLY_2);
            else if (imgState == 3)
              _showImg(IMG_FLY_3);
            break;
            
          case ACTION_LAND:
            _hideImgs();
            if (imgState == 0)
              _showImg(IMG_FLY_3);
            else if (imgState == 1)
              _showImg(IMG_FLY_2);
            else if (imgState == 2)
              _showImg(IMG_FLY_1);
            else if (imgState == 3)
              _showImg(IMG_ORIGIN);
            break;
            
          case ACTION_PADDLE:
            _hideImgs();
            if (imgState == 0)
              _showImg(IMG_PADDLE_1);
            else if (imgState == 1)
              _showImg(IMG_PADDLE_2);
            else if (imgState == 2)
              _showImg(IMG_PADDLE_3);
            else if (imgState == 3)
              _showImg(IMG_PADDLE_2);
            break;
            
          case ACTION_HATCH:
            _hideImgs();
            _showImg(IMG_ORIGIN);
            _isComplete = true;
            break;
        }
      } else {        
        switch (response[1]) {
          case ERROR_OUT_OF_BORDER:
          case ERROR_HIT_WALL:
          case ERROR_NOT_FLY:
            _hideImgs();
            _showImg(IMG_ORIGIN);
            break;
            
          case ERROR_DRAWN:
            _setPos(pos[posState][0], pos[posState][1], 3, false);
            _hideImgs();

            _flower.querySelector('img').classes.remove('disappear');
            _flower.style..left = '${mainActorLeft * STEP_UNIT}px'
                         ..top = '${mainActorTop * STEP_UNIT}px';
            break;
            
          case ERROR_NO_EGG:
            _hideImgs();
            _showImg(IMG_ORIGIN);
            break;
        }
        _message.text = response[2];
        _message.classes.remove('disappear');
        _message.style..left = '${mainActorLeft * STEP_UNIT}px'
                      ..top = '${mainActorTop * STEP_UNIT + STEP_UNIT}px';
        
        _removeRunningStatus(_children[highlight[posState]]);
        timer.cancel();
      }
      
      if (state == imgs.length * TIME_UNIT_PER_POS - 1) {
        _removeRunningStatus(_children[highlight[posState]]);
        timer.cancel();
        if (_isComplete) {
          _completeBtn.click();
          _renderCompletePage();
        }
      }
      state++;
      _isComplete = false;
    }); 
  }
  
  void _addRunningStatus(Element elem) {
    elem.style.backgroundColor = '#ddd';
  }

  void _removeRunningStatus(Element elem) {
    elem.style.backgroundColor = 'white';
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
//          ..style.boxSizing = 'border-box'
//          ..style.border = '1px solid black'
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
  
  void _setPos(int hor, int ver, int state, bool moveBoat) {
    if (state == 0) {
      mainActor.style..left = '${mainActorLeft * STEP_UNIT + hor * 11}px'
                     ..top = '${mainActorTop * STEP_UNIT + ver * 11}px';
      if (moveBoat) {
        _boat.style..left = '${mainActorLeft * STEP_UNIT + hor * 11}px'
                   ..top = '${mainActorTop * STEP_UNIT + ver * 11}px';
      }
    } else if (state == 1) {
      mainActor.style..left = '${mainActorLeft * STEP_UNIT + hor * 22}px'
                     ..top = '${mainActorTop * STEP_UNIT + ver * 22}px';
      if (moveBoat) {
        _boat.style..left = '${mainActorLeft * STEP_UNIT + hor * 22}px'
                   ..top = '${mainActorTop * STEP_UNIT + ver * 22}px';
      }
    } else if (state == 2) {
      mainActor.style..left = '${mainActorLeft * STEP_UNIT + hor * 33}px'
                     ..top = '${mainActorTop * STEP_UNIT + ver * 33}px';
      if (moveBoat) {
        _boat.style..left = '${mainActorLeft * STEP_UNIT + hor * 33}px'
                   ..top = '${mainActorTop * STEP_UNIT + ver * 33}px';
      }
    } else {
      mainActorLeft += hor;
      mainActorTop += ver;
      
      mainActor.style..left = '${mainActorLeft * STEP_UNIT}px'
                     ..top = '${mainActorTop * STEP_UNIT}px';
      if (moveBoat) {
        _boat.style..left = '${mainActorLeft * STEP_UNIT}px'
                   ..top = '${mainActorTop * STEP_UNIT}px';
      }
    }
    
  }
  
  void _hideImgs() {
    for (int i = 0; i < mainActorImgs.length; i++)
      mainActorImgs[i].classes.add('disappear');
  }
  
  void _showImg(int target) {
    mainActorImgs[target].classes.remove('disappear');
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
            if (x == _boatLeft && y == _boatTop) {
              _isOnBoat = true;
              return [true];
            }
          }
          return [false, ERROR_DRAWN, "Help me plz! brabrabra......"];
        } else if (map[y][x] == MAP_FLIPPED_BUSH || map[y][x] == MAP_FLIPPED_STRAW)
          return [false, ERROR_NOT_FLY, "I should fly through it!"];
        else if (map[y][x] == MAP_UNFLIPPED_ARBOR_1 ||
                 map[y][x] == MAP_UNFLIPPED_ARBOR_2 ||
                 map[y][x] == MAP_UNFLIPPED_ARBOR_4 ||
                 map[y][x] == MAP_UNFLIPPED_TREE ||
                 map[y][x] == MAP_BACKGROUND_TREE ||
                 map[y][x] == MAP_UNFLIPPED_WALL)
          return [false, ERROR_HIT_WALL, "I hurt my face woowoo Q_q(#"];
        return [true];
        
      case ACTION_FLY:
        if (map[y][x] == MAP_UNFLIPPED_ARBOR_1 ||
            map[y][x] == MAP_UNFLIPPED_ARBOR_2 ||
            map[y][x] == MAP_UNFLIPPED_ARBOR_4 ||
            map[y][x] == MAP_UNFLIPPED_TREE ||
            map[y][x] == MAP_BACKGROUND_TREE ||
            map[y][x] == MAP_UNFLIPPED_WALL)
          return [false, ERROR_HIT_WALL, "I hurt my face woowoo Q_q(#"];
        return [true];
        
      case ACTION_PADDLE:
        if (isMap2) {
          if (_isOnBoat && map[y][x] == MAP_RIVER)
            return [true];
        }
        if (map[y][x] == MAP_GROUND)
          return [false, ERROR_DRAWN, "My wings are getting dirty QAQ"];
        else if (map[y][x] == MAP_RIVER)
          return [false, ERROR_DRAWN, "Help me plz! brabrabra......"];
        else if (map[y][x] == MAP_FLIPPED_BUSH || map[y][x] == MAP_FLIPPED_STRAW)
          return [false, ERROR_NOT_FLY, "I should fly through it!!!"];
        else
          return [false, ERROR_HIT_WALL, "I hurt my face woowoo Q_q(#"];
        return [false];
        
      case ACTION_HATCH:
        if (map[y][x] != MAP_EGG && map[y][x] != MAP_FLIPPED_ARBOR_3)
          return [false, ERROR_NO_EGG, "My bun bun touches the ground!"];
        return [true];
        
      default:
        return([false]);
    } 
  }
  
  void _renderCompletePage() {
    _getMessage()
    .then((response) {})
    .catchError((ex) {});
  }
  
  Future _getMessage() {
    final Completer cmpl = new Completer();
    
    var ok = (response) => cmpl.complete(response);
    var fail = (error) => cmpl.completeError(error);
    
    js.context.callMethod('downloadMsg', [id, ok, fail]);
    
    return cmpl.future;
  }
}
