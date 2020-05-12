import 'package:flutter/material.dart';
import 'package:projectbudy/component/alarm_tile.dart';
import 'package:projectbudy/component/common_bottom_nav_bar.dart';
import 'package:projectbudy/component/common_app_bar.dart';

class AlarmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: ListView(
        children: <Widget>[
          AlarmTile(),
          AlarmTile(),
          AlarmTile(),
        ],
      ),
    );
  }
}
