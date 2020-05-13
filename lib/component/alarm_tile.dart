import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/model/alarm.dart';

class AlarmTile extends StatelessWidget {
  final Alarm _alarm;

  AlarmTile(this._alarm);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      title: Text(
        _alarm.time,
        style: const TextStyle(fontSize: 24.0),
      ),
      subtitle: Text("${_alarm.label}${_alarm.repeat == null ? '' : ', ${_alarm.repeat}'} "),
      enabled: _alarm.enabled,
      trailing: Switch(
        onChanged: (p) => {},
        value: _alarm.enabled,
        activeColor: CommonColors.accentColor,
      ),
    );
  }
}
