import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/widget/navbar/bottom.dart';
import 'package:projectbudy/widget/appbar/add_alarm.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/util/utils.dart';

class AddAlarmScreen extends StatelessWidget {
  static const String id = 'add_alarm';

  @override
  Widget build(BuildContext context) {
    var alarm = Alarm(DateTime.now(), null, "Alarm", true);
    return Scaffold(
      appBar: AddAlarmAppBar(
        context: context,
        onPressed: () async {
          await addAlarm(context, alarm);
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: ListView(
          children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            use24hFormat: is24hFormat(context),
            onDateTimeChanged: (DateTime value) {
              alarm.time = value;
            },
          ),
        ),
      ]..addAll(getAlarmModifiers(context))),
    );
  }

  Future<void> addAlarm(BuildContext context, Alarm alarm) async {
    Provider.of<AlarmsState>(context, listen: false).addAlarm(alarm);
    AndroidAlarmManager.oneShotAt(
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

  Iterable<Widget> getAlarmModifiers(BuildContext context) {
    return ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          title: const Text(
            'Repeat', // TODO translation
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Never'), // TODO translation
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CommonColors.accentColor,
            ),
            onPressed: () {
              print("repeat");
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Sound', // TODO translation
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('waltz'),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CommonColors.accentColor,
            ),
            onPressed: () {
              print("sound");
            },
          ),
        )
      ],
    );
  }
}
