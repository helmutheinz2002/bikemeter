import 'dart:async';

class MeasureController {
  static const int measureInterval = 2;
  var last = _Location(0);

  final _controller = StreamController<Measurement>();

  MeasureController() {
    Timer.periodic(Duration(seconds: measureInterval), measure);
  }

  Stream<Measurement> get stream => _controller.stream;

  void measure(Timer timer) {
    var current = _Location(last.pos+1);
    var measurement = Measurement(current.pos);
    _controller.sink.add(measurement);
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
