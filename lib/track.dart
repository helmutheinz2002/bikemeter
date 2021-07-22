import 'package:bikemeter/geo_locator.dart';

class TrackPoint {
  final GeoLocation geoLocation;
  final int timestamp;

  TrackPoint(this.geoLocation, this.timestamp);
}

class Track {
  List<TrackPoint> points = [];

  void addPoint(GeoLocation geoLocation) {
    points.add(TrackPoint(geoLocation, DateTime.now().millisecondsSinceEpoch));
  }
}
