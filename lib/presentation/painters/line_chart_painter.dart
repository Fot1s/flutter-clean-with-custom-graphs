import 'dart:ui';

import 'package:flutter/material.dart';

class ChartPoint {
  dynamic x;

  num y;

  ChartPoint(this.x, this.y);

  @override
  String toString() {
    return "ChartPoint{x:$x,y:$y}";
  }
}

class LineChartPainter extends CustomPainter {
  final double _padding;
  final List<ChartPoint> _chartPoints;

  final int _startSecond ;
  final int _endSecond ;

  final double? padMaxValueBy; //todo:implement
  final double? padMinValueBy; //todo:implement
  final MaterialColor? graphBgColor ;

  const LineChartPainter({
      required int startSecond,
      required int endSecond,
      required List<ChartPoint> chartPoints,
      required double padding,
      this.graphBgColor,
      this.padMaxValueBy,
      this.padMinValueBy})
      : _startSecond = startSecond,
        _endSecond = endSecond,
        _padding = padding,
        _chartPoints = chartPoints;

  @override
  void paint(Canvas canvas, Size size) {
    const footerPoints = 23 ;
    const strokeWidth = 3.0 ;
    const roundCapFix = strokeWidth/2 ;
    final footerPointEveryXPixels = (size.width - _padding * 2 - strokeWidth)/(footerPoints-1) ;
    List<Offset> _normalizedPoints = [];
    List<Offset> _footerPoints = [] ;

    //normalize points to draw
    //difference between points in normalized screen space, pixels
    // double xNormalStep =
    //     (size.width - _padding * 2 - strokeWidth) / (_chartPoints.length - 1);

    num valueMinY = 0 ;
    num valueMaxY = 1 ;
    if (_chartPoints.isNotEmpty) { //reduce needs one element min
      valueMinY = _chartPoints
          .reduce((current, next) => current.y <= next.y ? current : next)
          .y;

      valueMaxY = _chartPoints
          .reduce((current, next) => current.y >= next.y ? current : next)
          .y;
    }

    if (padMaxValueBy != null) {
      valueMaxY += padMaxValueBy! ;
    }

    if (padMinValueBy != null) {
      valueMinY -= padMinValueBy! ;
    }

    num valuesRange = valueMaxY - valueMinY ;
    if (valuesRange <=0) { //flat line to 0 by setting range to 1 if y range is 0
      valuesRange = 1 ;
    }

    num xValuesRange = _endSecond - _startSecond ;

    //This fills the chart from left to right drawing all points
    // for (var i = 0; i < _chartPoints.length; i++) {
    //   double yValue = (size.height - _padding * 2 - strokeWidth) *
    //       (1 - (_chartPoints.elementAt(i).y - valueMinY) / valuesRange) ;
    //   _normalizedPoints.add(Offset(_padding + roundCapFix + i * xNormalStep, _padding + roundCapFix + yValue));
    // }

    double lastX = 0 ;
    //normalize incoming points depending on their minute in day vs min + max minutes
    for (var i = 0; i < _chartPoints.length; i++) {
      double yValue = (size.height - _padding * 2 - strokeWidth) *
          (1 - (_chartPoints.elementAt(i).y - valueMinY) / valuesRange) ;
      double xValue =  (size.width - _padding * 2 - strokeWidth) *
          (_chartPoints.elementAt(i).x - _startSecond) / xValuesRange ;
      if (xValue > lastX) { //quick fix to not draw points out of sequence - will not happen with correct timestamps in current locale
        _normalizedPoints.add(Offset(_padding + roundCapFix + xValue, _padding + roundCapFix + yValue));
        lastX = xValue ;
      }
    }


    //create footer points
    for (var i = 0; i < footerPoints; i ++) {
      _footerPoints.add(Offset(_padding + roundCapFix + i*footerPointEveryXPixels, size.height - _padding - roundCapFix));
    }

    //draw background rect if color is provided
    if (graphBgColor != null) {
      var bgRect = Offset(_padding, _padding) &
      Size(size.width - 2 * _padding, size.height - 2 * _padding);
      var bgPaint = Paint()
        ..color = graphBgColor!
        ..style = PaintingStyle.fill;

      canvas.drawRect(bgRect, bgPaint);
    }

    //draw normalized points as a Line / Path
    if (_normalizedPoints.length > 1) {
      var linePaint = Paint()
        ..color = Colors.teal
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeMiterLimit = 3;

      var path = Path();
      path.moveTo(_normalizedPoints.elementAt(0).dx, _normalizedPoints.elementAt(0).dy);

      for (var i = 1; i < _normalizedPoints.length; i++) {
        path.lineTo(_normalizedPoints.elementAt(i).dx, _normalizedPoints.elementAt(i).dy);
      }

      canvas.drawPath(path, linePaint);

      //New design uses solid line keep stroke in comment
      // Path dashPath = Path();
      //
      // double dashWidth = 10.0;
      // double dashSpace = 10.0;
      // double distance = 0.0;
      //
      // for (PathMetric pathMetric in path.computeMetrics()) {
      //   while (distance < pathMetric.length) {
      //     var newPath = pathMetric.extractPath(distance, distance + dashWidth);
      //     dashPath.addPath(
      //       newPath,
      //       Offset.zero,
      //     );
      //     distance += dashWidth;
      //     distance += dashSpace;
      //   }
      // }
      // canvas.drawPath(dashPath, linePaint);
    }
    //draw footer dots
    var pointPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeMiterLimit = strokeWidth;

    canvas.drawPoints(PointMode.points, _footerPoints, pointPaint) ;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
