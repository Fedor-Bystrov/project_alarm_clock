import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: CommonColors.accentColor,
      child: const Text(
        "Edit",
      ),
      onPressed: () {},
    );
  }
}
