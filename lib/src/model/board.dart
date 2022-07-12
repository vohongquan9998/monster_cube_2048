import 'dart:math';

import 'package:flutter_2048_program_language/src/model/tile.dart';

import 'package:flutter_2048_program_language/src/utils/dex_data.dart';
import 'package:flutter_2048_program_language/src/utils/item_data.dart';
import 'package:flutter_2048_program_language/src/utils/utils.dart';

enum Clan { Blue, Red, Green }

class Board {
  final int columm;
  final int row;
  double scores;
  int point;
  int skill_point;
  double discout;
  double percent;
  List<int> lv = List<int>();
  Board({this.columm, this.row});
  List<List<Tile>> _boardTile;
  Random rand = new Random();

  Clan clan;
  bool _isResetHasValue;
  int buy_index;
  bool isEmpty;
  double value_change;
  List<int> cubeCount = List<int>();

  //init
  void initBoard(Clan clan) {
    _boardTile = List.generate(
      5,
      (r) => List.generate(
        5,
        (c) => Tile(
          row: r,
          column: c,
          value: 0,
          isNew: false,
          canMerge: false,
        ),
      ),
    );

    print(_boardTile);
    this.clan = clan;
    scores = 0;
    point = 0;
    skill_point = 0;
    percent = 0;
    _isResetHasValue = false;
    buy_index = 0;
    value_change = 0;
    discout = 1;
    isEmpty = false;

    lv.length = getDexData().length;
    cubeCount.length = tileArray.length;

    for (int i = 0; i < lv.length; i++) {
      lv[i] = 0;
    }
    for (int i = 0; i < cubeCount.length; i++) {
      cubeCount[i] = 0;
    }

    resetCanMerge();
    randomEmptyTile();
    randomEmptyTile();
    ifBlueRandomEmptyTile();
    ifRedRandomEmptyTile();
    ifGreenRandomEmptyTile();
  }

  //If clan is Blue then +1 randomEmptyTile every turn
  void ifBlueRandomEmptyTile() {
    if (clan == Clan.Blue) {
      randomEmptyTile();
    }
  }

  void ifRedRandomEmptyTile() {
    if (clan == Clan.Red) {
      percent = 25.0;
    }
  }

  void ifGreenRandomEmptyTile() {
    if (clan == Clan.Green) {
      discout = 2;
    }
  }

  //Function MOVE LEFT
  void moveLeft() {
    if (!canMoveLeft()) return;
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < columm; ++c) {
        mergeLeft(r, c);
      }
    }
    randomEmptyTile();
    ifBlueRandomEmptyTile();
    resetCanMerge();
  }

  //Function MOVE RIGHT
  void moveRight() {
    if (!canMoveRight()) return;
    for (int r = 0; r < row; ++r) {
      for (int c = columm - 2; c >= 0; --c) {
        mergeRight(r, c);
      }
    }
    randomEmptyTile();
    ifBlueRandomEmptyTile();
    resetCanMerge();
  }

  //Function MOVE UP
  void moveUp() {
    if (!canMoveUp()) return;
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < columm; ++c) {
        mergeUp(r, c);
      }
    }
    randomEmptyTile();
    ifBlueRandomEmptyTile();
    resetCanMerge();
  }

  //Function MOVE DOWN
  void moveDown() {
    if (!canMoveDown()) return;
    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < columm; ++c) {
        mergeDown(r, c);
      }
    }
    randomEmptyTile();
    ifBlueRandomEmptyTile();
    resetCanMerge();
  }

  ///
  ///LEFT
  ///
  //Check tile can move LEFT then return it can merge
  bool canMoveLeft() {
    for (int r = 0; r < row; ++r) {
      for (int c = 1; c < columm; ++c) {
        if (canMerge(_boardTile[r][c], _boardTile[r][c - 1])) {
          return true;
        }
      }
    }
    return false;
  }

  //After check CanMoveLeft done this function will merge each other
  void mergeLeft(int row, int c) {
    while (c > 0) {
      merge(_boardTile[row][c], _boardTile[row][c - 1]);
      c--;
    }
  }

  ///
  ///RIGHT
  ///
  //Check tile can move RIGHT then return it can merge
  bool canMoveRight() {
    for (int r = 0; r < row; ++r) {
      for (int c = columm - 2; c >= 0; --c) {
        if (canMerge(_boardTile[r][c], _boardTile[r][c + 1])) {
          return true;
        }
      }
    }
    return false;
  }

  //After check CanMoveRight done this function will merge each other
  void mergeRight(int row, int c) {
    while (c < columm - 1) {
      merge(_boardTile[row][c], _boardTile[row][c + 1]);
      c++;
    }
  }

  ///
  ///UP
  ///
  //Check tile can move UP then return it can merge
  bool canMoveUp() {
    for (int r = 1; r < row; ++r) {
      for (int c = 0; c < columm; ++c) {
        if (canMerge(_boardTile[r][c], _boardTile[r - 1][c])) {
          return true;
        }
      }
    }
    return false;
  }

  //After check CanMoveUp done this function will merge each other
  void mergeUp(int r, int c) {
    while (r > 0) {
      merge(_boardTile[r][c], _boardTile[r - 1][c]);
      r--;
    }
  }

  ///
  ///DOWN
  ///
  //Check tile can move DOWN then return it can merge
  bool canMoveDown() {
    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < columm; ++c) {
        if (canMerge(_boardTile[r][c], _boardTile[r + 1][c])) {
          return true;
        }
      }
    }
    return false;
  }
  //After check CanMoveDown done this function will merge each other

  void mergeDown(int r, int c) {
    while (r < row - 1) {
      merge(_boardTile[r][c], _boardTile[r + 1][c]);
      r++;
    }
  }

  //Check all tile can merge
  //if(a == b ex: tile 4=4 => 8)

  bool canMerge(Tile a, Tile b) {
    return !a.canMerge &&
        ((b.isEmpty() && !a.isEmpty()) || (!a.isEmpty() && a == b));
  }

  //Function merge
  //Check b is empty -> postion of tile a is change to position of tile b then a = 0 (0=empty tile)
  //Check a == b -> value of tile b = a*2 (ex:b = 2, a=2 -> b = a*2 = 4)
  //score = b.tile (base value) + point(extra value) + percent(extra percent)
  //checkCount -> Check of pair tile you megred
  //checkScore -> When you reach milestone then POINT(extra point) will return [getItemData()[i].point]

  void merge(Tile a, Tile b) {
    if (!canMerge(a, b)) {
      if (!a.isEmpty() && !b.canMerge) {
        b.canMerge = true;
      }
      return;
    }

    if (b.isEmpty()) {
      b.value = a.value;
      a.value = 0;
    } else if (a == b) {
      b.value = b.value * 2;
      a.value = 0;
      double x = (b.value + point + ((b.value + point) * percent / 100));

      scores += x;
      skill_point++;
      //value_change = x;

      checkCount(b.value);
      checkScores(scores);

      b.canMerge = true;
    } else {
      b.canMerge = true;
    }
  }

  void checkScores(double scores) {
    for (int i = 0; i < getItemData().length; i++) {
      if (scores >= getItemData()[i].value && !getItemData()[i].isActive) {
        point = getItemData()[i].point;

        getItemData()[i].isActive = true;
      }
    }
  }

  void checkSkillPoint(int index) {
    lv[index]++;
    if (lv[index] <= 100) {
      percent = percent + (getDexData()[index].percent);
      skill_point = skill_point - getDexData()[index].value;
    } else {
      lv[index] = 100;
    }
  }

  void activeValue(int index) {
    List<Tile> empty = List<Tile>();

    _boardTile.forEach((rows) {
      empty.addAll(rows.where((tile) => tile.isEmpty()));
    });

    if (scores >= getSubtringValue(index + 1, discout) && empty.isNotEmpty) {
      _isResetHasValue = true;
      String floor_num =
          getSubtringValue(index + 1, discout).toStringAsFixed(0);
      scores = scores - int.parse(floor_num);
      buy_index = index;

      randomEmptyTile();
    }
  }

  void activeTradeValue(int index) {
    List<Tile> empty = List<Tile>();

    _boardTile.forEach((rows) {
      empty.addAll(rows.where((tile) => tile.isEmpty()));
    });

    if (cubeCount[index] >= (trade_cost / discout) && empty.isNotEmpty) {
      cubeCount[index] -= (trade_cost / discout).toInt();
      _isResetHasValue = true;
      buy_index = index;
      randomEmptyTile();
    }
  }

  void checkCount(int value) {
    for (int i = 0; i < tileArray.length; i++) {
      if (value == tileArray[i]) {
        cubeCount[i - 1]++;
      }
    }
  }

  bool GameOver() {
    return !canMoveLeft() && !canMoveRight() && !canMoveUp() && !canMoveDown();
  }

  Tile getTile(int row, int column) {
    return _boardTile[row][column];
  }

  void randomEmptyTile() {
    List<Tile> empty = List<Tile>();

    _boardTile.forEach((rows) {
      empty.addAll(rows.where((tile) => tile.isEmpty()));
    });
    if (empty.isEmpty) {
      return;
    }
    Random rand = Random();
    int index = rand.nextInt(empty.length);
    if (_isResetHasValue) {
      empty[index].value = tileArray[buy_index + 1];
    } else {
      if (rand.nextInt(30) == 0 && scores > 15000) {
        empty[index].value = 32;
      } else if (rand.nextInt(25) == 0 && scores > 10000) {
        empty[index].value = 16;
      } else if (rand.nextInt(20) == 0 && scores > 5000) {
        empty[index].value = 8;
      } else if (rand.nextInt(9) == 0) {
        empty[index].value = 4;
      } else {
        empty[index].value = 2;
      }
    }

    empty[index].isNew = true;
    _isResetHasValue = false;
    isEmpty = false;
    empty.removeAt(index);
  }

  void resetCanMerge() {
    _boardTile.forEach((r) {
      r.forEach((tile) {
        tile.canMerge = false;
      });
    });
  }
}
