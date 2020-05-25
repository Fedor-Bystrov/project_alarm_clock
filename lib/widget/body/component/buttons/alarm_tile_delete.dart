import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class AlarmTileDeleteBtn extends StatelessWidget {
  final VoidCallback onPressed;

  AlarmTileDeleteBtn({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: CommonColors.error,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: CommonColors.primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
