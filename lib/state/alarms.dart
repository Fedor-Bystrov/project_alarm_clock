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
  AlarmManager _alarmManager;
  List<Alarm> _alarms;

  // TODO
  //  1. Edit alarm

  AlarmsState(this.sharedPreferences) {
    _alarmManager = AlarmManager.getInstance();
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
    await sharedPreferences.setInt(nextAlarmIdKey, nextId + 1);
    return nextId;
  }

  Future<void> addAlarm(Alarm alarm) async {
    alarm.id = await this._nextAlarmId();
    _alarms.add(alarm);
    await persistAndNotify();
    await _alarmManager.addAlarm(alarm);
  }

  Future<void> deleteAlarm(int alarmIndex) async {
    await _alarmManager.cancel(_alarms[alarmIndex]);
    _alarms.removeAt(alarmIndex);
    await persistAndNotify();
  }

  void switchAlarm(int alarmIndex, bool value) {
    _alarms[alarmIndex].enabled = value;
    persistAndNotify();
  }

  Future<void> persistAndNotify() async {
    await persistAlarms();
    notifyListeners();
  }

  Future<bool> persistAlarms() async {
    return sharedPreferences.setStringList(alarmsKey, alarms.map((a) => json.encode(a)).toList());
  }
}
