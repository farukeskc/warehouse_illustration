import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/picklist.dart';

class PickListRepository {
  CollectionReference pathCollection =
      FirebaseFirestore.instance.collection('picklists');

  Stream<List<PickList>> getAllPickList() {
    return pathCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PickList.fromDocumentSnapshot(doc))
          .toList();
    });
  }
}
