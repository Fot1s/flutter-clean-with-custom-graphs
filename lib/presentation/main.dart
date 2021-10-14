import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/services/glucose_level_service_provider.dart';
import 'package:lab_coffee/framework/data/file_based_data_point_repository.dart';
import 'package:lab_coffee/framework/data/repository.dart';
import 'package:lab_coffee/framework/services/mock_glucose_level_service_provider.dart';
import 'package:lab_coffee/presentation/theme/theme_data.dart';
import 'package:path_provider/path_provider.dart';

import 'pages/my_home_page.dart';

void main() {
  Future<Directory> getDirectory() async => await getApplicationDocumentsDirectory();

  runApp(
      MyApp(repository: Repository(localStorage: FileStorage("tag-points",getDirectory)),
        glucoseService: MockGlucoseLevelServiceProvider(),)
  );
}

class MyApp extends StatelessWidget {
  final DataPointRepository repository ;
  final GlucoseLevelServiceProvider glucoseService ;

  const MyApp({
    Key? key,
    required this.repository,
    required this.glucoseService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Custom Graphs',
      theme: MyTheme.mainTheme,
      home: MyHomePage(
        repository: repository,
        glucoseService: glucoseService,
        title: 'Clean Custom Graphs',
      ),
    );
  }
}


