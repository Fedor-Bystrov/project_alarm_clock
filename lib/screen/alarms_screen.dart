import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/widget/alarm_tile.dart';
import 'package:projectbudy/widget//common_bottom_nav_bar.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/screen/add_alarm_screen.dart';
import 'package:projectbudy/state/alarms_state.dart';

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
      body: Consumer<AlarmsState>(
        builder: (BuildContext context, AlarmsState state, Widget child) {
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: state.alarms.map((alarm) => AlarmTile(alarm)),
            ).toList(),
          );
        },
      ),
    );
  }
}
