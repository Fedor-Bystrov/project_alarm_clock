import 'package:flutter/material.dart';
import 'package:projectbudy/component/alarm_tile.dart';
import 'package:projectbudy/component/common_bottom_nav_bar.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/screen/add_alarm_screen.dart';

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
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            AlarmTile("8:29 am", "Don’t Sleep, Mon Wed Fri", true),
            AlarmTile("10:00 am", "Alarm, Every Day", false),
            AlarmTile("1:00 pm", "Alarm", true),
            AlarmTile("6:20 pm", "Alarm, Every Weekday", false),
          ],
        ).toList(),
      ),
    );
  }
}
