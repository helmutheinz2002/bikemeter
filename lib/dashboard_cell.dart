import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'measure_controller.dart';

class DashboardCell extends StatefulWidget {
  final String _title;

  DashboardCell(this._title);

  @override
  _DashboardCellState createState() => _DashboardCellState(_title, 'km/h');
}

class _DashboardCellState extends State<DashboardCell> {
  final String _title;
  final String _unit;

  _DashboardCellState(this._title, this._unit);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
        child: StreamBuilder(
            initialData: Measurement(),
            stream: MeasureController.singleton().measureStream,
            builder:
                (BuildContext context, AsyncSnapshot<Measurement> snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '$_title $_unit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      AppLocalizations.of(context).format(snapshot.data.speed),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      AppLocalizations.of(context).format(snapshot.data.timeMoving),
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
              );
            }),
      ),
    );
  }
}
