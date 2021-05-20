import 'package:bikemeter/app_localizations.dart';
import 'package:bikemeter/cell_formatter.dart';
import 'package:bikemeter/speed_gauge.dart';
import 'package:flutter/material.dart';
import "dashboard_cell.dart";

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: SpeedGauge(),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell(CellFormatters.speedCellFormatter),
              DashboardCell(CellFormatters.distanceCellFormatter),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell(CellFormatters.elevationCellFormatter),
              DashboardCell(CellFormatters.timeCellFormatter),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ],
    );
  }
}
