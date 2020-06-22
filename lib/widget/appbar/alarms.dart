import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/state/alarms_list.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/widget/body/component/appbar/done_btn.dart';
import 'package:projectbudy/widget/body/component/appbar/edit_btn.dart';

class AlarmsAppBar {
  AlarmsAppBar._();

  static AppBar newAppBar({
    @required VoidCallback onPressed,
    @required BuildContext context,
  }) {
    var state = Provider.of<AlarmsListState>(context);
    return AppBar(
      centerTitle: true,
      title: I18nText('appbar.alarms.title'),
      iconTheme: IconThemeData(color: CommonColors.accentColor),
      leading: state.isDefault() ? EditButton(state) : DoneButton(state),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: FlutterI18n.translate(context, "appbar.alarms.tooltip"),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
