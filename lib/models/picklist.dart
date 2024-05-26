import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_illustration/models/coordinate.dart';

import 'item.dart';

class PickList extends Equatable {
  final String id;
  final List<Item> sShapeItems;
  final List<Coordinate> sShapePath;
  final List<Item> largestGapItems;
  final List<Coordinate> largestGapPath;
  final List<Item> midPointItems;
  final List<Coordinate> midPointPath;
  final List<Item> geneticItems;
  final List<Coordinate> geneticPath;
  final double sShapeDistance;
  final double largestGapDistance;
  final double midPointDistance;
  final double geneticDistance;

  const PickList({
    required this.id,
    required this.sShapeItems,
    required this.sShapePath,
    required this.largestGapItems,
    required this.largestGapPath,
    required this.midPointItems,
    required this.midPointPath,
    required this.geneticItems,
    required this.geneticPath,
    required this.sShapeDistance,
    required this.largestGapDistance,
    required this.midPointDistance,
    required this.geneticDistance,
  });

  factory PickList.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return PickList(
      id: documentSnapshot.id,
      sShapeItems: (data['sShapeItems'] as List)
          .map((item) => Item.fromMap(item))
          .toList(),
      sShapePath: (data['sShapePath'] as List)
          .map((coordinate) => Coordinate.fromMap(coordinate))
          .toList(),
      largestGapItems: (data['largestGapItems'] as List)
          .map((item) => Item.fromMap(item))
          .toList(),
      largestGapPath: (data['largestGapPath'] as List)
          .map((coordinate) => Coordinate.fromMap(coordinate))
          .toList(),
      midPointItems: (data['midPointItems'] as List)
          .map((item) => Item.fromMap(item))
          .toList(),
      midPointPath: (data['midPointPath'] as List)
          .map((coordinate) => Coordinate.fromMap(coordinate))
          .toList(),
      geneticItems: (data['geneticItems'] as List)
          .map((item) => Item.fromMap(item))
          .toList(),
      geneticPath: (data['geneticPath'] as List)
          .map((coordinate) => Coordinate.fromMap(coordinate))
          .toList(),

      sShapeDistance: data['sShapeDistance'] as double,
      largestGapDistance: data['largestGapDistance'] as double,
      midPointDistance: data['midPointDistance'] as double,
      geneticDistance: data['geneticDistance'] as double,
    );
  }

  String get getSShapePath {
    String path = "Depot -> ";
    for (Item item in sShapeItems) {
      path += "${item.index} -> ";
    }
    path += "Depot";
    return path;
  }

  String get getLargestGapPath {
    String path = "Depot -> ";
    for (Item item in largestGapItems) {
      path += "${item.index} -> ";
    }
    path += "Depot";
    return path;
  }

  String get getMidPointPath {
    String path = "Depot -> ";
    for (Item item in midPointItems) {
      path += "${item.index} -> ";
    }
    path += "Depot";
    return path;
  }

  String get getGeneticPath {
    String path = "Depot -> ";
    for (Item item in geneticItems) {
      path += "${item.index} -> ";
    }
    path += "Depot";
    return path;
  }
  
  @override
  List<Object?> get props => [id];

}
