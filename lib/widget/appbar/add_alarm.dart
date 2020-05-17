import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class AddAlarmAppBar extends AppBar {
  AddAlarmAppBar({@required BuildContext context, @required VoidCallback onPressed})
      : super(
          centerTitle: true,
          title: const Text("Add Alarm"), // TODO translation
          iconTheme: IconThemeData(color: CommonColors.accentColor),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              tooltip: "Save alarm", // TODO translations
              onPressed: onPressed,
            )
          ],
        );
}
