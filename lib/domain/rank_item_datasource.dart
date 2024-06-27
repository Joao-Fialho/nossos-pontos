import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';
import 'package:nossos_pontos/domain/models/user_model.dart';

class RankItemDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;

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
          .get(GetOptions(source: Source.server));

      for (QueryDocumentSnapshot pointsItemListDoc
          in pointsItemListSnapshot.docs) {
        PointsItemModel pointItem =
            PointsItemModel.fromDocument(pointsItemListDoc);
        pointsItemList.add(pointItem);
      }
      somaTotalPoints(pointsItemList, pointsItemUserDoc);

      UserModel userModel =
          UserModel.fromDocument(pointsItemUserDoc, pointsItemList);
      userModels.add(userModel);
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
    var totalPoints = 0;

    final editData = <String, dynamic>{
      "motivo": newMotivo,
      "points": newPoints,
    };
    final userCollection = db.collection("PointsItemUser");
    final pointsItemUserCollection = userCollection
        .doc(userId)
        .collection("pointsItemList")
        .doc(pointsItem.id);
    final userDoc = userCollection.doc(userId);

    totalPoints = (await userDoc.get())['pointsTotal'];
    var oldPoints = pointsItem.points;
    pointsItemUserCollection.update(editData);

    if (pointsItem.isPositivePoints == true) {
      totalPoints = totalPoints + (newPoints - oldPoints);
    } else {
      totalPoints = totalPoints - (newPoints - oldPoints);
    }
    final editPointsTotalData = <String, dynamic>{
      "pointsTotal": totalPoints,
    };

    userDoc.update(editPointsTotalData);
  }

  somaTotalPoints(List<PointsItemModel> pointsItemList, user) {
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
        db.collection("PointsItemUser").doc(user.id);
    pointsItemUserCollection.update(editData);
    // if (totalPoints != user['pointsTotal']) {
    //   getUserFirebase();
    // }
    return totalPoints.toInt();
  }
}
