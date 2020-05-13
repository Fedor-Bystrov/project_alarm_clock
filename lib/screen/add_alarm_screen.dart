import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectbudy/component/common_bottom_nav_bar.dart';
import 'package:projectbudy/util/colors.dart';

class AddAlarmScreen extends StatelessWidget {
  static const String id = 'add_alarm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Alarm"), // TODO translation
        iconTheme: IconThemeData(color: CommonColors.accentColor),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: "Save alarm", // TODO translations
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (DateTime value) {
          print(value);
        },
      ),
    );
  }
}
