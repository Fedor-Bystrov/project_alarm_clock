import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:projectbudy/util/colors.dart';

class AlarmTileDeleteBtn extends StatelessWidget {
  final VoidCallback onPressed;

  AlarmTileDeleteBtn({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: CommonColors.error,
        shape: CircleBorder(),
      ),
      child: IconButton(
        tooltip: FlutterI18n.translate(context, "alarm_tile.delete_btn.tooltip"),
        icon: Icon(
          Icons.delete_forever,
          color: CommonColors.primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
