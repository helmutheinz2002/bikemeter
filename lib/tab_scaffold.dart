import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'app_localizations.dart';
import 'control_panel.dart';
import 'dashboard.dart';
import 'main.dart';
import 'measure_controller.dart';
import 'settings_page.dart';

class TabScaffold extends StatelessWidget {
  const TabScaffold({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return PlatformTabScaffold(
      tabController: PlatformTabController(),
      appBarBuilder: createAppBar,
      items: [
        BottomNavigationBarItem(
          icon: Icon(isIOS ? CupertinoIcons.rocket : Icons.directions_bike),
          label: AppLocalizations.of(context).translate('current'),
        ),
        BottomNavigationBarItem(
          icon: Icon(isIOS ? CupertinoIcons.clock : Icons.history),
          label: AppLocalizations.of(context).translate('history'),
        ),
        BottomNavigationBarItem(
          icon: Icon(isIOS ? CupertinoIcons.gear : Icons.settings),
          label: AppLocalizations.of(context).translate('settings'),
        ),
      ],
      bodyBuilder: createContent,
    );
  }

  PlatformAppBar createAppBar(BuildContext context, int index) {
    return PlatformAppBar(
      title: Text(Bikemeter.appName),
      trailingActions: [
        ControlPanel(),
      ],
    );
  }

  Widget createContent(BuildContext context, int index) {
    if (index == 0) {
      return SafeArea(
        child: Center(
          child: Dashboard(),
        ),
      );
    } else if (index == 1) {
      return SafeArea(
        child: Center(
          child: Text('History Page'),
        ),
      );
    } else {
      return SafeArea(
        child: Center(
          child: Text('Settings Page'),
        ),
      );
    }
  }
}
