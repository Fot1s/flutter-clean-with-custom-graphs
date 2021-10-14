import 'dart:async';

import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting DataPoints to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebMockRepository implements DataPointRepository {
  final Duration delay;

  const WebMockRepository({this.delay = const Duration(milliseconds: 3000)});

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  /// The blood glucose concentration is measured in mmol/L (1 mmol/L is equivalent to 18 mg/dL)
  @override
  Future<List<DataPoint>> loadDataPoints() async {
    return Future.delayed(
        delay,
            () => [
          DataPoint(
            '0',
              1634169601000,
            5
          ),
          DataPoint(
            '1',
              1634173201000,
            5.1
          ),
          DataPoint(
            '2',
              1634175001000,
            5.2
          ),
          DataPoint(
            '3',
              1634175901000,
            5.3
          ),
          DataPoint(
            '4',
              1634176801000,
            5.4
          ),
          DataPoint(
            '5',
              1634180401000,
            5.4
          ),
          DataPoint(
            '6',
              1634184001000,
            5.2
          ),
          DataPoint(
            '7',
              1634227201000,
            4.9
          ),

        ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveDataPoints(List<DataPoint> dataPoints) async {
    return Future.value(true);
  }
}