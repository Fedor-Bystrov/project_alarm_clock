import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:projectbudy/state/alarms_list.dart';

import 'package:projectbudy/util/colors.dart';

class EditButton extends StatelessWidget {
  final AlarmsListState alarmsListState;

  EditButton(this.alarmsListState);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: FlutterI18n.translate(context, "appbar.edit_btn.tooltip"),
      icon: Icon(
        Icons.edit,
        color: CommonColors.accentColor,
      ),
      onPressed: () => alarmsListState.setEdit(),
    );
  }
}
