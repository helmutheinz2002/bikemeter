import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(),
        body: SafeArea(
          child: Center(
            child: Text('Settings'),
          ),
        ),
        bottomNavBar: PlatformNavBar(),
        iosContentPadding: false,
        iosContentBottomPadding: false);
  }
}
