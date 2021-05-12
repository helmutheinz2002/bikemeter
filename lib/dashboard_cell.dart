import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DashboardCell extends StatefulWidget {
  String _title;

  DashboardCell(String this._title);

  @override
  State<StatefulWidget> createState() {
    return DashboardCellState();
  }
}

class DashboardCellState extends State<DashboardCell> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Text(
          widget._title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
