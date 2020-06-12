import 'package:flutter/material.dart';
import 'package:projectbudy/state/alarms_list.dart';

import 'package:projectbudy/util/colors.dart';

class DoneButton extends StatelessWidget {
  final AlarmsListState alarmsListState;

  DoneButton(this.alarmsListState);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: CommonColors.accentColor,
      child: const Text(
        "Done",
      ),
      onPressed: () => alarmsListState.currentStatus = AlarmsListStatus.DEFAULT,
    );
  }
}
