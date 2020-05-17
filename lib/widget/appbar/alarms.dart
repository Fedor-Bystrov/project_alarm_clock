import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class AlarmsAppBar extends AppBar {
  AlarmsAppBar({@required VoidCallback onPressed})
      : super(
          centerTitle: true,
          title: const Text("Alarms"), // TODO translation
          iconTheme: IconThemeData(color: CommonColors.accentColor),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: "Add new alarm", // TODO translations
              onPressed: onPressed,
            )
          ],
        );
}
