import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class EditAlarmAppBar extends AppBar {
  EditAlarmAppBar(
      {@required BuildContext context, @required VoidCallback onPressed, @required Text title})
      : super(
          centerTitle: true,
          title: title,
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
