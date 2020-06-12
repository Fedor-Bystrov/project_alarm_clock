import 'package:flutter/material.dart';
import 'package:projectbudy/state/alarms_list.dart';

import 'package:projectbudy/util/colors.dart';

class EditButton extends StatelessWidget {

  final AlarmsListState alarmsListState;

  EditButton(this.alarmsListState);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: CommonColors.accentColor,
      child: const Text(
        "Edit",
      ),
      onPressed: () => alarmsListState.currentStatus = AlarmsListStatus.EDIT,
    );
  }
}
