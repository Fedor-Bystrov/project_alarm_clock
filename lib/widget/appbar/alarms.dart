import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/widget/body/component/appbar/edit_btn.dart';

class AlarmsAppBar {
  AlarmsAppBar._();

  static AppBar newAppBar({@required VoidCallback onPressed}) {
    return AppBar(
      centerTitle: true,
      title: const Text("Alarms"),
      // TODO translation
      iconTheme: IconThemeData(color: CommonColors.accentColor),
      leading: EditButton(),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: "Add new alarm", // TODO translations
          onPressed: onPressed,
        ),
      ],
    );
  }
}
