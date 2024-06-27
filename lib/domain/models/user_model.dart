import 'package:cloud_firestore/cloud_firestore.dart';

import 'points_item_model.dart';

class UserModel {
  final String id;
  final String name;
  final int pointsTotal;
  final List<PointsItemModel> pointsItemList;

  UserModel({
    required this.id,
    required this.name,
    required this.pointsTotal,
    required this.pointsItemList,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc,
      List<PointsItemModel> pointsItemList) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      pointsTotal: data['pointsTotal'],
      pointsItemList: pointsItemList,
    );
  }
}
