library client.level_block_filler;

import "field_name.dart";

class BlockFiller {
  List<List<int>> map;
  
  BlockFiller() {
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
  
}