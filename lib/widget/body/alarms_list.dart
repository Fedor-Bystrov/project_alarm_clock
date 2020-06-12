import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/widget/body/component/default_alarm_tile.dart';
import 'package:projectbudy/state/alarms.dart';

class AlarmsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsState>(
      builder: (BuildContext context, AlarmsState state, Widget child) {
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: getAlarmTiles(state),
          ).toList(),
        );
      },
    );
  }

  static Iterable<Widget> getAlarmTiles(AlarmsState state) {
    return state.alarms.map((alarm) => Focus(key: ValueKey<Alarm>(alarm), child: DefaultAlarmTile(alarm)));
  }
}
