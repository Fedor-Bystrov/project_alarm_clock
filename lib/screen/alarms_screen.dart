import 'package:flutter/material.dart';
import 'package:projectbudy/component/alarm_tile.dart';
import 'package:projectbudy/component/common_bottom_nav_bar.dart';
import 'package:projectbudy/component/common_app_bar.dart';

class AlarmsScreen extends StatelessWidget {
  static const String id = 'alarms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
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
