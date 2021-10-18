import 'dart:io';
import 'package:lab_coffee/core/services/glucose_level_service_provider.dart';
import 'package:lab_coffee/framework/services/mock_glucose_level_service_provider.dart';
import 'package:path_provider/path_provider.dart';

import 'package:get_it/get_it.dart';
// Important. Impore the locator.iconfig.dart file
//import 'package:lab_coffee/presentation/app/service_locator.config.dart';

import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/framework/data/file_based_data_point_repository.dart';
import 'package:lab_coffee/framework/data/repository.dart';
import 'package:lab_coffee/framework/data/web_mock_repository.dart';

Future<Directory> getDirectory() async => await getApplicationDocumentsDirectory();

final serviceLocator = GetIt.instance;

//@injectableInit
//void setupExternalServicesLocator() => $initGetIt(serviceLocator);

void setupServiceLocator() {
  serviceLocator.registerSingleton<DataPointRepository>(const Repository(localStorage: FileBasedDataPointRepository("TAG",getDirectory),webStorage: WebMockRepository())) ;
  serviceLocator.registerSingleton<GlucoseLevelServiceProvider>(MockGlucoseLevelServiceProvider()) ;
//  setupExternalServicesLocator() ;
}
