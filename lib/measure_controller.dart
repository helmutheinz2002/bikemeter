import 'dart:async';
import 'dart:math';

//import 'package:location/location.dart';
import 'package:bikemeter/geo_locator.dart';
import 'package:circular_buffer/circular_buffer.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:geolocator/geolocator.dart';

enum MeasureState { Active, Paused, Stopping, Stopped }

class MeasureController {
  static const int measureInterval = 2;
  static MeasureController instance;
  final GeoLocation _location = new GeoLocation(0, 0, 0);
  bool _measuring = false;

  //final CircularBuffer<LocationData> buffer = CircularBuffer<LocationData>(5);
  final GeoLocator _geoLocator = GeoLocator();
  MeasureState state = MeasureState.Stopped;

  final _measureController = BehaviorSubject<Measurement>();
  final _stateController = BehaviorSubject<MeasureState>();

  Stream<Measurement> get measureStream => _measureController.stream;

  Stream<MeasureState> get stateStream => _stateController.stream;

  static MeasureController singleton() {
    if (instance == null) {
      instance = MeasureController();
    }
    return instance;
  }

  void start() async {
    bool serviceEnabled = await _geoLocator.enableLocation();
    if (!serviceEnabled) {
      return;
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
      _measuring=false;
      timer.cancel();
//      buffer.reset();
      _stateController.add(state);
    }

    if (state == MeasureState.Active) {
      if(_measuring) {
        return;
      }

      _measuring=true;
      _geoLocator.getLocation().then((GeoLocation location) {
        _measuring=false;
        var measurement = Measurement();
        _measureController.add(measurement);
//        buffer.add(location);
        print(
            "location lat=${location.latitude}, long=${location.longitude}, alt=${location.altitude}");
      }, onError: (e) {
        _measuring=false;
        stop();
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
