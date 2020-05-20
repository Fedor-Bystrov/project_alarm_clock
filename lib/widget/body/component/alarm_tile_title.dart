import 'package:flutter/material.dart';

class AlarmTileTitle extends StatelessWidget {
  final String data;

  AlarmTileTitle(this.data);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(fontSize: 24.0),
    );
  }
}
