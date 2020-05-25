import 'package:flutter/material.dart';

import 'package:projectbudy/model/alarm.dart';

class AlarmTileSubtitle extends StatelessWidget {
  final Alarm _alarm;

  AlarmTileSubtitle(this._alarm);

  @override
  Widget build(BuildContext context) {
    return Text("${_alarm.label}${_alarm.repeat == null ? '' : ', ${_alarm.repeat}'} ");
  }
}
