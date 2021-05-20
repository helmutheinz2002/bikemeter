import 'dart:async';
import 'dart:math';
import 'package:location/location.dart';
import 'package:circular_buffer/circular_buffer.dart';
import 'package:rxdart/rxdart.dart';

enum MeasureState { Active, Paused, Stopping, Stopped }

class MeasureController {
  static const int measureInterval = 2;
  static MeasureController instance;
  final Location _location = new Location();
  final CircularBuffer<LocationData> buffer = CircularBuffer<LocationData>(5);
  MeasureState state = MeasureState.Stopped;

  final _measureController = BehaviorSubject<Measurement>();
  final _stateController = BehaviorSubject<MeasureState>();

  Stream<Measurement> get measureStream => _measureController.stream;

  Stream<MeasureState> get stateStream =>
      _stateController.stream;

  static MeasureController singleton() {
    if(instance==null) {
      instance = MeasureController();
    }
    return instance;
  }

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
      buffer.reset();
      _stateController.add(state);
    }

    if (state == MeasureState.Active) {
      _location.getLocation().then((LocationData locationData) {
        var measurement = Measurement();
        _measureController.add(measurement);
        buffer.add(locationData);
        print(
            "location ${locationData.latitude},${locationData.longitude},${locationData.altitude},${locationData.speed}");
      }, onError: (e) {
        print("Location error $e");
      });
    }
  }
}

class Measurement {
  double distanceTotal;
  double distanceTrip;
  double speed;
  double speedMax;
  double speedAvg;
  double speedStdDeviation;
  double elevation;
  double climbTotal;
  Duration timeMoving;
  Duration timeTotal;

  static Random rnd = Random(0);

  Measurement() {
    distanceTotal = rnd.nextDouble();
    distanceTrip = rnd.nextDouble();
    speed = rnd.nextDouble();
    speedAvg = rnd.nextDouble();
    speedMax = rnd.nextDouble();
    speedStdDeviation = rnd.nextDouble();
    elevation = rnd.nextDouble();
    climbTotal = rnd.nextDouble();
    timeMoving = Duration(seconds: rnd.nextInt(6000));
    timeTotal = Duration(seconds: rnd.nextInt(6000));
  }
}
