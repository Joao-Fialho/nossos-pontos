import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nossos_pontos/domain/user_adapter.dart';
import 'package:nossos_pontos/domain/user_model.dart';

class RankItemDatasource {
  var db = FirebaseFirestore.instance;
  UserAdapter userAdapter = UserAdapter();

  getRankItem() async {
    final pointsItemUserCollection = db.collection("PointsItemUser");

    final userMap = (await pointsItemUserCollection.get()).docs;
    final userList = userMap.map(
      (e) async {
        final pointsItemDocs =
            (await e.reference.collection('pointsItemList').get()).docs.map(
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
