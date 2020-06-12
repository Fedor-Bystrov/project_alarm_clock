import 'package:flutter/material.dart';
import 'package:projectbudy/state/alarms_list.dart';

import 'package:projectbudy/util/colors.dart';

class ForwardButton extends StatelessWidget {
  final VoidCallback onPressed;

  ForwardButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_forward,
        color: CommonColors.accentColor,
      ),
      onPressed: onPressed,
    );
  }
}
