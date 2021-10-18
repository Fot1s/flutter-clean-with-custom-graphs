import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';

/// Loads and saves a List of DataPoints using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileBasedDataPointRepository implements DataPointRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileBasedDataPointRepository(
      this.tag,
      this.getDirectory,
      );

  @override
  Future<List<DataPoint>> loadDataPoints() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = const JsonDecoder().convert(string);
    final dataPoints = (json['dataPoints'])
        .map<DataPoint>((dataPoint) => DataPoint.fromJson(dataPoint))
        .toList();
    return dataPoints;
  }

  @override
  Future<File> saveDataPoints(List<DataPoint> dataPoints) async {
    final file = await _getLocalFile();

    return file.writeAsString(const JsonEncoder().convert({
      'dataPoints': dataPoints.map((dataPoint) => dataPoint.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/PointsStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}