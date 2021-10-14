import 'package:flutter/material.dart';
import 'package:lab_coffee/presentation/theme/constants.dart';

class ScoreCard extends StatelessWidget {
  final String averageGlucose ;

  const ScoreCard({required this.averageGlucose, Key? key}) : super(key: key);

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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score",
                    style: Theme.of(context).textTheme.headline4,),
                  Padding(
                    padding: EdgeInsets.only(right: Constants.defaultPadding.right),
                    child: Text(
                      "67",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: Constants.doublePadding.top),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoColumn(context, "87", "bpm", "Heart rate"),
                    _buildInfoColumn(context, averageGlucose, "mg/dl", "Glucose"),
                    _buildInfoColumn(context, "345", "cal", "Food"),
                    _buildInfoColumn(context, "67", "%", "Mood"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildInfoColumn(BuildContext context, String value, String identifier, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(width: Constants.halfPadding.left,),
          Text(
            identifier,
            style: Theme.of(context).textTheme.headline4,
          )
        ],),
        SizedBox(height: Constants.halfPadding.top,),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }
}
