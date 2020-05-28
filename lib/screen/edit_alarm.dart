import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/widget/appbar/edit_alarm.dart';
import 'package:projectbudy/widget/body/edit_alarm.dart';
import 'package:projectbudy/widget/navbar/bottom.dart';

class EditAlarmScreen extends StatelessWidget {
  static const String id = 'edit_alarm';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AlarmsState>(context);
    final Map<String, Alarm> arguments = ModalRoute.of(context).settings.arguments;
    final Alarm initial = arguments['alarm'];
    final Alarm updated = Alarm.copy(initial);
    return Scaffold(
      appBar: EditAlarmAppBar(
          context: context,
          title: const Text("Edit Alarm"), // TODO translation
          onPressed: () async {
            await state.updateAlarm(initial, updated);
            Navigator.pop(context);
          }),
      bottomNavigationBar: BottomNavBar(),
      body: EditAlarmBody(
        context: context,
        alarm: updated,
      ),
    );
  }
}
