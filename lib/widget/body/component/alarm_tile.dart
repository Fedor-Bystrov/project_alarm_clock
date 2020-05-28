import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/screen/edit_alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'alarm_tile/edit_btn.dart';
import 'alarm_tile/switch.dart';
import 'alarm_tile/delete_btn.dart';
import 'alarm_tile/subtitle.dart';
import 'alarm_tile/title.dart';
import 'undo_snackbar.dart';

enum TileState {
  DEFAULT,
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
  TileState _tileState = TileState.DEFAULT;

  final int _alarmIndex;

  _AlarmTileState(this._alarmIndex);

  @override
  void didUpdateWidget(AlarmTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Bug fix. Reset alarm tiles states
    // on every alarms list re-render.
    _changeTileState(TileState.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsState>(
      builder: (BuildContext context, AlarmsState state, _) {
        final alarm = state.alarms[_alarmIndex];
        final focusNode = Focus.of(context);
        final currentState = focusNode.hasFocus ? _tileState : TileState.DEFAULT;
        return GestureDetector(
          child: ListTile(
            enabled: alarm.enabled,
            title: AlarmTileTitle(alarm),
            subtitle: AlarmTileSubtitle(alarm),
            leading: getLeading(context, currentState, _alarmIndex),
            trailing: getTrailing(state, _alarmIndex, currentState, context),
          ),
          onHorizontalDragEnd: (d) => _onDragUpdate(d, focusNode),
          onTap: () => _onTap(focusNode),
        );
      },
    );
  }

  void _onDragUpdate(DragEndDetails details, FocusNode focusNode) {
    focusNode.requestFocus();
    // swipe right
    if (details.primaryVelocity > 0) {
      if (_tileState == TileState.DELETE) {
        _changeTileState(TileState.DEFAULT);
      } else {
        _changeTileState(TileState.EDIT);
      }
      return;
    }

    // swipe left
    if (details.primaryVelocity < 0) {
      if (_tileState == TileState.EDIT) {
        _changeTileState(TileState.DEFAULT);
      } else {
        _changeTileState(TileState.DELETE);
      }
      return;
    }
  }

  void _onTap(FocusNode focusNode) {
    focusNode.requestFocus();
    _changeTileState(TileState.DEFAULT);
  }

  void _changeTileState(TileState desiredState) {
    if (_tileState != desiredState) {
      setState(() {
        _tileState = desiredState;
      });
    }
  }
}

Widget getLeading(BuildContext context, TileState tileState, int alarmIndex) {
  return tileState != TileState.EDIT
      ? null
      : AlarmTileEditBtn(
          onPressed: () => Navigator.pushNamed(
            context,
            EditAlarmScreen.id,
            arguments: {
              'alarmIndex': alarmIndex,
            },
          ),
        );
}

Widget getTrailing(AlarmsState state, int alarmIndex, TileState tileState, BuildContext context) {
  final alarm = state.alarms[alarmIndex];
  switch (tileState) {
    case TileState.DEFAULT:
      return AlarmTileSwitch(
        enabled: alarm.enabled,
        onChanged: (val) => state.switchAlarm(alarmIndex, val),
      );
    case TileState.DELETE:
      return AlarmTileDeleteBtn(
        onPressed: () async {
          final deletedAlarm = state.alarms[alarmIndex];
          await state.deleteAlarm(alarmIndex);
          UndoSnackBar.show(
            context: context,
            onPressed: () => state.addAlarm(deletedAlarm),
          );
        },
      );
    default:
      return null;
  }
}
