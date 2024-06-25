import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nossos_pontos/domain/mappers/user_adapter.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';
import 'package:nossos_pontos/domain/models/user_model.dart';

class RankItemDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserAdapter userAdapter = UserAdapter();

  Future<List<UserModel>> getUserFirebase() async {
    final pointsItemUserCollection = db.collection("PointsItemUser");
    final userDoc = (await pointsItemUserCollection.get()).docs;

    final userList = userDoc.map(
      (e) async {
        final pointsItemDocs = (await e.reference
                .collection('pointsItemList')
                .orderBy('createdAt', descending: true)
                .get())
            .docs
            .map(
          (e) {
            return e.data();
          },
        );

        var pointsItemList = {...e.data(), 'pointsItemList': pointsItemDocs};

        return userAdapter.fromMap(pointsItemList);
      },
    ).toList();

    final user = await Future.wait(userList);

    return user;
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
}















// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:nossos_pontos/domain/points_item_model.dart';

// class RankItemDatasource {
//   RankItemDatasource({
//     required this.rankItemObjetctList,
//   });
//   List<RankItemObject> rankItemObjetctList = [
//     RankItemObject(
//       motivo:
//           'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
//       points: 100,
//       pointsPositivos: false,
//     ),
//     RankItemObject(
//       motivo: 'teste teste',
//       points: 100,
//       pointsPositivos: false,
//     ),
//     RankItemObject(
//       motivo: 'teste teste',
//       points: 100,
//       pointsPositivos: true,
//     ),
//     RankItemObject(
//       motivo: 'teste teste',
//       points: 100,
//       pointsPositivos: true,
//     ),
//     RankItemObject(
//       motivo: 'teste teste',
//       points: 100,
//       pointsPositivos: true,
//     ),
//   ];
// }
