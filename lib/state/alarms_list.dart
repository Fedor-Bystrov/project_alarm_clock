import 'package:flutter/material.dart';

enum AlarmsListStatus {
  DEFAULT,
  EDIT,
}

class AlarmsListState extends ChangeNotifier {
  AlarmsListStatus _currentStatus;

  AlarmsListState() {
    _currentStatus = AlarmsListStatus.DEFAULT;
  }

  AlarmsListStatus get currentStatus => _currentStatus;

  set currentStatus(AlarmsListStatus value) {
    _currentStatus = value;
    notifyListeners();
  }

  bool isDefault() {
    return _currentStatus == AlarmsListStatus.DEFAULT;
  }

  void setDefault() {
    currentStatus = AlarmsListStatus.DEFAULT;
  }

  void setEdit() {
    currentStatus = AlarmsListStatus.EDIT;
  }
}
