import 'package:flutter/material.dart';

class Alarm extends ChangeNotifier {
  DateTime _time;
  String _repeat;
  String _label;
  bool _enabled;

  Alarm(this._time, this._repeat, this._label, this._enabled);

  bool get enabled => _enabled;

  String get label => _label;

  String get repeat => _repeat;

  DateTime get time => _time;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  set label(String value) {
    _label = value;
    notifyListeners();
  }

  set repeat(String value) {
    _repeat = value;
    notifyListeners();
  }

  set time(DateTime value) {
    _time = value;
    notifyListeners();
  }

  Alarm.fromJson(Map<String, dynamic> json)
    : _time = DateTime.parse(json['time']),
      _repeat = json['repeat'],
      _label = json['label'],
      _enabled = json['enabled'];

  Map<String, dynamic> toJson() => {
        'time': _time.toIso8601String(),
        'repeat': _repeat,
        'label': _label,
        'enabled': _enabled,
      };
}
