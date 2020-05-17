import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/widget/common_bottom_nav_bar.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/state/alarms_state.dart';
import 'package:projectbudy/model/alarm.dart';

class AddAlarmScreen extends StatelessWidget {
  static const String id = 'add_alarm';

  @override
  Widget build(BuildContext context) {
    var tiles = ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          title: const Text(
            'Repeat', // TODO translation
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Never'), // TODO translation
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CommonColors.accentColor,
            ),
            onPressed: () {
              print("repeat");
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Sound', // TODO translation
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('waltz'),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CommonColors.accentColor,
            ),
            onPressed: () {
              print("sound");
            },
          ),
        )
      ],
    );

    Alarm alarm = Alarm(null, null, "Alarm", false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Alarm"), // TODO translation
        iconTheme: IconThemeData(color: CommonColors.accentColor),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: "Save alarm", // TODO translations
            onPressed: () {
              Provider.of<AlarmsState>(context).addAlarm(alarm);
            },
          )
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: ListView(
          children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Container(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (DateTime value) {
                alarm.time = value;
              },
            ),
          ),
        ),
      ]..addAll(tiles)),
    );
  }
}
