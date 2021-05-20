import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'cell_formatter.dart';
import 'measure_controller.dart';

class DashboardCell extends StatefulWidget {
  final CellFormatter _cellFormatter;

  const DashboardCell(this._cellFormatter);

  @override
  _DashboardCellState createState() => _DashboardCellState(_cellFormatter);
}

class _DashboardCellState extends State<DashboardCell> {
  final CellFormatter _formatter;
  Measurement _measurement;

  _DashboardCellState(this._formatter);

  @override
  void initState() {
    super.initState();
    MeasureController.singleton().measureStream.listen((measurement) {
      setState(() {
        _measurement = measurement;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String upperValue = _measurement == null
        ? '-'
        : _formatter.pickAndFormat(context, _measurement, true);
    String lowerValue = _measurement == null
        ? '-'
        : _formatter.pickAndFormat(context, _measurement, false);

    String title = AppLocalizations.of(context).translate(_formatter.title);
    String upperLabel =
        AppLocalizations.of(context).translate(_formatter.upperLabel);
    String lowerLabel =
        AppLocalizations.of(context).translate(_formatter.lowerLabel);
    String unit =
        AppLocalizations.of(context).translate(_formatter.unit);

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
                '$title',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            getRow(upperLabel, upperValue, unit),
            getRow(lowerLabel, lowerValue, unit),
          ],
        ),
      ),
    );
  }

  Widget getRow(String label, value, unit) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
          ),
          Expanded(
            child: Text(
              unit,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
