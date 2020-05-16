import 'package:flutter/material.dart';

class Alarm extends ChangeNotifier {
  String _time;
  String _repeat;
  String _label;
  bool _enabled;

  Alarm(this._time, this._repeat, this._label, this._enabled);

  bool get enabled => _enabled;

  String get label => _label;

  String get repeat => _repeat;

  String get time => _time;

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

  set time(String value) {
    _time = value;
    notifyListeners();
  }
}
