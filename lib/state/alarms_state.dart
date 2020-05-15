import 'package:flutter/material.dart';
import 'package:projectbudy/model/alarm.dart';
import 'dart:collection';

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

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }
}
