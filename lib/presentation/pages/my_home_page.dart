import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/core/services/glucose_level_service_provider.dart';
import 'package:lab_coffee/presentation/pages/new_glucose_reading_page.dart';
import 'package:lab_coffee/presentation/widgets/glucose_activity_card.dart';
import 'package:lab_coffee/presentation/widgets/header_title.dart';
import 'package:lab_coffee/presentation/widgets/score_card.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final DataPointRepository repository ;
  final GlucoseLevelServiceProvider glucoseService ;

  const MyHomePage({
    Key? key,
    required this.title,
    required this.repository,
    required this.glucoseService,
  }) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  Future<Directory> getDirectory() async => await getApplicationDocumentsDirectory();
  late Future<List<DataPoint>> futureDataPoints ;

  @override
  void initState() {
    super.initState();
    futureDataPoints = widget.repository.loadDataPoints() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<DataPoint>>(
          future: futureDataPoints,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double averageGlucose = snapshot.data?.map((e) => e.value).reduce((value, element) => value + element)  ?? 0 ;
              if (snapshot.data?.isNotEmpty ?? false) {
                averageGlucose = averageGlucose / snapshot.data!.length * 18 ; //*18 converts to mg/dl
              }

              return ListView(
                children: [
                  const HeaderTitle("Today"),
                  ScoreCard(averageGlucose: "${averageGlucose.toInt()}"),
                  GlucoseActivityCard("Glucose Activity", "Avg $averageGlucose mg/dl", snapshot.data, true, 0, 24*60*60 ),
                ],
              ) ;
            } else if (snapshot.hasError) {
              return Center( child: Text('${snapshot.error}')) ;
            }

            // By default, show a loading spinner.
            return const Center(child:CircularProgressIndicator());
          },
        ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Gl +"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewGlucoseReadingPage(repository: widget.repository, glucoseService: widget.glucoseService,)),
          ).then((value) {
            // setState(() {
            // }) ;
          });
        },
      ),
    );
  }
}