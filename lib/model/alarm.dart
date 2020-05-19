import 'package:flutter/material.dart';

class Alarm {
  DateTime time;
  String repeat;
  String label;
  bool enabled;

  Alarm(this.time, this.repeat, this.label, this.enabled);

  Alarm.fromJson(Map<String, dynamic> json)
    : time = DateTime.parse(json['time']),
      repeat = json['repeat'],
      label = json['label'],
      enabled = json['enabled'];

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'repeat': repeat,
        'label': label,
        'enabled': enabled,
      };

  @override
  String toString() {
    return '{time: $time, repeat: $repeat, label: $label, enabled: $enabled}';
  }
}
