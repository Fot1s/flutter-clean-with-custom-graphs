import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/core/services/glucose_level_service_provider.dart';
import 'package:lab_coffee/presentation/widgets/glucose_activity_card.dart';

class NewGlucoseReadingPage extends StatefulWidget {
  final DataPointRepository repository ;
  final GlucoseLevelServiceProvider glucoseService ;

  const NewGlucoseReadingPage({
        required this.repository,
        required this.glucoseService,
        Key? key
      }) : super(key: key);

  @override
  _NewGlucoseReadingPageState createState() => _NewGlucoseReadingPageState();
}

class _NewGlucoseReadingPageState extends State<NewGlucoseReadingPage> {
  double averageReading = 0 ;
  List<DataPoint> readDataPoints = [] ;
  late final Stream<DataPoint> dataPointsStream ;
  late int startTime ;
  late int endTime ;

  @override
  void initState() {
    super.initState();
    dataPointsStream = widget.glucoseService.startReading(500, 120) ;
    var now = DateTime.now() ;
    startTime = now.hour*60*60 + now.minute*60 + now.second ;
    endTime = startTime + 60 ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Glucose Reading"),
        ),
        body: StreamBuilder<DataPoint>(
          stream: dataPointsStream,
          builder: (BuildContext context, AsyncSnapshot<DataPoint> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              readDataPoints.add(snapshot.data!) ;
              averageReading = readDataPoints.map((e) => e.value).reduce((value, element) => value + element) / readDataPoints.length * 18 ;
            }
            return GlucoseActivityCard("Reading Glucose Levels", "Avg ${averageReading.toStringAsFixed(2)} mg/dl", readDataPoints, false, startTime, endTime) ;
          },
        ) ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          widget.glucoseService.stopReading() ;

          //TODO: Add DateSets of DataPoints and implement multiple readings before saving here :)
          //widget.repository.saveDataPoints(readDataPoints) ;
        },
        child: const Icon(Icons.stop),
      ),
    );
  }
}
