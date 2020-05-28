import 'dart:collection';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:projectbudy/service/alarm_manager.dart';
import 'package:projectbudy/model/alarm.dart';

class AlarmsState extends ChangeNotifier {
  static const String alarmsKey = 'alarmsState';
  static const String nextAlarmIdKey = 'nextAlarmId';

  final SharedPreferences sharedPreferences;
  AlarmManager _alarmManager;
  SplayTreeSet<Alarm> _alarms;

  AlarmsState(this.sharedPreferences) {
    _alarmManager = AlarmManager.getInstance();

    final Iterable<Alarm> alarmsIterable =
        (sharedPreferences.getStringList(alarmsKey) ?? <String>[])
            .map((a) => json.decode(a))
            .map((a) => Alarm.fromJson(a));

    _alarms = SplayTreeSet.of(alarmsIterable, (a, b) => a.time.compareTo(b.time));
  }

  UnmodifiableSetView<Alarm> get alarms {
    return UnmodifiableSetView(_alarms);
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

  Future<void> updateAlarm(Alarm alarm) async {
    await persistAndNotify();
    await _alarmManager.addAlarm(alarm);
  }

  Future<void> deleteAlarm(Alarm alarm) async {
    await _alarmManager.cancel(alarm);
    _alarms.remove(alarm);
    await persistAndNotify();
  }

  void switchAlarm(Alarm alarm, bool value) { // TODO disable job
    alarm.enabled = value;
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
