import 'dart:async';
import 'package:location/location.dart';

enum MeasureState { Active, Paused, Stopping, Stopped }

class MeasureController {
  static const int measureInterval = 2;
  Location _location = new Location();
  LocationData last;
  MeasureState state = MeasureState.Stopped;

  final _measureController = StreamController<Measurement>();
  final _stateController = StreamController<MeasureState>.broadcast();

  Stream<Measurement> get measureStream => _measureController.stream;

  Stream<MeasureState> get stateStream =>
      _stateController.stream.asBroadcastStream();

  void start() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    state = MeasureState.Active;
    _stateController.add(state);
    Timer.periodic(Duration(seconds: measureInterval), _measure);
  }

  void pause() {
    if (state == MeasureState.Active) {
      state = MeasureState.Paused;
      _stateController.add(state);
    }
  }

  void stop() {
    if (state == MeasureState.Active || state == MeasureState.Paused) {
      state = MeasureState.Stopping;
      _stateController.add(state);
    }
  }

  void _measure(Timer timer) {
    if (state == MeasureState.Stopping) {
      state = MeasureState.Stopped;
      timer.cancel();
      _stateController.add(state);
    }

    _location.getLocation().then((LocationData locationData) {
      var measurement = Measurement(locationData.altitude);
      _measureController.add(measurement);
      last = locationData;
      print(
          "location (${locationData.latitude},${locationData
              .longitude},${locationData.altitude})");
    }, onError: (e) {
      print("Location error $e");
    });
  }
}

class Measurement {
  double distance;

  Measurement(this.distance);
}
