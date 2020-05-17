import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool is24hFormat(BuildContext context) => MediaQuery.of(context).alwaysUse24HourFormat;

DateFormat getDateFormat(BuildContext context) {
  return MediaQuery.of(context).alwaysUse24HourFormat ? DateFormat.Hm() : DateFormat.jm();
}
