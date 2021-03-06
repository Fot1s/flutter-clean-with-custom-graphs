import 'package:lab_coffee/core/domain/entities/data_point.dart';

abstract class GlucoseLevelServiceProvider {
  Stream<DataPoint> startReading(int everyMillis, int countTimes) ;
  void stopReading() ;
}