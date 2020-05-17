import 'package:flutter/material.dart';
import 'package:projectbudy/widget/appbar/alarms.dart';

import 'package:projectbudy/widget/navbar/bottom.dart';
import 'package:projectbudy/screen/add_alarm.dart';
import 'package:projectbudy/widget/body/alarms_list.dart';

class AlarmsScreen extends StatelessWidget {
  static const String id = 'alarms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlarmsAppBar(onPressed: () => Navigator.pushNamed(context, AddAlarmScreen.id)),
      bottomNavigationBar: BottomNavBar(),
      body: AlarmsList(),
    );
  }
}
