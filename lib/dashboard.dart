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
          flex: 3,
          child: Row(
            children: <Widget>[
              DashboardCell("Speed"),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell("Time"),
              DashboardCell("Average"),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell("Max"),
              DashboardCell("Min"),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ],
    );
  }
}
