import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmsState extends ChangeNotifier {
  static const String alarmsKey = 'alarmsState';

  final SharedPreferences sharedPreferences;
  List<Alarm> _alarms;

  AlarmsState(this.sharedPreferences) {
//    _alarms = List<Alarm>.from(json.decode(sharedPreferences.getString(alarmsKey)))
//        .map((a) => Alarm.fromJson(a))
//        .toList();
    initTestAlarms();
//    print(sharedPreferences.getStringList(alarmsKey));
  }

  UnmodifiableListView<Alarm> get alarms {
    return UnmodifiableListView(_alarms);
  }

  int get alarmsCount {
    return _alarms.length;
  }

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void initTestAlarms() {
    List<Alarm> alarms = [
      Alarm(DateTime.parse("2012-02-27 08:29:00"), "Mon Wed Fri", "Don’t Sleep", true),
      Alarm(DateTime.parse("2012-02-27 10:00:00"), "Every Day", "Alarm", false),
      Alarm(DateTime.parse("2012-02-27 13:00:00"), null, "Alarm", true),
      Alarm(DateTime.parse("2012-02-27 18:20:00"), "Every Day", "Alarm", false),
    ];
    _alarms = alarms;

    sharedPreferences.setStringList(alarmsKey, alarms.map((a) => json.encode(a)).toList());
    print("ok");
  }
}
