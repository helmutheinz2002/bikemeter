import 'package:bikemeter/dashboard.dart';
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
          trailingActions: [
            Icon(
              Icons.play_arrow,
              //color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Start recording',
            ),
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
}
