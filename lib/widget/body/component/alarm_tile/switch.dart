import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class AlarmTileSwitch extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  // TODO change according to design
  AlarmTileSwitch({@required this.enabled, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: onChanged,
      value: enabled,
      activeColor: CommonColors.accentColor,
    );
  }
}
