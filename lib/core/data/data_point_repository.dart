import 'package:lab_coffee/core/data/data_point_data_source.dart';
import 'package:lab_coffee/core/domain/entities/data_point.dart';

class DataPointRepository {

  final DataPointDataSource _localStorage ;
  final DataPointDataSource _webStorage;

  const DataPointRepository({
     localStorage,
     webStorage,
  }): _localStorage = localStorage, _webStorage = webStorage ;

  /// Loads Data Points first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Points from a Web Client.
  Future<List<DataPoint>> loadDataPoints() async {
    try {
      return await _localStorage.load();
    } catch (e) {
      final dataPoints = await _webStorage.load();
      await _localStorage.save(dataPoints);

      return dataPoints;
    }
  }

  /// Persists dataPoints to local disk and the web
  Future saveDataPoints(List<DataPoint> dataPoints) {
    return Future.wait<dynamic>([
      _localStorage.save(dataPoints),
      _webStorage.save(dataPoints),
    ]);
  }
}