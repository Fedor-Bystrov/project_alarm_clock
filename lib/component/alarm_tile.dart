import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projectbudy/util/colors.dart';

class AlarmTile extends StatelessWidget {
  final String _value;
  final String _description;
  final bool _enabled;

  AlarmTile(this._value, this._description, this._enabled);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      title: Text(
        _value,
        style: const TextStyle(fontSize: 24.0),
      ),
      subtitle: Text(_description),
      enabled: _enabled,
      trailing: Switch(
        onChanged: (p) => {},
        value: _enabled,
        activeColor: CommonColors.accentColor,
      ),
    );
  }
}
