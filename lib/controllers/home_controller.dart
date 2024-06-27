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
    userList.clear();
    userList = (await rankItemDatasource.getUserFirebase()).asObservable();
    selectedUser = userList.first.name;
    return userList;
  }

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

  verificarUser(String user) {
    for (var i = 0; i < userList.length; i++) {
      if (user == userList[i].name) {
        return i;
      }
    }
  }

  Future<void> setPoints(
      int points, bool isPositivePoints, String motivo) async {
    int totalPoint = 0;
    int userIndex = verificarUser(selectedUser);
    if (isPositivePoints == true) {
      totalPoint = (points + userList[userIndex].pointsTotal).toInt();
    } else {
      totalPoint = (userList[userIndex].pointsTotal - points).toInt();
    }
    await rankItemDatasource.setPointsFirebase(
      selectedUser,
      totalPoint,
      userIndex,
      PointsItemModel(
          id: '',
          motivo: motivo,
          points: points,
          isPositivePoints: isPositivePoints),
    );

    getUser();
  }

  Future<void> editMotivo(PointsItemModel pointsItem, int newPoints,
      String newMotivo, String userId) async {
    await rankItemDatasource.editMotivoFirebase(
        pointsItem, newMotivo, newPoints, userId);
    getUser();
  }
}
