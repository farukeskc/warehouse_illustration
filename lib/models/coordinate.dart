class Coordinate {
  int x;
  int y;

  Coordinate(this.x, this.y);

  @override
  String toString() {
    return 'Coordinate{x: $x, y: $y}';
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
      40 - (map['x'] as int),
      // map['x'],
      map['y'],
    );
  }
}