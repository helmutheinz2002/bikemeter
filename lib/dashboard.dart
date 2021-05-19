import 'package:bikemeter/app_localizations.dart';
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
          flex: 5,
          child: SpeedGauge(),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell(AppLocalizations.of(context).translate('speed')),
              DashboardCell(AppLocalizations.of(context).translate('distance')),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              DashboardCell(AppLocalizations.of(context).translate('elevation')),
              DashboardCell(AppLocalizations.of(context).translate('time')),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ],
    );
  }
}
