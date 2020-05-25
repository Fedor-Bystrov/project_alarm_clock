import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
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

  // TODO
  //  1. extract to Service

  Future<void> addAlarm(BuildContext context, Alarm alarm) async {
    Provider.of<AlarmsState>(context, listen: false).addAlarm(alarm);
    AndroidAlarmManager.oneShotAt(
        // TODO don't fire immediately  after creation
        alarm.time,
        1, // TODO Track alarm Ids
        callback,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true);
  }

  static void callback(int id) {
    print("Alarm $id fired");
  }
}
