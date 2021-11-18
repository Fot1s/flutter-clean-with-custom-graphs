import 'package:lab_coffee/core/domain/entities/data_point.dart';

abstract class DataPointDataSource {

  Future<List<DataPoint>> load() ;

  Future save(List<DataPoint> dataPoints);
}