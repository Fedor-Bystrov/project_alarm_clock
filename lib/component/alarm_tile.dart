import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const padding = 16.0;

class AlarmTile extends StatelessWidget {
  final Text _value;
  final Text _description;
  final bool _enabled;

  AlarmTile(this._value, this._description, this._enabled);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: _value,
          subtitle: _description,
          enabled: _enabled,
          trailing: Switch(
            onChanged: (p) => {},
            value: _enabled,
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
