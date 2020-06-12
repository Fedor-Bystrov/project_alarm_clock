import 'package:flutter/material.dart';
import 'package:projectbudy/screen/edit_alarm.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/widget/body/component/alarm_tile/delete_btn.dart';
import 'package:projectbudy/widget/body/component/alarm_tile/forward_btn.dart';
import 'package:projectbudy/widget/body/component/alarm_tile/subtitle.dart';
import 'package:projectbudy/widget/body/component/alarm_tile/title.dart';
import 'package:projectbudy/widget/body/component/undo_snackbar.dart';

class EditAlarmTile extends StatelessWidget {
  final Alarm _alarm;

  EditAlarmTile(this._alarm);

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsState>(
      builder: (BuildContext context, AlarmsState state, Widget child) {
        return ListTile(
          enabled: _alarm.enabled,
          title: AlarmTileTitle(_alarm),
          subtitle: AlarmTileSubtitle(_alarm),
          leading: AlarmTileDeleteBtn(
            onPressed: () async {
              final deletedAlarm = _alarm;
              await state.deleteAlarm(_alarm);
              UndoSnackBar.show(
                context: context,
                onPressed: () => state.addAlarm(deletedAlarm),
              );
            },
          ),
          trailing: ForwardButton(
            onPressed: () => Navigator.pushNamed(
              context,
              EditAlarmScreen.id,
              arguments: {
                'alarm': _alarm,
              },
            ),
          ),
        );
      },
    );
  }
}
