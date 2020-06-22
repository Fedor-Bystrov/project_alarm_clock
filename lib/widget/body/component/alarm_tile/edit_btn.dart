import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:projectbudy/util/colors.dart';

class AlarmTileEditBtn extends StatelessWidget {
  final VoidCallback onPressed;

  AlarmTileEditBtn({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: CommonColors.accentColor,
        shape: CircleBorder(),
      ),
      child: IconButton(
        tooltip: FlutterI18n.translate(context, "alarmTileEditBtnTooltip"),
        icon: Icon(
          Icons.edit,
          color: CommonColors.primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
