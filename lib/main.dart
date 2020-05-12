import 'package:flutter/material.dart';
import 'package:projectbudy/screen/alarms_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlarmsScreen(),
    );
  }
}
