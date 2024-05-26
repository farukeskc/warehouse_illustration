import 'package:flutter/material.dart';

import '../models/coordinate.dart';
import '../models/item.dart';

class Layout extends StatefulWidget {
  final List<Coordinate> paths;
  final List<Item> items;
  const Layout({
    super.key,
    required this.paths,
    required this.items,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double? cellSize;
    double? aisleWidth;
    double? strokeWidth;
    double? pathStrokeWidth;
    double? textFontSize;
    if (screenWidth <= 600) {
      cellSize = 8 / 4.6;
      aisleWidth = 46 / 4.6;
      strokeWidth = 2 / 4.6;
      pathStrokeWidth = 4 / 4.6;
      textFontSize = 14 / 4.6;
    } else if (screenWidth <= 900) {
      cellSize = 8 / 3;
      aisleWidth = 46 / 3;
      strokeWidth = 2 / 3;
      pathStrokeWidth = 4 / 3;
      textFontSize = 14 / 3;
    } else if (screenWidth <= 1800) {
      cellSize = 8 / 2;
      aisleWidth = 46 / 2;
      strokeWidth = 2 / 2;
      pathStrokeWidth = 4 / 2;
      textFontSize = 14 / 2;
    } else {
      cellSize = 8;
      aisleWidth = 46;
      strokeWidth = 2;
      pathStrokeWidth = 4;
      textFontSize = 14;
    }
    return CustomPaint(
      painter: MyPainter(
        paths: widget.paths,
        items: widget.items,
        cellSize: cellSize,
        aisleWidth: aisleWidth,
        strokeWidth: strokeWidth,
        pathStrokeWidth: pathStrokeWidth,
        textFontSize: textFontSize,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Coordinate> paths;
  final List<Item> items;
  final int numberofAisles = 39;
  final int numberofShelvesPerAisle = 99;
  final double cellSize;
  final double aisleWidth;
  final double strokeWidth;
  final double pathStrokeWidth;
  final double textFontSize;
  const MyPainter({
    required this.paths,
    required this.items,
    this.cellSize = 8,
    this.aisleWidth = 46,
    this.strokeWidth = 2,
    this.pathStrokeWidth = 4,
    this.textFontSize = 14,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintWarehouseLayout(canvas);
    paintItems(canvas);
    paintDepotRect(canvas);
    paintPaths(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void paintWarehouseLayout(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < numberofAisles; i++) {
      double x = i * aisleWidth;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, numberofShelvesPerAisle * cellSize),
        paint,
      );
      canvas.drawLine(
        Offset(x + cellSize, 0),
        Offset(x + cellSize, numberofShelvesPerAisle * cellSize),
        paint,
      );
      canvas.drawLine(
        Offset(x + 2 * cellSize, 0),
        Offset(x + 2 * cellSize, numberofShelvesPerAisle * cellSize),
        paint,
      );
      for (int j = 0; j < numberofShelvesPerAisle + 1; j++) {
        canvas.drawLine(
          Offset(x, j * cellSize),
          Offset(x + 2 * cellSize, j * cellSize),
          paint,
        );
      }
    }
  }

  void paintPaths(Canvas canvas) {
    for (int i = 0; i < paths.length - 1; i++) {
      if (paths[i].x != paths[i + 1].x || paths[i].y != paths[i + 1].y) {
        final paint = Paint()
          ..color = Color.fromARGB(
              255, 255 - ((i / paths.length) * 255).round(), 17, 0)
          ..strokeWidth = pathStrokeWidth
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(paths[i].x * aisleWidth - 2 * cellSize, paths[i].y * cellSize),
          Offset(paths[i + 1].x * aisleWidth - 2 * cellSize,
              paths[i + 1].y * cellSize),
          paint,
        );
      }
    }
  }

  void paintItems(Canvas canvas) {
    TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: textFontSize,
      fontWeight: FontWeight.bold,
    );

    for (Item item in items) {
      final paint = Paint()
        ..color = Colors.blue
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawRect(
        Rect.fromLTWH(
          item.B * aisleWidth + item.C * cellSize,
          item.y * cellSize,
          cellSize,
          cellSize,
        ),
        paint,
      );

      TextSpan textSpan = TextSpan(
        text: (item.index.toString().length < 2)
            ? " ${item.index}"
            : item.index.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          // item.x * aisleWidth-5
          item.B * aisleWidth + item.C * cellSize - (cellSize * 3 / 8),
          item.y * cellSize - (cellSize / 2),
        ),
      );
    }
  }

  void paintDepotRect(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawRect(
      Rect.fromLTWH(
        (numberofAisles - 1) * aisleWidth,
        numberofShelvesPerAisle * cellSize + cellSize,
        aisleWidth,
        cellSize * 2.3,
      ),
      paint,
    );

    TextSpan textSpan = TextSpan(
      text: "Depot",
      style: TextStyle(
        color: Colors.white,
        fontSize: textFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        (numberofAisles - 1) * aisleWidth + cellSize / 2,
        numberofShelvesPerAisle * cellSize + cellSize + 1,
      ),
    );
  }
}
