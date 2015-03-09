library client.level_block_filler;

import "field_name.dart";

class BlockFiller {
  List<List<int>> map;
  
  BlockFiller() {
    map = new List(MAP_WIDTH);
    for (int i = 0; i < MAP_WIDTH; i++)
      map[i] = new List(MAP_HEIGHT);
  }
  
  void fillBlank() {
    for (int i = 0; i < MAP_WIDTH; i++)
      for (int j = 0; j < MAP_HEIGHT; i++)
        map[i][j] = OBSTICLE_NONE;
  }
  
  void fillBorder() {
    for (int i = 0; i < MAP_WIDTH; i++) {
      map[i][0] = OBSTICLE_BORDER;
      map[i][MAP_HEIGHT - 1] = OBSTICLE_BORDER;
    }
    for (int i = 0; i < MAP_HEIGHT; i++) {
      map[0][i] = OBSTICLE_BORDER;
      map[MAP_WIDTH][i] = OBSTICLE_BORDER;
    }
  }
  
  void fillRock(List<List<int>> rocks) {
    for (int i = 0; i < rocks.length; i++)
      map[rocks[i][0]][rocks[i][1]] = OBSTICLE_ROCK;
  }
  
  void fillRiver(List<List<int>> river) {
    for (int i = 0; i < river.length; i++)
      map[river[i][0]][river[i][1]] = OBSTICLE_RIVER;
  }

  void fillEgg(int x, int y) {
    map[x][y] = OBSTICLE_EGG;
  }
  
}