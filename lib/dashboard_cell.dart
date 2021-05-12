import 'package:flutter/material.dart';

class DashboardCell extends StatelessWidget {
  final String _title;

  DashboardCell(String this._title);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            //color: Colors.red,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                /*
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
                 */
                child: Text(
                  '100',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(
              'km/h',
              textAlign: TextAlign.center,
              //style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
