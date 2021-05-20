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
    String upperLabel = AppLocalizations.of(context).translate(_formatter.upperLabel);
    String upperUnit = AppLocalizations.of(context).translate(_formatter.upperUnit);
    String lowerLabel = AppLocalizations.of(context).translate(_formatter.lowerLabel);

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
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    upperLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    upperValue,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    upperUnit,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                lowerValue,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
            /*
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: PlatformText(
                  upperValue,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
}
