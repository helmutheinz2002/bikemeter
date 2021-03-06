import 'package:bikemeter/app_localizations.dart';
import 'package:bikemeter/measure_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedGauge extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpeedGaugeState();
}

class _SpeedGaugeState extends State<SpeedGauge> {
  Measurement _measurement;

  @override
  void initState() {
    super.initState();
    MeasureController.singleton().measureStream.listen((measurement) {
      if(mounted) {
        setState(() {
          _measurement = measurement;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double value = _measurement==null?0:_measurement.speed*20.0;
    double minRange = value-10.0;
    double maxRange = value+10.0;
    String speed = AppLocalizations.of(context).format(value);

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            startAngle: 130,
            endAngle: 50,
            minimum: 0,
            maximum: 60,
            interval: 10,
            minorTicksPerInterval: 9,
            showAxisLine: false,
            radiusFactor: 0.8,
            labelOffset: 8,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: minRange,
                  endValue: maxRange,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(123, 0, 0, 0.3)),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0.35,
                widget: Container(
                  child: const Text(
                    'km/h',
                    style: TextStyle(color: Color(0xFF303030), fontSize: 16),
                  ),
                ),
              ),
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 1,
                  widget: Container(
                    child: Text(
                      '$speed',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ))
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: value,
                needleLength: 0.6,
                lengthUnit: GaugeSizeUnit.factor,
                needleStartWidth: 1,
                needleEndWidth: 8,
                //animationType: AnimationType.easeOutBack,
                //enableAnimation: true,
                //animationDuration: 1200,
                knobStyle: KnobStyle(
                    knobRadius: 0.09,
                    sizeUnit: GaugeSizeUnit.factor,
                    borderColor: const Color(0xFF303030),
                    //color: Colors.white,
                    borderWidth: 0.05),
                /*
                tailStyle: TailStyle(
                    color: Colors.black45,//const Color(0xFFF8B195),
                    width: isCardView ? 4 : 8,
                    lengthUnit: GaugeSizeUnit.factor,
                    length: isCardView ? 0.15 : 0.2),

                 */
                needleColor: Colors.black45,//const Color(0xFFF8B195),
              )
            ],
            axisLabelStyle: GaugeTextStyle(fontSize: 12),
            majorTickStyle: MajorTickStyle(
                length: 0.25, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
            minorTickStyle: MinorTickStyle(
                length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
      ],
    );
  }
}
