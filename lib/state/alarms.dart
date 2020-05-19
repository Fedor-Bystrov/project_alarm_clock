import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmsState extends ChangeNotifier {
  static const String alarmsKey = 'alarmsState';

  final SharedPreferences sharedPreferences;
  List<Alarm> _alarms;

  // TODO
  //  1. Unit tests
  //  2. Alarm Deletion
  //  3. Edit alarm

  AlarmsState(this.sharedPreferences) {
//    initTestAlarms();
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

  void addAlarm(Alarm alarm) { // TODO unit test
    _alarms.add(alarm);
    persistAndNotify();
  }

  void switchAlarm(int alarmIndex, bool value) { // TODO unit test
    _alarms[alarmIndex].enabled = value;
    persistAndNotify();
  }

  void persistAndNotify() {
    persistAlarms();
    notifyListeners();
  }

  void persistAlarms() { // TODO unit test
    sharedPreferences.setStringList(alarmsKey, alarms.map((a) => json.encode(a)).toList());
  }

  void initTestAlarms() {
    List<Alarm> alarms = [
      Alarm(DateTime.parse("2012-02-27 08:29:00"), "Mon Wed Fri", "Don’t Sleep", true),
      Alarm(DateTime.parse("2012-02-27 10:00:00"), "Every Day", "Alarm", false),
      Alarm(DateTime.parse("2012-02-27 13:00:00"), null, "Alarm", true),
      Alarm(DateTime.parse("2012-02-27 18:20:00"), "Every Day", "Alarm", false),
    ];
    sharedPreferences.setStringList(alarmsKey, alarms.map((a) => json.encode(a)).toList());
  }
}
