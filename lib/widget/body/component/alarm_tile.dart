import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/util/utils.dart';

const sensitivity = 10;

enum AlarmTileState {
  NORMAL,
  EDIT,
  DELETE,
}

class AlarmTile extends StatefulWidget {
  final int _alarmIndex;

  AlarmTile(this._alarmIndex);

  @override
  _AlarmTileState createState() => _AlarmTileState(_alarmIndex);
}

class _AlarmTileState extends State<AlarmTile> {
  final int _alarmIndex;
  AlarmTileState _tileState = AlarmTileState.NORMAL;

  _AlarmTileState(this._alarmIndex);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<AlarmsState>(
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
            leading: _getLeading(state, alarm, _tileState),
            trailing: _getTrailing(state, alarm, _tileState),
          );
        },
      ),
      onHorizontalDragUpdate: _onDragUpdate,
      onTap: _onTap,
    );
  }

  Widget _getLeading(AlarmsState state, Alarm alarm, AlarmTileState tileState) {
    return null;
  }

  Widget _getTrailing(AlarmsState state, Alarm alarm, AlarmTileState tileState) {
    switch (tileState) {
      case AlarmTileState.NORMAL:
        return Switch(
          onChanged: (val) => state.switchAlarm(_alarmIndex, val),
          value: alarm.enabled,
          activeColor: CommonColors.accentColor,
        );
      case AlarmTileState.DELETE:
        return Text("delete");
      default:
        return null;
    }
  }

  void _onDragUpdate(details) {
    if (details.delta.dx > sensitivity) {
      setState(() {
        _tileState = AlarmTileState.EDIT;
      });
      print("wow right");
    } else if (details.delta.dx < -sensitivity) {
      setState(() {
        _tileState = AlarmTileState.DELETE;
      });
      print("wow left");
    }
  }

  void _onTap() {
    setState(() {
      _tileState = AlarmTileState.NORMAL;
    });
  }
}
