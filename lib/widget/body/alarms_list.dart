import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/widget/body/component/alarm_tile.dart';
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
    return Iterable<int>.generate(state.alarms.length).map((idx) => AlarmTile(idx));
  }
}
