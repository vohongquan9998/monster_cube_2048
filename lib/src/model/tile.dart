class Tile {
  int row, column;
  int value;
  bool canMerge;
  bool isNew;
  Tile({this.row, this.column, this.value = 0, this.canMerge, this.isNew});

  bool isEmpty() {
    return value == 0;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  operator ==(other) {
    return other is Tile && value == other.value;
  }
}
