import 'package:nossos_pontos/domain/points_item_adapter.dart';
import 'package:nossos_pontos/domain/user_model.dart';

class UserAdapter {
  UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      pointsTotal: map['pointsTotal'],
      pointsItemList: List<Map<String, dynamic>>.from(map['pointsItemList'])
          .map(PointsItemAdapter.fromMap)
          .toList(),
    );
  }
}
