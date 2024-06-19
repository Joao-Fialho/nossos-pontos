class CardNameController {
  String firstLetterCapitalized(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String pointsPositivos(bool pointsPositivos) {
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
}
