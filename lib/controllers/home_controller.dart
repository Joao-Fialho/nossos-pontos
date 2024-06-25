import 'package:mobx/mobx.dart';
import 'package:nossos_pontos/domain/models/points_item_model.dart';
import 'package:nossos_pontos/domain/models/user_model.dart';
import 'package:nossos_pontos/domain/rank_item_datasource.dart';

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

  @observable
  Observable<bool> isVisibleModalPoint = false.obs();

  @observable
  Observable<bool> backButtonPressed = false.obs();

  // @action
  // void editMotivo(String user, int totalPoint,) {
  //   int userIndex = verificarUser(user);
  //   rankItemDatasource.editMotivoFirebase(
  //       user, totalPoint, userIndex);
  // }

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

  verificarUser(String user) {
    for (var i = 0; i < userList.length; i++) {
      if (user == userList[i].name) {
        return i;
      }
    }
  }

  setPoints(int points, bool isPositivePoints, String motivo) {
    int totalPoint = 0;
    int userIndex = verificarUser(selectedUser);
    if (isPositivePoints == true) {
      totalPoint = (points + userList[userIndex].pointsTotal).toInt();
    } else {
      totalPoint = (userList[userIndex].pointsTotal - points).toInt();
    }
    rankItemDatasource.setPointsFirebase(
      selectedUser,
      totalPoint,
      userIndex,
      PointsItemModel(
          motivo: motivo, points: points, isPositivePoints: isPositivePoints),
    );

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
