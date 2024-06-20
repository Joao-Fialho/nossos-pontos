// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nossos_pontos/domain/rank_item_objetct.dart';

class RankItemDatasource {
  RankItemDatasource({
    required this.rankItemObjetctList,
  });
  List<RankItemObject> rankItemObjetctList = [
    RankItemObject(
      motivo:
          'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
      points: 100,
      pointsPositivos: false,
    ),
    RankItemObject(
      motivo: 'teste teste',
      points: 100,
      pointsPositivos: false,
    ),
    RankItemObject(
      motivo: 'teste teste',
      points: 100,
      pointsPositivos: true,
    ),
    RankItemObject(
      motivo: 'teste teste',
      points: 100,
      pointsPositivos: true,
    ),
    RankItemObject(
      motivo: 'teste teste',
      points: 100,
      pointsPositivos: true,
    ),
  ];
}
