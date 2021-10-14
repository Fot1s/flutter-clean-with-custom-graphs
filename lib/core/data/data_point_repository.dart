import 'package:lab_coffee/core/domain/data_point.dart';

abstract class DataPointRepository {
  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<DataPoint>> loadDataPoints() ;

  /// Persists dataPoints to local disk and the web
  Future saveDataPoints(List<DataPoint> dataPoints);
}