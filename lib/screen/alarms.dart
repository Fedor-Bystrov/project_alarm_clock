import 'package:flutter/material.dart';

import 'package:projectbudy/widget/navbar/bottom.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/screen/add_alarm.dart';
import 'package:projectbudy/widget/alarms_list.dart';

class AlarmsScreen extends StatelessWidget {
  static const String id = 'alarms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Alarms"), // TODO translation
        iconTheme: IconThemeData(color: CommonColors.accentColor),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add new alarm", // TODO translations
            onPressed: () {
              Navigator.pushNamed(context, AddAlarmScreen.id);
            },
          )
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: AlarmsList(),
    );
  }
}
