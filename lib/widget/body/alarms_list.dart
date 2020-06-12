import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/state/alarms_list.dart';
import 'package:projectbudy/widget/body/component/default_alarm_tile.dart';
import 'package:projectbudy/widget/body/component/edit_alarm_tile.dart';

class AlarmsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsState>(
      builder: (BuildContext context, AlarmsState state, Widget child) {
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: getAlarmTiles(state, context),
          ).toList(),
        );
      },
    );
  }

  static Iterable<Widget> getAlarmTiles(AlarmsState state, BuildContext context) {
    var listState = Provider.of<AlarmsListState>(context);
    return state.alarms.map(
      (alarm) => Focus(
        key: ValueKey<Alarm>(alarm),
        child: listState.isDefault() ? DefaultAlarmTile(alarm) : EditAlarmTile(alarm),
      ),
    );
  }
}
