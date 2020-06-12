import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/screen/edit_alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'alarm_tile/edit_btn.dart';
import 'alarm_tile/switch.dart';
import 'alarm_tile/delete_btn.dart';
import 'alarm_tile/subtitle.dart';
import 'alarm_tile/title.dart';
import 'undo_snackbar.dart';

enum TileState {
  NORMAL,
  EDIT,
  DELETE,
}

class AlarmTile extends StatefulWidget {
  final Alarm _alarm;

  AlarmTile(this._alarm);

  @override
  _AlarmTileState createState() => _AlarmTileState(_alarm);
}

class _AlarmTileState extends State<AlarmTile> {
  TileState _tileState = TileState.NORMAL;

  final Alarm _alarm;

  _AlarmTileState(this._alarm);

  @override
  void didUpdateWidget(AlarmTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Bug fix. Reset alarm tiles states
    // on every alarms list re-render.
    _changeTileState(TileState.NORMAL);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsState>(
      builder: (BuildContext context, AlarmsState alarmsState, _) {
        final focusNode = Focus.of(context);
        final currentState = focusNode.hasFocus ? _tileState : TileState.NORMAL;
        return GestureDetector(
          child: ListTile(
            enabled: _alarm.enabled,
            title: AlarmTileTitle(_alarm),
            subtitle: AlarmTileSubtitle(_alarm),
            leading: getLeading(context, currentState),
            trailing: getTrailing(context, alarmsState, currentState),
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
        _changeTileState(TileState.NORMAL);
      } else {
        _changeTileState(TileState.EDIT);
      }
      return;
    }

    // swipe left
    if (details.primaryVelocity < 0) {
      if (_tileState == TileState.EDIT) {
        _changeTileState(TileState.NORMAL);
      } else {
        _changeTileState(TileState.DELETE);
      }
      return;
    }
  }

  void _onTap(FocusNode focusNode) {
    focusNode.requestFocus();
    _changeTileState(TileState.NORMAL);
  }

  void _changeTileState(TileState desiredState) {
    if (_tileState != desiredState) {
      setState(() {
        _tileState = desiredState;
      });
    }
  }

  Widget getLeading(BuildContext context, TileState currentState) {
    return currentState != TileState.EDIT
        ? null
        : AlarmTileEditBtn(
            onPressed: () => Navigator.pushNamed(
              context,
              EditAlarmScreen.id,
              arguments: {
                'alarm': _alarm,
              },
            ),
          );
  }

  Widget getTrailing(BuildContext context, AlarmsState alarmsState, TileState currentState) {
    switch (currentState) {
      case TileState.NORMAL:
        return AlarmTileSwitch(
          enabled: _alarm.enabled,
          onChanged: (val) async => await alarmsState.switchAlarm(_alarm, val),
        );
      case TileState.DELETE:
        return AlarmTileDeleteBtn(
          onPressed: () async {
            final deletedAlarm = _alarm;
            await alarmsState.deleteAlarm(_alarm);
            UndoSnackBar.show(
              context: context,
              onPressed: () => alarmsState.addAlarm(deletedAlarm),
            );
          },
        );
      default:
        return null;
    }
  }
}
