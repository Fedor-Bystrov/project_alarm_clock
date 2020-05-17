import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:projectbudy/model/alarm.dart';

class AlarmsState extends ChangeNotifier {
  List<Alarm> _alarms = [
    Alarm("8:29 am", "Mon Wed Fri", "Don’t Sleep", true),
    Alarm("10:00 am", "Every Day", "Alarm", false),
    Alarm("1:00 pm", null, "Alarm", true),
    Alarm("6:20 pm", "Every Day", "Alarm", false),
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
