import 'package:bikemeter/app_localizations.dart';
import 'package:flutter/material.dart';

import 'measure_controller.dart';

abstract class CellFormatter {
  final String title;
  final String upperLabel;
  final String lowerLabel;
  final String upperUnit;
  final String lowerUnit;

  const CellFormatter(this.title, this.upperLabel, this.upperUnit, this.lowerLabel, this.lowerUnit);

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
  const TimeCellFormatter() : super("time", "moving", "h", "total", "h");

  String formatDuration(Duration d) {
    return d.toString().split('.')[0];
  }

  @override
  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper) =>
      upper ? formatDuration(measurement.timeMoving) : formatDuration(measurement.timeTotal);
}

class SpeedCellFormatter extends CellFormatter {
  const SpeedCellFormatter() : super("speed", "average", "km/h", "maximum", "km/h");

  @override
  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper) =>
      AppLocalizations.of(context)
          .format(upper ? measurement.speedAvg : measurement.speedMax);
}

class ElevationCellFormatter extends CellFormatter {
  const ElevationCellFormatter() : super("elevation", "current", "masl", "climb", "m");

  @override
  String pickAndFormat(
      BuildContext context, Measurement measurement, bool upper) =>
      AppLocalizations.of(context)
          .format(upper ? measurement.elevation : measurement.climbTotal);
}

class DistanceCellFormatter extends CellFormatter {
  const DistanceCellFormatter() : super("distance", "trip", "km", "total", "km");

  @override
  String pickAndFormat(
          BuildContext context, Measurement measurement, bool upper) =>
      AppLocalizations.of(context)
          .format(upper ? measurement.distanceTrip : measurement.distanceTotal);
}
