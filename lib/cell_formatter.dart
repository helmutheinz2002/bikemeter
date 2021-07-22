import 'package:bikemeter/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'measure_controller.dart';

abstract class CellFormatter {
  final String title;
  final String upperLabel;
  final String lowerLabel;
  final String unit;
  final IconData icon;

  const CellFormatter(this.title, this.upperLabel, this.lowerLabel, this.unit, this.icon);

  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper);
}

class CellFormatters {
  static const CellFormatter speedCellFormatter = SpeedCellFormatter();
  static const CellFormatter distanceCellFormatter = DistanceCellFormatter();
  static const CellFormatter elevationCellFormatter = ElevationCellFormatter();
  static const CellFormatter timeCellFormatter = TimeCellFormatter();
}

class TimeCellFormatter extends CellFormatter {
  const TimeCellFormatter() : super("time", "moving", "total", "h", CupertinoIcons.clock);

  String formatDuration(Duration d) {
    return d.toString().split('.')[0];
  }

  @override
  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper) =>
      upper ? formatDuration(measurement.timeMoving) : formatDuration(measurement.timeTotal);
}

class SpeedCellFormatter extends CellFormatter {
  const SpeedCellFormatter() : super("speed", "average", "maximum", "km/h", CupertinoIcons.speedometer);

  @override
  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper) =>
      AppLocalizations.of(context)
          .format(upper ? measurement.speedAvg : measurement.speedMax);
}

class ElevationCellFormatter extends CellFormatter {
  const ElevationCellFormatter() : super("elevation", "current", "climb", "m", CupertinoIcons.arrow_up_arrow_down);

  @override
  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper) =>
      AppLocalizations.of(context)
          .format(upper ? measurement.elevation : measurement.climbTotal);
}

class DistanceCellFormatter extends CellFormatter {
  const DistanceCellFormatter() : super("distance", "trip", "total", "km", CupertinoIcons.placemark);

  @override
  String pickAndFormat(
          BuildContext context, Measurement measurement, bool upper) =>
      AppLocalizations.of(context)
          .format(upper ? measurement.distanceTrip : measurement.distanceTotal);
}
