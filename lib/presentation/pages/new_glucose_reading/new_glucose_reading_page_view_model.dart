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

  String get title => _title;

  double averageReading = 0 ;
  int startTime = DateTime.now().millisecondsSinceEpoch ;
  int endTime = DateTime.now().millisecondsSinceEpoch ;

  final List<DataPoint> _glucoseData = [] ;

  StreamController<List<DataPoint>> dataPointStreamController = StreamController.broadcast();

  startReadingGlucoseLevels() {
      startTime = DateTime.now() .millisecondsSinceEpoch ;
      endTime = startTime + const Duration(seconds: 60).inMilliseconds ;
      _glucoseData.clear() ;
      //4 times per sec for 60 sec
      _provider.startReading(250, 240).forEach((element) async {
        _glucoseData.add(element) ;

        if (_glucoseData.length ==1) {
          averageReading = _glucoseData[0].value ;
        } else {
          averageReading = _glucoseData.map((e) => e.value).reduce((value, element) => value + element) / _glucoseData.length * 18 ;
        }

        dataPointStreamController.add(_glucoseData) ;
        //notifyListeners does not work inside foreach / async switch to StreamViewModel
      }) ;
  }

  stopReadingGlucoseLevels() {
    _provider.stopReading() ;
    _repository.saveDataPoints(_glucoseData) ;
  }

  @override
  Stream<List<DataPoint>> get stream => dataPointStreamController.stream ;
}