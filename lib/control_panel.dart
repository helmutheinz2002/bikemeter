import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';
import 'measure_controller.dart';
import 'measure_controller.dart';

class ControlPanel extends StatefulWidget {
  ControlPanel({Key key}) : super(key: key);

  @override
  ControlPanelState createState() => ControlPanelState();
}

class ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: MeasureState.Stopped,
      stream: MeasureController.singleton().stateStream,
      builder: (BuildContext context, AsyncSnapshot<MeasureState> snapshot) {
        return Row(
          children: [
            createButton(
                context,
                Icons.stop,
                AppLocalizations.of(context).translate('stop'),
                20,
                getStopCB(snapshot.data)),
            createButton(
                context,
                Icons.pause,
                AppLocalizations.of(context).translate('pause'),
                20,
                getPauseCB(snapshot.data)),
            createButton(
                context,
                Icons.play_circle_fill,
                AppLocalizations.of(context).translate('start'),
                40,
                getStartCB(snapshot.data)),
          ],
        );
      },
    );
  }

  static dynamic createButton(BuildContext context, IconData iconData, String label,
      double size, void onPressedCB()) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return SizedBox(
        height: size + 10,
        width: size + 10,
        child: CupertinoButton(
          padding: EdgeInsets.all(1),
          child: Icon(
            iconData,
            size: size,
            semanticLabel: label,
          ),
          onPressed: onPressedCB,
        ),
      );
    }
    return IconButton(
      padding: EdgeInsets.all(1),
      onPressed: onPressedCB,
      icon: Icon(
        iconData,
        size: size,
        semanticLabel: label,
      ),
    );
  }

  Function getPauseCB(MeasureState state) {
    if (state == MeasureState.Active) {
      return () {
        MeasureController.singleton().pause();
      };
    }
    return null;
  }

  Function getStopCB(MeasureState state) {
    if (state == MeasureState.Active || state == MeasureState.Paused) {
      return () {
        MeasureController.singleton().stop();
      };
    }
    return null;
  }

  Function getStartCB(MeasureState state) {
    if (state == MeasureState.Stopped || state == MeasureState.Paused) {
      return () {
        MeasureController.singleton().start();
      };
    }
    return null;
  }
}
