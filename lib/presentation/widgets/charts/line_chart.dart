import 'package:flutter/material.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/presentation/painters/line_chart_painter.dart';

class LineChart extends StatelessWidget {
  final double height ;
  final double padding;
  final List<DataPoint>? dataPoints ;
  final MaterialColor? graphBgColor ;
  final int startSecond ;
  final int endSecond ;

  const LineChart({
    Key? key,
    required this.height,
    required this.dataPoints,
    required this.startSecond,
    required this.endSecond,
    this.graphBgColor,
    this.padding = 10,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    List<ChartPoint> points= dataPoints?.mapIndexed((element, index) => ChartPoint("$index", element.value)).toList(growable: false) ?? [] ;

  //convert date to minutes inside the day
    List<ChartPoint> points= dataPoints?.map(
      (element) => ChartPoint(DateTime.fromMillisecondsSinceEpoch(element.millisSinceEpoch).hour*60*60 +
                              DateTime.fromMillisecondsSinceEpoch(element.millisSinceEpoch).minute*60 +
                              DateTime.fromMillisecondsSinceEpoch(element.millisSinceEpoch).second
          , element.value)).toList(growable: false) ?? [] ;

    return CustomPaint(
      //incoming data are in padMinValueBy mmol/l so padding by 1 should be enough
      painter: LineChartPainter(startSecond:startSecond, endSecond: endSecond, padding: padding, graphBgColor: graphBgColor, chartPoints: points, padMaxValueBy: 1, padMinValueBy: 1),
      child: Container(height: height,),
    );
  }
}
