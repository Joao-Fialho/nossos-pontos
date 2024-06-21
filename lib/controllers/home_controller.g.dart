// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeController, Store {
  late final _$userListAtom =
      Atom(name: '_HomeController.userList', context: context);

  @override
  ObservableList<UserModel> get userList {
    _$userListAtom.reportRead();
    return super.userList;
  }

  @override
  set userList(ObservableList<UserModel> value) {
    _$userListAtom.reportWrite(value, super.userList, () {
      super.userList = value;
    });
  }

  late final _$isVisibleModalPointAtom =
      Atom(name: '_HomeController.isVisibleModalPoint', context: context);

  @override
  bool get isVisibleModalPoint {
    _$isVisibleModalPointAtom.reportRead();
    return super.isVisibleModalPoint;
  }

  bool _isVisibleModalPointIsInitialized = false;

  @override
  set isVisibleModalPoint(bool value) {
    _$isVisibleModalPointAtom.reportWrite(value,
        _isVisibleModalPointIsInitialized ? super.isVisibleModalPoint : null,
        () {
      super.isVisibleModalPoint = value;
      _isVisibleModalPointIsInitialized = true;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_HomeController.getUser', context: context);

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$_HomeControllerActionController =
      ActionController(name: '_HomeController', context: context);

  @override
  void toggleVisibility() {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.toggleVisibility');
    try {
      return super.toggleVisibility();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userList: ${userList},
isVisibleModalPoint: ${isVisibleModalPoint}
    ''';
  }
}
