import 'package:flutter/material.dart';
import 'package:projectbudy/screen/alarms_screen.dart';
import 'package:projectbudy/screen/add_alarm_screen.dart';
import 'package:projectbudy/util/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Budy",
      theme: ThemeData(
        primaryColor: CommonColors.primaryColor,
      ),
      initialRoute: AlarmsScreen.id,
      routes: {
        AlarmsScreen.id: (context) => AlarmsScreen(),
        AddAlarmScreen.id: (context) => AddAlarmScreen(),
      },
    );
  }
}
