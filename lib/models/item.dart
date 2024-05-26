class Item {
  final int index;
  final int B;
  final int C;
  final int D;

  Item(this.index, this.B, this.C, this.D);

  int get x => B+C;
  int get y => D - 1;

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      map['index'],
      // map['b'],
      // map['c'],
      39 - (map['b'] as int),
      (map['c'] as int) == 0 ? 1 : 0,
      map['d'],
    );
  }
}
