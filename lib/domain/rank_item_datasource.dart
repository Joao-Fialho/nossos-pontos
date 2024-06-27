import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';
import 'package:nossos_pontos/domain/models/user_model.dart';

class RankItemDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream<List<PointsItemModel>> getPointsItemListStream(String userId) {
  //   return _firestore
  //       .collection('pointsItemUser')
  //       .doc(userId)
  //       .collection('pointsItemList')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => PointsItemModel.fromDocument(doc))
  //         .toList();
  //   });
  // }

  // Future<void> updatePointsItem(
  //     String userId, String itemId, Map<String, dynamic> updatedData) async {
  //   try {
  //     DocumentReference documentReference = _firestore
  //         .collection('pointsItemUser')
  //         .doc(userId)
  //         .collection('pointsItemList')
  //         .doc(itemId);

  //     await documentReference.update(updatedData);
  //     print('Documento atualizado com sucesso!');
  //   } catch (e) {
  //     print('Erro ao atualizar documento: $e');
  //   }
  // }

  Future<List<UserModel>> getUserFirebase() async {
    List<UserModel> userModels = [];

    final CollectionReference pointsItemUserCollection =
        db.collection("PointsItemUser");

    final QuerySnapshot pointsItemUserDoc =
        await pointsItemUserCollection.get();

    for (QueryDocumentSnapshot pointsItemUserDoc in pointsItemUserDoc.docs) {
      List<PointsItemModel> pointsItemList = [];

      CollectionReference pointsItemListCollection = pointsItemUserCollection
          .doc(pointsItemUserDoc.id)
          .collection('pointsItemList');

      QuerySnapshot pointsItemListSnapshot = await pointsItemListCollection
          .orderBy('createdAt', descending: true)
          .get();

      for (QueryDocumentSnapshot pointsItemListDoc
          in pointsItemListSnapshot.docs) {
        PointsItemModel pointItem =
            PointsItemModel.fromDocument(pointsItemListDoc);
        pointsItemList.add(pointItem);
      }
      UserModel userModel =
          UserModel.fromDocument(pointsItemUserDoc, pointsItemList);
      userModels.add(userModel);
      somaTotalPoints(pointsItemList, userModel.id);
    }

    return userModels;
  }

  setPointsFirebase(String user, int totalPoint, int userIndex,
      PointsItemModel pointsItemModel) async {
    final pointsItemUserCollection = db.collection("PointsItemUser");
    final dataUser = <String, dynamic>{
      "name": user,
      "pointsItemList": "/0$userIndex/pointsItemList",
      "pointsTotal": totalPoint,
    };
    final dataPoints = <String, dynamic>{
      "isPositivePoints": pointsItemModel.isPositivePoints,
      "motivo": pointsItemModel.motivo,
      "points": pointsItemModel.points,
      'createdAt': FieldValue.serverTimestamp(),
    };
    pointsItemUserCollection.doc('0$userIndex').set(dataUser);
    final userMap = (await pointsItemUserCollection.get()).docs[userIndex];

    userMap.reference.collection('pointsItemList').add(dataPoints);
  }

  editMotivoFirebase(PointsItemModel pointsItem, String newMotivo,
      int newPoints, String userId) async {
    final editData = <String, dynamic>{
      "motivo": newMotivo,
      "points": newPoints,
    };
    final pointsItemUserCollection = db
        .collection("PointsItemUser/$userId/pointsItemList")
        .doc(pointsItem.id)
        .update(editData);
  }

  somaTotalPoints(List<PointsItemModel> pointsItemList, userId) {
    var totalPoints = 0;
    for (var pointsItemList in pointsItemList) {
      if (pointsItemList.isPositivePoints == true) {
        totalPoints = totalPoints + pointsItemList.points;
      } else {
        totalPoints = totalPoints - pointsItemList.points;
      }
    }
    final editData = <String, dynamic>{
      "pointsTotal": totalPoints,
    };
    final pointsItemUserCollection =
        db.collection("PointsItemUser").doc(userId).update(editData);
    return totalPoints.toInt();
  }
}
