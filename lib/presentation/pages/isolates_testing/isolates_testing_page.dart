import 'package:flutter/material.dart';
import 'package:lab_coffee/presentation/pages/isolates_testing/isolates_testing_page_view_model.dart';
import 'package:stacked/stacked.dart';

class IsolatesTestingPage extends StatelessWidget {
  const IsolatesTestingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IsolatesTestingPageViewModel>.reactive(
      builder: (context, viewModel, child) =>
          Scaffold(
            appBar: AppBar(
              title: Text(viewModel.title),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    viewModel.isRunning ? const CircularProgressIndicator():Container(),
                    MaterialButton(onPressed: () => viewModel.toggleTesting(),
                    child: Text(viewModel.startStopTitle),)
                  ],
                )
              ],
            ),
          ),
      viewModelBuilder: () => IsolatesTestingPageViewModel(),
    );
  }}
