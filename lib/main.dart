import 'package:bikemeter/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Bikemeter',
      home: PlatformScaffold(
        appBar: PlatformAppBar(
          leading: Icon(
            Icons.menu,
            size: 24.0,
            semanticLabel: 'Start recording',
          ),
          trailingActions: [
            _createButton(context, Icons.pause, 'Pause recording'),
            _createButton(context, Icons.stop, 'Stop recording'),
            _createButton(context, Icons.play_arrow, 'Start recording'),
          ],
          title: Text('Bikemeter'),
        ),
        body: SafeArea(
          child: Center(
            child: Dashboard(),
          ),
        ),
      ),
    );
  }

  dynamic _createButton(BuildContext context, IconData iconData, String label) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return SizedBox(
        height: 30,
        width: 30,
        child: CupertinoButton(
          padding: EdgeInsets.all(1),
          child: Icon(
            iconData,
            size: 20.0,
            semanticLabel: label,
          ),
          onPressed: () => {},
        ),
      );
    }
    return IconButton(
      onPressed: () => {},
      icon: Icon(
        iconData,
        size: 30.0,
        semanticLabel: label,
      ),
    );
  }
}
