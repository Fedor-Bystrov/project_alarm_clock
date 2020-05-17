import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/model/alarm.dart';

class AlarmTile extends StatelessWidget {
  final Alarm _alarm;

  AlarmTile(this._alarm);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _alarm,
      child: Consumer<Alarm>(
        builder: (BuildContext context, Alarm value, Widget child) {
          return ListTile(
            dense: false,
            title: Text(
              _alarm.time.toIso8601String(),
              style: const TextStyle(fontSize: 24.0),
            ),
            subtitle: Text("${_alarm.label}${_alarm.repeat == null ? '' : ', ${_alarm.repeat}'} "),
            enabled: _alarm.enabled,
            trailing: Switch(
              onChanged: (p) => _alarm.enabled = p,
              value: _alarm.enabled,
              activeColor: CommonColors.accentColor,
            ),
          );
        },
      ),
    );
  }
}
