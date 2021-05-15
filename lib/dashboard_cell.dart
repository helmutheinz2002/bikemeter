import 'package:flutter/material.dart';

class DashboardCell extends StatefulWidget {
  final String _title;
  final String _initialValue;

  DashboardCell(this._title, this._initialValue);

  @override
  _DashboardCellState createState() =>
      _DashboardCellState(_title, _initialValue);
}

class _DashboardCellState extends State<DashboardCell> {
  String _value = '';
  final String _title;

  _DashboardCellState(this._title, this._value);

  void setValue(String value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                _title,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: Text(
                  _value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
