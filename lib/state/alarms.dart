import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:projectbudy/service/alarm_manager.dart';
import 'package:projectbudy/model/alarm.dart';

class AlarmsState extends ChangeNotifier {
  static const String alarmsKey = 'alarmsState';
  static const String nextAlarmIdKey = 'nextAlarmId';

  final SharedPreferences sharedPreferences;
  List<Alarm> _alarms;

  // TODO
  //  1. Alarm Deletion
  //  2. Edit alarm

  AlarmsState(this.sharedPreferences) {
    _alarms = sharedPreferences
        .getStringList(alarmsKey)
        .map((a) => json.decode(a))
        .map((a) => Alarm.fromJson(a))
        .toList();
  }

  UnmodifiableListView<Alarm> get alarms {
    return UnmodifiableListView(_alarms);
  }

  int get alarmsCount {
    return _alarms.length;
  }

  Future<int> _nextAlarmId() async {
    var nextId = sharedPreferences.getInt(nextAlarmIdKey) ?? 0;
    await sharedPreferences.setInt(nextAlarmIdKey, ++nextId);
    return nextId;
  }

  void addAlarm(Alarm alarm) async {
    alarm.id = await this._nextAlarmId();
    _alarms.add(alarm);
    await persistAndNotify();
    await AlarmManager.addAlarm(alarm);
  }

  void deleteAlarm(int alarmIndex) {
    _alarms.removeAt(alarmIndex);
    // TODO delete alarm job
    persistAndNotify();
  }

  void switchAlarm(int alarmIndex, bool value) {
    _alarms[alarmIndex].enabled = value;
    persistAndNotify();
  }

  Future<void> persistAndNotify() async {
    // TODO write widget test that checks notifyListeners() works
    await persistAlarms();
    notifyListeners();
  }

  Future<bool> persistAlarms() async {
    return sharedPreferences.setStringList(alarmsKey, alarms.map((a) => json.encode(a)).toList());
  }
}
