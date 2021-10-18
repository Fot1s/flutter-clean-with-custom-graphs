import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/presentation/pages/new_glucose_reading/new_glucose_reading_page_view_model.dart';
import 'package:lab_coffee/presentation/widgets/glucose_activity_card.dart';
import 'package:stacked/stacked.dart';

class NewGlucoseReadingPage extends StatelessWidget {
  const NewGlucoseReadingPage({
        Key? key
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewGlucoseReadingPageViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.startReadingGlucoseLevels(),
      builder: (context, viewModel, child) =>
      Scaffold(
        appBar: AppBar(
          title: Text(viewModel.title),
        ),
        body:
        StreamBuilder<List<DataPoint>>(
          stream: viewModel.stream,
          builder: (BuildContext context, AsyncSnapshot<List<DataPoint>> snapshot) {
            return snapshot.data?.isNotEmpty == true ?
              GlucoseActivityCard(viewModel.title, "Avg ${viewModel.averageReading.toStringAsFixed(2)} mg/dl", snapshot.data, false, viewModel.startTime, viewModel.endTime)
              :
              const Center(child:CircularProgressIndicator()) ;
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Icon(Icons.stop),
          onPressed: () {
            viewModel.stopReadingGlucoseLevels() ;
          },
        ),
      ),
      viewModelBuilder: () => NewGlucoseReadingPageViewModel(),
    );
  }
}
//
// class _NewGlucoseReadingPageState extends State<NewGlucoseReadingPage> {
//   double averageReading = 0 ;
//   List<DataPoint> readDataPoints = [] ;
//   late final Stream<DataPoint> dataPointsStream ;
//   late int startTime ;
//   late int endTime ;
//
//   @override
//   void initState() {
//     super.initState();
//     var now = DateTime.now() ;
//     startTime = now.hour*60*60 + now.minute*60 + now.second ;
//     endTime = startTime + 60 ;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("New Glucose Reading"),
//         ),
//         body: StreamBuilder<DataPoint>(
//           stream: dataPointsStream,
//           builder: (BuildContext context, AsyncSnapshot<DataPoint> snapshot) {
//             if (snapshot.hasData && snapshot.data != null) {
//               readDataPoints.add(snapshot.data!) ;
//               averageReading = readDataPoints.map((e) => e.value).reduce((value, element) => value + element) / readDataPoints.length * 18 ;
//             }
//             return GlucoseActivityCard("Reading Glucose Levels", "Avg ${averageReading.toStringAsFixed(2)} mg/dl", readDataPoints, false, startTime, endTime) ;
//           },
//         ) ,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.red,
//         onPressed: () {
// //          widget.glucoseService.stopReading() ;
//
//           //TODO: Add DateSets of DataPoints and implement multiple readings before saving here :)
//           //widget.repository.saveDataPoints(readDataPoints) ;
//         },
//         child: const Icon(Icons.stop),
//       ),
//     );
//   }
// }
