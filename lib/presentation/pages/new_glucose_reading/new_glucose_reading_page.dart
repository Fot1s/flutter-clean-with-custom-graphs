import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        body:GlucoseActivityCard(viewModel.title, "Avg ${viewModel.averageReading.toStringAsFixed(2)} mg/dl", viewModel.glucoseData, false, viewModel.startTime, viewModel.endTime),
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
