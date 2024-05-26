import 'package:flutter/material.dart';
import 'package:warehouse_illustration/models/coordinate.dart';
import 'package:warehouse_illustration/models/picklist.dart';
import 'package:warehouse_illustration/repos/picklist_repository.dart';

import '../models/item.dart';
import '../widgets/layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickList? selectedPickList;
  int selectedAlgorithm = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PickList>>(
        stream: PickListRepository().getAllPickList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return InteractiveViewer(
              maxScale: 10,
              child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Warehouse Illustration',
                        style: TextStyle(color: Colors.white)),
                    centerTitle: true,
                    backgroundColor: const Color(0xFFBD2640),
                    actions: [
                      ToggleButtons(
                        isSelected: List.generate(
                            4, (index) => index == selectedAlgorithm),
                        onPressed: (int index) {
                          setState(() {
                            selectedAlgorithm = index;
                          });
                        },
                        fillColor: Colors.white,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('S-Shape'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Largest Gap'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Midpoint'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Genetic'),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      DropdownButton(
                        items: [
                          for (PickList pickList in snapshot.data!)
                            DropdownMenuItem(
                              value: pickList,
                              child: Text(pickList.id),
                            )
                        ],
                        hint: const Text('Select Picklist'),
                        value: selectedPickList,
                        onChanged: (PickList? value) {
                          setState(() {
                            selectedPickList = value;
                          });
                        },
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (selectedPickList != null)
                            ? Row(
                                children: [
                                  Text(
                                    "Distance: ${getSelectedDistance(selectedPickList!).toStringAsFixed(1)}",
                                    style: const TextStyle(
                                      fontSize:15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Spacer(),
                                  (MediaQuery.of(context).size.width < 1450)?const SizedBox():Text(
                                    getSelectedPathString(selectedPickList!),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        (selectedPickList != null)
                            ? Layout(
                                paths: getSelectedPath(selectedPickList!),
                                items: getSelectedItems(selectedPickList!))
                            : const Text("No path to display"),
                      ],
                    ),
                  )),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  List<Coordinate> getSelectedPath(PickList pickList) {
    switch (selectedAlgorithm) {
      case 0:
        return pickList.sShapePath;
      case 1:
        return pickList.largestGapPath;
      case 2:
        return pickList.midPointPath;
      case 3:
        return pickList.geneticPath;
      default:
        return pickList.sShapePath;
    }
  }

  List<Item> getSelectedItems(PickList pickList) {
    switch (selectedAlgorithm) {
      case 0:
        return pickList.sShapeItems;
      case 1:
        return pickList.largestGapItems;
      case 2:
        return pickList.midPointItems;
      case 3:
        return pickList.geneticItems;
      default:
        return pickList.sShapeItems;
    }
  }

  String getSelectedPathString(PickList pickList) {
    String result = "";
    switch (selectedAlgorithm) {
      case 0:
        result = pickList.getSShapePath;
      case 1:
        result = pickList.getLargestGapPath;
      case 2:
        result = pickList.getMidPointPath;
      case 3:
        result = pickList.getGeneticPath;
      default:
        result = pickList.getSShapePath;
    }

    if (result.length > 200) {
      return "${result.substring(0, 200)}...";
    }
    return result;
  }

  double getSelectedDistance(PickList pickList) {
    switch (selectedAlgorithm) {
      case 0:
        return pickList.sShapeDistance;
      case 1:
        return pickList.largestGapDistance;
      case 2:
        return pickList.midPointDistance;
      case 3:
        return pickList.geneticDistance;
      default:
        return pickList.sShapeDistance;
    }
  }
}
