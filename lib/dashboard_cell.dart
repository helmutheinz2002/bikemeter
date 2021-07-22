import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'cell_formatter.dart';
import 'measure_controller.dart';
import 'package:google_fonts/google_fonts.dart';

enum BorderSideName { Left, Top, Right, Bottom }

class DashboardCell extends StatefulWidget {
  final CellFormatter _cellFormatter;
  final List<BorderSideName> _sides;

  const DashboardCell(this._cellFormatter, this._sides);

  @override
  _DashboardCellState createState() =>
      _DashboardCellState(_cellFormatter, _sides);
}

class _DashboardCellState extends State<DashboardCell> {
  final double titleFontSize = 15;

  final CellFormatter _formatter;
  final List<BorderSideName> _sides;
  Measurement _measurement;

  _DashboardCellState(this._formatter, this._sides);

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
    String unit = AppLocalizations.of(context).translate(_formatter.unit);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: _sides.contains(BorderSideName.Top) ? 1 : 0),
            left:
                BorderSide(width: _sides.contains(BorderSideName.Left) ? 1 : 0),
            bottom: BorderSide(
                width: _sides.contains(BorderSideName.Bottom) ? 1 : 0),
            right: BorderSide(
                width: _sides.contains(BorderSideName.Right) ? 1 : 0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  children: [
                    Icon(_formatter.icon, size: titleFontSize),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: titleFontSize),
                          ),
                        ),
                        Text(
                          unit,
                          style: TextStyle(fontSize: titleFontSize * 0.6),
                        ),
                      ],
                    ),
                  ],
                )),
            getRow(upperLabel, upperValue, unit),
            getRow(lowerLabel, lowerValue, unit),
          ],
        ),
      ),
    );
  }

  Widget getRow(String label, value, unit) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
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
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 28),
              //GoogleFonts.courierPrime(fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }
}
