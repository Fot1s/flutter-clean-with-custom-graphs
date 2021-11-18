import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/entities/data_point.dart';

class GetGlucoseLevels {
  final DataPointRepository _dataPointRepository ;

  GetGlucoseLevels(this._dataPointRepository) ;

  Future<List<DataPoint>> call() {
    return _dataPointRepository.loadDataPoints() ;
  }
}
