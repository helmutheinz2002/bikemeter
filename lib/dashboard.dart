import 'package:bikemeter/speed_gauge.dart';
import 'package:flutter/material.dart';
import "dashboard_cell.dart";

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Row(
            children: <Widget>[
              SpeedGauge(),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell("Max", "56.4"),
              DashboardCell("Average", "37.5"),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell("Total Time", "1:25:58"),
              DashboardCell("Moving Time", "0:56:51"),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ],
    );
  }
}
