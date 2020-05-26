import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/service/alarm_manager.dart';
import 'package:projectbudy/widget/appbar/edit_alarm.dart';
import 'package:projectbudy/widget/body/add_alarm.dart';
import 'package:projectbudy/widget/navbar/bottom.dart';

class AddAlarmScreen extends StatelessWidget {
  static const String id = 'add_alarm';

  @override
  Widget build(BuildContext context) {
    var alarm = Alarm(DateTime.now(), null, "Alarm", true);
    return Scaffold(
      appBar: EditAlarmAppBar(
        context: context,
        title: const Text("Add Alarm"), // TODO translation
        onPressed: () async {
          await addAlarm(context, alarm);
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: BottomNavBar(),
      body: AddAlarmBody(
        context: context,
        alarm: alarm,
      ),
    );
  }

  Future<void> addAlarm(BuildContext context, Alarm alarm) async {
    AlarmManager.addAlarm(alarm);
    Provider.of<AlarmsState>(context, listen: false).addAlarm(alarm);
  }
}
