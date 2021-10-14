import 'dart:async';
import 'dart:core';

import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/framework/data/web_mock_repository.dart';

/// A class that glues together our local file storage and web storage. It has a
/// clear responsibility: Load DataPoints and Persist DataPoints.
class Repository implements DataPointRepository {
  final DataPointRepository localStorage;
  final DataPointRepository webStorage;

  const Repository({
    required this.localStorage,
    this.webStorage = const WebMockRepository(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<DataPoint>> loadDataPoints() async {
    try {
      return await localStorage.loadDataPoints();
    } catch (e) {
      final dataPoints = await webStorage.loadDataPoints();
      await localStorage.saveDataPoints(dataPoints);

      return dataPoints;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveDataPoints(List<DataPoint> dataPoints) {
    return Future.wait<dynamic>([
      localStorage.saveDataPoints(dataPoints),
      webStorage.saveDataPoints(dataPoints),
    ]);
  }
}