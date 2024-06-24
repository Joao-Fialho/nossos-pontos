import 'package:mobx/mobx.dart';
import 'package:nossos_pontos/domain/points_item_model.dart';
import 'package:nossos_pontos/domain/rank_item_datasource.dart';
import 'package:nossos_pontos/domain/user_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  _HomeController() {
    getUser();
  }

  RankItemDatasource rankItemDatasource = RankItemDatasource();

  @observable
  ObservableList<UserModel> userList = ObservableList<UserModel>();

  @observable
  String selectedUser = '';

  @action
  getUser() async {
    userList = (await rankItemDatasource.getUserFirebase()).asObservable();
    selectedUser = userList.first.name;
    return userList;
  }

  // @action
  // setPoints() async {
  //   toggleVisibility();
  //   // userList = (await rankItemDatasource.getRankItem()).asObservable();
  //   // return userList;
  // }

  @observable
  Observable<bool> isVisibleModalPoint = false.obs();

  @observable
  Observable<bool> backButtonPressed = false.obs();

  @action
  void toggleVisibility() {
    isVisibleModalPoint = (!isVisibleModalPoint.value).obs();
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

  setPoints(int points, bool isPositivePoints, String motivo) {
    int totalPoint = 0;
    for (var i = 0; i < userList.length; i++) {
      if (selectedUser == userList[i].name) {
        if (isPositivePoints == true) {
          totalPoint = (points + userList[i].pointsTotal).toInt();
        } else {
          totalPoint = (userList[i].pointsTotal - points).toInt();
        }
        rankItemDatasource.setPointsFirebase(
          selectedUser,
          totalPoint,
          i,
          PointsItemModel(
              motivo: motivo,
              points: points,
              isPositivePoints: isPositivePoints),
        );
      }
    }
    toggleVisibility();
    getUser();
  }
}

// final List<PointsItemUser> pointsItemUser = [
//   PointsItemUser(
//     name: 'Joao',
//     pointsTotal: 123,
//     pointsItemList: [
//       PointsItem(
//         motivo:
//             'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//     ],
//   ),
//   PointsItemUser(
//     name: 'kelly',
//     pointsTotal: 233,
//     pointsItemList: [
//       PointsItem(
//         motivo:
//             'teste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste testeteste teste teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: false,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//       PointsItem(
//         motivo: 'teste teste',
//         points: 100,
//         isPositivePoints: true,
//       ),
//     ],
//   )
// ];
