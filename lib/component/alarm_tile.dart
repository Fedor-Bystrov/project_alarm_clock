import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const padding = 16.0;

class AlarmTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('8:29 am'),
          subtitle: Text('Don’t Sleep, Mon Wed Fri'),
          trailing: Switch(
            onChanged: (p) => {},
            value: true,
          ),
          contentPadding: const EdgeInsets.fromLTRB(padding, 0, padding, 0),
        ),
        Divider(
          indent: padding,
          endIndent: padding,
        )
      ],
    );
  }
}
