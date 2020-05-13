import 'package:flutter/material.dart';
import 'package:projectbudy/component/alarm_tile.dart';
import 'package:projectbudy/component/common_bottom_nav_bar.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/screen/add_alarm_screen.dart';
import 'package:projectbudy/model/alarm.dart';

class AlarmsScreen extends StatelessWidget {
  static const String id = 'alarms';

  static List<Alarm> alarms = [
    Alarm("8:29 am", "Mon Wed Fri", "Don’t Sleep", true),
    Alarm("10:00 am", "Every Day", "Alarm", false),
    Alarm("1:00 pm", null, "Alarm", true),
    Alarm("6:20 pm", "Every Day", "Alarm", false),
  ];

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
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: alarms.map((alarm) => AlarmTile(alarm)),
        ).toList(),
      ),
    );
  }
}
