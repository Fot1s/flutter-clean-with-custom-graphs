import 'dart:math';

import 'package:lab_coffee/core/domain/entities/data_point.dart';
import 'package:lab_coffee/core/services/glucose_level_service_provider.dart';

class MockGlucoseLevelServiceProvider implements GlucoseLevelServiceProvider {
  var isRunning = false ;

  @override
  Stream<DataPoint> startReading(int everyMillis, int countTimes) async* {
    isRunning = true ;
    var pointAt = 0 ;
    Random random = Random() ;

    while (countTimes > 0 && isRunning) {
      pointAt++ ;
      await Future<void>.delayed(Duration(milliseconds: everyMillis));
      yield DataPoint("$pointAt", DateTime.now().millisecondsSinceEpoch, 5 + random.nextDouble());
      countTimes-- ;
    }
  }

  @override
  void stopReading() {
    isRunning = false ;
  }
}