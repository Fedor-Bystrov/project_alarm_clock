import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: CommonColors.accentColor,
      child: const Text(
        "Done",
      ),
      onPressed: () {},
    );
  }
}
