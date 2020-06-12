import 'package:flutter/material.dart';

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
        icon: Icon(
          Icons.edit,
          color: CommonColors.primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
