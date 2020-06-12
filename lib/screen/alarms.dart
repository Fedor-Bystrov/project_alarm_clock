import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/screen/add_alarm.dart';
import 'package:projectbudy/state/alarms_list.dart';
import 'package:projectbudy/widget/appbar/alarms.dart';
import 'package:projectbudy/widget/body/alarms_list.dart';
import 'package:projectbudy/widget/navbar/bottom.dart';

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
    var listState = Provider.of<AlarmsListState>(context);
    return Scaffold(
      appBar: AlarmsAppBar.newAppBar(
        context: context,
        onPressed: () async {
          await Navigator.pushNamed(context, AddAlarmScreen.id);
          listState.setDefault();
          Focus.of(context).requestFocus();
        },
      ),
      bottomNavigationBar: BottomNavBar(),
      body: AlarmsList(),
    );
  }
}
