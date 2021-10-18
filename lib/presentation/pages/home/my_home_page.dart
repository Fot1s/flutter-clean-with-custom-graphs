import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'my_home_page_view_model.dart';
import 'package:lab_coffee/presentation/widgets/glucose_activity_card.dart';
import 'package:lab_coffee/presentation/widgets/header_title.dart';
import 'package:lab_coffee/presentation/widgets/score_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyHomePageViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(viewModel.title),
        ),
        body: viewModel.glucoseData != null ?
          ListView(
          children: [
            const HeaderTitle("Today"),
            ScoreCard(averageGlucose: "${viewModel.averageGlucose.toInt()}"),
            GlucoseActivityCard("Glucose Activity", "Avg ${viewModel.averageGlucose} mg/dl", viewModel.glucoseData!, true, 0, 24*60*60),
          ],
        ) : const Center(child:CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
        child: const Text("Gl +"),
        onPressed: () {
          viewModel.navigateToNewGlucoseReadingPage(context).then((value) {
            viewModel.reloadGlucoseData() ;
          }) ;
        },
      ),
      ),
      viewModelBuilder: () => MyHomePageViewModel(),
    );
  }
}