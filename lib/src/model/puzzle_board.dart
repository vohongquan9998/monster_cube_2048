import 'dart:math';

import 'package:flutter_2048_program_language/src/model/puzzle.dart';
import 'package:flutter_2048_program_language/src/model/tile.dart';

// ignore: camel_case_types
class Puzzle_Board {
  final int columm;
  final int row;
  int index;
  bool win;
  int count;
  Puzzle_Board({this.columm, this.row});
  List<List<Tile>> _boardTile;
  List<int> cubeCount = List<int>();

  void initBoard(int index) {
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
    this.index = index;
    print(_boardTile.asMap().values);
    count = getListPuzzle()[this.index].step;
    cubeCount.length = getListPuzzle()[this.index].required_value.length;
    win = false;
    for (int i = 0;
        i < getListPuzzle()[this.index].required_value.length;
        i++) {
      cubeCount[i] = getListPuzzle()[this.index].required_value[i];
    }
    resetCanMerge();

    getAlltile(this.index);
  }

  void getAlltile(index) {
    List<Tile> empty = List<Tile>();

    _boardTile.forEach((rows) {
      empty.addAll(rows.where((tile) => tile.isEmpty()));
    });
    if (empty.isEmpty) {
      return;
    }
    for (int i = 0; i < empty.length; i++) {
      empty[i].value = getListPuzzle()[index].map[i];
    }
  }

  void resetCanMerge() {
    _boardTile.forEach((r) {
      r.forEach((tile) {
        tile.canMerge = false;
      });
    });
  }

  Tile getTile(int row, int column) {
    return _boardTile[row][column];
  }

  void moveLeft() {
    if (!canMoveLeft() || win) return;
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < columm; ++c) {
        mergeLeft(r, c);
      }
    }
    //randomEmptyTile();
    count--;
    resetCanMerge();
  }

  void moveRight() {
    if (!canMoveRight() || win) return;
    for (int r = 0; r < row; ++r) {
      for (int c = columm - 2; c >= 0; --c) {
        mergeRight(r, c);
      }
    }
    //randomEmptyTile();
    count--;
    resetCanMerge();
  }

  void moveUp() {
    if (!canMoveUp() || win) return;
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < columm; ++c) {
        mergeUp(r, c);
      }
    }
    //randomEmptyTile();
    count--;
    resetCanMerge();
  }

  void moveDown() {
    if (!canMoveDown() || win) return;
    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < columm; ++c) {
        mergeDown(r, c);
      }
    }
    //randomEmptyTile();
    count--;
    resetCanMerge();
  }

  //Left
  void mergeLeft(int row, int c) {
    while (c > 0) {
      merge(_boardTile[row][c], _boardTile[row][c - 1]);
      c--;
    }
  }

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

//Right
  void mergeRight(int row, int c) {
    while (c < columm - 1) {
      merge(_boardTile[row][c], _boardTile[row][c + 1]);
      c++;
    }
  }

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

//Up

  void mergeUp(int r, int c) {
    while (r > 0) {
      merge(_boardTile[r][c], _boardTile[r - 1][c]);
      r--;
    }
  }

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

//Down

  void mergeDown(int r, int c) {
    while (r < row - 1) {
      merge(_boardTile[r][c], _boardTile[r + 1][c]);
      r++;
    }
  }

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

//Merge

  bool canMerge(Tile a, Tile b) {
    return !a.canMerge &&
        ((b.isEmpty() && !a.isEmpty()) || (!a.isEmpty() && a == b));
  }

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
      checkCount(b.value);

      b.canMerge = true;
    } else {
      b.canMerge = true;
    }
  }

  void checkCount(int value) {
    for (int i = 0; i < getListPuzzle()[index].required.length; i++) {
      if (value == getListPuzzle()[index].required[i]) {
        cubeCount[i]--;
      }
    }
    for (int i = 0; i < cubeCount.length; i++) {
      if (cubeCount[i] <= 0) {
        win = true;
      }
    }
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

    empty[index].value = 2;
    empty[index].isNew = true;

    empty.removeAt(index);
  }

  bool GameOver() {
    return (!canMoveLeft() &&
            !canMoveRight() &&
            !canMoveUp() &&
            !canMoveDown()) ||
        count < 0;
  }

  bool WinGame() {
    return win;
  }
}
