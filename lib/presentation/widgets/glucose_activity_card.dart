import 'package:flutter/material.dart';
import 'package:lab_coffee/core/domain/entities/data_point.dart';
import 'package:lab_coffee/presentation/theme/constants.dart';

import 'charts/line_chart.dart';

class GlucoseActivityCard extends StatelessWidget {
  final List<DataPoint>? glucoseLevelsDataPoints ;
  final String title ;
  final String subTitle ;
  final bool showFooter ;
  final int startSecond ;
  final int endSecond ;

  const GlucoseActivityCard(
      this.title,
      this.subTitle,
      this.glucoseLevelsDataPoints,
      this.showFooter,
      this.startSecond,
      this.endSecond,
      {
        Key? key
      }
  ) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.defaultPadding,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
        ),
        color: Colors.grey.shade200,
        child: Padding(
          padding: Constants.defaultPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,),
                  SizedBox(height: Constants.halfPadding.top),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
              SizedBox(height: Constants.defaultPadding.top),
              LineChart(startSecond: startSecond, endSecond: endSecond, dataPoints: glucoseLevelsDataPoints, padding: 0, height: 150,),
              SizedBox(height: Constants.defaultPadding.top),
              _buildFooter(context, showFooter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool showFooter) {
    return showFooter ?
      Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "00:00",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            "08:00",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            "16:00",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            "24:00",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      )
      : Container() ;
  }

}
