import 'package:nossos_pontos/domain/models/points_item_model.dart';

class PointsItemAdapter {
  static PointsItemModel fromMap(Map<String, dynamic> map) {
    return PointsItemModel(
      isPositivePoints: map['isPositivePoints'],
      motivo: map['motivo'],
      points: map['points'] ?? 0,
    );
  }
}
