import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: DataCell('Speed'),

//          color: Colors.teal[100],
        ),
        Container(
          child: const Text('Heed not the rabble'),
        ),
        Container(
          child: const Text('Sound of screams but the'),
        ),
        Container(
          child: const Text('Who scream'),
        ),
        Container(
          child: const Text('Revolution is coming...'),
        ),
        Container(
          child: const Text('Revolution, they...'),
        ),
      ],
    );
  }
}

class DataCell extends StatefulWidget {
  String _title;

  DataCell(String this._title);

  @override
  State<StatefulWidget> createState() {
    return DataCellState();
  }
}

class DataCellState extends State<DataCell> {
  @override
  Widget build(BuildContext context) {
    return Text(widget._title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),);
  }
}
