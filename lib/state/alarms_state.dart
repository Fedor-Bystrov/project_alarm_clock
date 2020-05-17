import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:projectbudy/model/alarm.dart';

class AlarmsState extends ChangeNotifier {
  List<Alarm> _alarms = [
    Alarm(DateTime.parse("2012-02-27 08:29:00"), "Mon Wed Fri", "Don’t Sleep", true),
    Alarm(DateTime.parse("2012-02-27 10:00:00"), "Every Day", "Alarm", false),
    Alarm(DateTime.parse("2012-02-27 13:00:00"), null, "Alarm", true),
    Alarm(DateTime.parse("2012-02-27 18:20:00"), "Every Day", "Alarm", false),
  ];

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
}
