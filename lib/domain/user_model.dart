import 'package:nossos_pontos/domain/points_item_model.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.pointsTotal,
    required this.pointsItemList,
  });
  String name = '';
  int pointsTotal = 0;
  List<PointsItemModel> pointsItemList = [];
}
