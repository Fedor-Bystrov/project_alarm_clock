import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:projectbudy/state/alarms_list.dart';

import 'package:projectbudy/util/colors.dart';

class DoneButton extends StatelessWidget {
  final AlarmsListState alarmsListState;

  DoneButton(this.alarmsListState);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: FlutterI18n.translate(context, "appbar.done_btn.tooltip"),
      icon: Icon(
        Icons.done,
        color: CommonColors.accentColor,
      ),
      onPressed: () => alarmsListState.setDefault(),
    );
  }
}
