import 'package:bikemeter/measure_controller.dart';
import 'package:screen/screen.dart';

class ScreenLocker {
  ScreenLocker() {
    MeasureController.singleton().stateStream.listen((state) {
      if (state == MeasureState.Active) {
        keepOn();
      } else if (state == MeasureState.Stopped) {
        allowOff();
      }
    });
  }

  void keepOn() async {
    bool isKeptOn = await Screen.isKeptOn;
    if (!isKeptOn) {
      Screen.keepOn(true);
    }
  }

  void allowOff() async {
    bool isKeptOn = await Screen.isKeptOn;
    if (isKeptOn) {
      Screen.keepOn(false);
    }
  }
}
