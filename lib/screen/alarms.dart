import 'package:flutter/material.dart';
import 'package:projectbudy/widget/appbar/alarms.dart';

import 'package:projectbudy/widget/navbar/bottom.dart';
import 'package:projectbudy/screen/add_alarm.dart';
import 'package:projectbudy/widget/body/alarms_list.dart';

class AlarmsScreen extends StatelessWidget {
  static const String id = 'alarms';

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: _AlarmsScreen(),
    );
  }
}

class _AlarmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlarmsAppBar(onPressed: () async {
        await Navigator.pushNamed(context, AddAlarmScreen.id);
        Focus.of(context).requestFocus();
      }),
      bottomNavigationBar: BottomNavBar(),
      body: AlarmsList(),
    );
  }
}
