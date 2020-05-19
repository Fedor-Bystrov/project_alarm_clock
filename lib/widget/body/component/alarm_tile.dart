import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/util/utils.dart';

class AlarmTile extends StatelessWidget {
  final int _alarmIndex;

  AlarmTile(this._alarmIndex);

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsState>(
      builder: (BuildContext context, AlarmsState state, Widget child) {
        final alarm = state.alarms[_alarmIndex];
        return ListTile(
          dense: false,
          title: Text(
            getDateFormat(context).format(alarm.time),
            style: const TextStyle(fontSize: 24.0), // TODO extract common styles
          ),
          subtitle: Text("${alarm.label}${alarm.repeat == null ? '' : ', ${alarm.repeat}'} "),
          enabled: alarm.enabled,
          trailing: Switch(
            onChanged: (val) => state.switchAlarm(_alarmIndex, val),
            value: alarm.enabled,
            activeColor: CommonColors.accentColor,
          ),
        );
      },
    );
  }
}
