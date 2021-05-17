import 'dart:async';

enum MeasureState { Active, Paused, Stopping, Stopped }

class MeasureController {
  static const int measureInterval = 2;
  var last = _Location(0);
  MeasureState state = MeasureState.Stopped;

  final _measureController = StreamController<Measurement>();
  final _stateController = StreamController<MeasureState>.broadcast();

  Stream<Measurement> get measureStream => _measureController.stream;

  Stream<MeasureState> get stateStream => _stateController.stream.asBroadcastStream();

  void start() {
    print('Start');
    state = MeasureState.Active;
    _stateController.add(state);
    Timer.periodic(Duration(seconds: measureInterval), _measure);
  }

  void pause() {
    print('Pause');
    if (state == MeasureState.Active) {
      state = MeasureState.Paused;
      _stateController.add(state);
    }
  }

  void stop() {
    print('Stop');
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

    var current = _Location(last.pos + 1);
    var measurement = Measurement(current.pos);
    _measureController.add(measurement);
    last = current;
  }
}

class Measurement {
  double distance;

  Measurement(this.distance);
}

class _Location {
  _Location(this.pos);

  double pos;
}
