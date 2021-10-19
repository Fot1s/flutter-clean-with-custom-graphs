import 'dart:async';

import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/core/services/glucose_level_service_provider.dart';
import 'package:lab_coffee/presentation/app/service_locator.dart';
import 'package:stacked/stacked.dart';

class NewGlucoseReadingPageViewModel extends StreamViewModel {
  final String _title = 'New Glucose Reading';

  final GlucoseLevelServiceProvider _provider = serviceLocator<GlucoseLevelServiceProvider>() ;
  final DataPointRepository _repository = serviceLocator<DataPointRepository>() ;

  final List<DataPoint> _glucoseData = [] ;
  final StreamController<List<DataPoint>> _dataPointStreamController = StreamController();

  List<DataPoint> get glucoseData => _glucoseData;

  String get title => _title;
  int startTime = 0 ;
  int endTime = 0 ;

  double get averageReading {
    var glucose = _glucoseData.isEmpty
      ? 0
      : _glucoseData.length == 1
        ? _glucoseData.first.value
        : _glucoseData.map((e) => e.value).reduce((value, element) => value + element) / _glucoseData.length ;
    return glucose * 18 ;//convert to mg/dl
  }

  startReadingGlucoseLevels() {
    var now = DateTime.now() ;
      startTime = now.hour*60*60 + now.minute*60 + now.second ;
      endTime = startTime + 60 ;
      _glucoseData.clear() ;
      //4 times per sec for 60 sec
      _provider.startReading(250, 240).forEach((element) async {
        _glucoseData.add(element) ;
        _dataPointStreamController.add(_glucoseData) ;
      }) ;
  }

  stopReadingGlucoseLevels() {
    _provider.stopReading() ;
    _repository.saveDataPoints(_glucoseData) ;
  }

  @override
  Stream<List<DataPoint>> get stream => _dataPointStreamController.stream ;

  @override
  void dispose() {
    _dataPointStreamController.close() ;
    super.dispose();
  }
}