import 'package:flutter/material.dart';
import 'package:nossos_pontos/domain/points_item_model.dart';

class HomeController extends ChangeNotifier {
  late bool isVisibleModalPoint;

  final List<PointsItemList> pointsItemList = [
    PointsItemList(
      motivo:
          'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
      points: 100,
      isPositivePoints: false,
    ),
    PointsItemList(
      motivo: 'teste teste',
      points: 100,
      isPositivePoints: false,
    ),
    PointsItemList(
      motivo: 'teste teste',
      points: 100,
      isPositivePoints: true,
    ),
    PointsItemList(
      motivo: 'teste teste',
      points: 100,
      isPositivePoints: true,
    ),
    PointsItemList(
      motivo: 'teste teste',
      points: 100,
      isPositivePoints: true,
    ),
  ];

  void toggleVisibility() {
    isVisibleModalPoint = !isVisibleModalPoint;
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
    for (var i = 0; i < pointsItemList.length; i++) {
      if (pointsItemList[i].isPositivePoints == true) {
        totalPoint = totalPoint + pointsItemList[i].points;
      } else {
        totalPoint = totalPoint - pointsItemList[i].points;
      }
    }
    return totalPoint.toInt();
  }

  List getListPoints() {
    return [];
  }

  adicionarPoints(String motivo, int points, bool pointsPositivos) {
    toggleVisibility();
    pointsItemList.add(
      PointsItemList(
          motivo: motivo, points: points, isPositivePoints: pointsPositivos),
    );
  }

  descontarPoints(String motivo, int points, bool pointsPositivos) {
    toggleVisibility();

    pointsItemList.add(
      PointsItemList(
          motivo: motivo, points: points, isPositivePoints: pointsPositivos),
    );
  }
}
