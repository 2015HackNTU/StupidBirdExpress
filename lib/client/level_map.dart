library client.level_map;

import "field_name.dart";

class LevelMap {
  List<List<int>> map;
  int mainActorLeft;
  int mainActorTop;
  
  
  LevelMap(this.mainActorLeft, this.mainActorTop) {
    map = new List(MAP_WIDTH);
    for (int i = 0; i < MAP_WIDTH; i++)
      map[i] = new List(MAP_HEIGHT);
  }
  
  void fillGround() {
    for (int i = 0; i < MAP_WIDTH; i++)
      for (int j = 0; j < MAP_HEIGHT; i++)
        map[i][j] = MAP_GROUND;
  }
  
  void fillRiver(List<List<int>> river) {
    for (int i = 0; i < river.length; i++)
      map[river[i][0]][river[i][1]] = MAP_RIVER;
  }
  
  void fillBlocked(List<List<int>> blockeds) {
    for (int i = 0; i < blockeds.length; i++)
      map[blockeds[i][0]][blockeds[i][1]] = MAP_BLOCKED;
  }

  void fillEgg(int x, int y) {
    map[x][y] = MAP_EGG;
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
        else if (map[x][y] == MAP_BLOCKED)
          return [false, ERROR_HIT_WALL, "I hurt my face Q_q(#"];
        else if (map[x][y] == MAP_EGG)
          return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
        return [true];
        
      case ACTION_FLY:
        if (map[x][y] == MAP_RIVER)
          return [false, ERROR_DRAWN, "Help me brabrabra......!"];
        else if (map[x][y] == MAP_BLOCKED)
          return [false, ERROR_HIT_WALL, "I can see so far ~~~"];
        else if (map[x][y] == MAP_EGG)
          return [false, ERROR_BREAK_EGG, "Oops my egg!!!"];
        return [true];
        
      case ACTION_PADDLE:
        if (map[x][y] == MAP_GROUND)
          return [false, ERROR_DRAWN, "My wings get dirty QAQ"];
        else if (map[x][y] == MAP_BLOCKED)
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
