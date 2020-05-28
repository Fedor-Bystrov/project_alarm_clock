import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/widget/appbar/edit_alarm.dart';
import 'package:projectbudy/widget/body/edit_alarm.dart';
import 'package:projectbudy/widget/navbar/bottom.dart';

class EditAlarmScreen extends StatelessWidget {
  static const String id = 'edit_alarm';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AlarmsState>(context);
    final Map<String, int> arguments = ModalRoute.of(context).settings.arguments;
    final alarm = state.alarms[arguments['alarmIndex']];
    return Scaffold(
      appBar: EditAlarmAppBar(
          context: context,
          title: const Text("Edit Alarm"), // TODO translation
          onPressed: () async {
            await state.updateAlarm(alarm);
            Navigator.pop(context);
          }),
      bottomNavigationBar: BottomNavBar(),
      body: EditAlarmBody(
        context: context,
        alarm: alarm,
      ),
    );
  }
}
