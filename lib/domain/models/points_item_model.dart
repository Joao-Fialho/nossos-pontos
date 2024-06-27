import 'package:cloud_firestore/cloud_firestore.dart';

class PointsItemModel {
  PointsItemModel({
    required this.id,
    required this.motivo,
    required this.points,
    required this.isPositivePoints,
  });
  String id = '';
  String motivo = '';
  int points = 0;
  bool isPositivePoints = true;

  factory PointsItemModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PointsItemModel(
      id: doc.id,
      isPositivePoints: data['isPositivePoints'],
      motivo: data['motivo'],
      points: data['points'] ?? 0,
    );
  }
}
