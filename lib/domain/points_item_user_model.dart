import 'package:nossos_pontos/domain/points_item_model.dart';

class PointsItemUser {
  PointsItemUser({
    required this.name,
    required this.pointsTotal,
    required this.pointsItemList,
  });
  String name = '';
  int pointsTotal = 0;
  List<PointsItem> pointsItemList = [];
}
