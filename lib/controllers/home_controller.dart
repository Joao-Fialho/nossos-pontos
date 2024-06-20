import 'package:flutter/material.dart';
import 'package:nossos_pontos/domain/points_item_model.dart';
import 'package:nossos_pontos/domain/rank_item_datasource.dart';
import 'package:nossos_pontos/domain/user_model.dart';

class HomeController extends ChangeNotifier {
  ValueNotifier<bool> isVisibleModalPoint = ValueNotifier<bool>(false);
  RankItemDatasource rankItemDatasource = RankItemDatasource();

  final List<PointsItemModel> pointsItem = [];
  late List<UserModel> userList;

  getUser() async {
    return userList = await rankItemDatasource.getRankItem();
  }

  void toggleVisibility() {
    isVisibleModalPoint.value = !isVisibleModalPoint.value;
  }

  String firstLetterCapitalized(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String pointsPositivosString(bool pointsPositivos) {
    if (pointsPositivos == true) {
      return '+';
    } else {
      return '-';
    }
  }

  int somaPoints() {
    double totalPoint = 0;
    for (var i = 0; i < pointsItem.length; i++) {
      if (pointsItem[i].isPositivePoints == true) {
        totalPoint = totalPoint + pointsItem[i].points;
      } else {
        totalPoint = totalPoint - pointsItem[i].points;
      }
    }
    return totalPoint.toInt();
  }

  List getListPoints() {
    return [];
  }

  adicionarPoints(String motivo, int points, bool pointsPositivos) {
    pointsItem.add(
      PointsItemModel(
          motivo: motivo, points: points, isPositivePoints: pointsPositivos),
    );
    isVisibleModalPoint.value = false;
  }

  descontarPoints(String motivo, int points, bool pointsPositivos) {
    pointsItem.add(
      PointsItemModel(
          motivo: motivo, points: points, isPositivePoints: pointsPositivos),
    );
    isVisibleModalPoint.value = false;
  }
}

// final List<PointsItemUser> pointsItemUser = [
//   PointsItemUser(
//     name: 'Joao',
//     pointsTotal: 123,
//     pointsItemList: [
//       PointsItem(
//         motivo:
//             'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//     ],
//   ),
//   PointsItemUser(
//     name: 'kelly',
//     pointsTotal: 233,
//     pointsItemList: [
//       PointsItem(
//         motivo:
//             'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//     ],
//   )
// ];
