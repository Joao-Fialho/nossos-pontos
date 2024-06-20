import 'package:nossos_pontos/domain/rank_item_objetct.dart';

class PointsController {
  final List<RankItemObject> rankItemObjetctList = [];
  // List<RankItemObject> rankItemObjetctList = [
  //   RankItemObject(
  //     motivo:
  //         'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
  //     points: 100,
  //     pointsPositivos: false,
  //   ),
  //   RankItemObject(
  //     motivo: 'teste teste',
  //     points: 100,
  //     pointsPositivos: false,
  //   ),
  //   RankItemObject(
  //     motivo: 'teste teste',
  //     points: 100,
  //     pointsPositivos: true,
  //   ),
  //   RankItemObject(
  //     motivo: 'teste teste',
  //     points: 100,
  //     pointsPositivos: true,
  //   ),
  //   RankItemObject(
  //     motivo: 'teste teste',
  //     points: 100,
  //     pointsPositivos: true,
  //   ),
  // ];


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

  int somaPoints(List listPoints) {
    double totalPoint = 0;
    for (var i = 0; i < listPoints.length; i++) {
      if (listPoints[i].pointsPositivos == true) {
        totalPoint = totalPoint + listPoints[i].points;
      } else {
        totalPoint = totalPoint - listPoints[i].points;
      }
    }
    return totalPoint.toInt();
  }

  List getListPoints() {
    return [];
  }

  adicionarPoints(String motivo, int points, bool pointsPositivos) {
    rankItemObjetctList.add(
      RankItemObject(
          motivo: motivo, points: points, pointsPositivos: pointsPositivos),
    );
  }

  descontarPoints() {}
}
