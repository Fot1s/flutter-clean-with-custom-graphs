import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lab_coffee/core/data/data_point_data_source.dart';
import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/entities/data_point.dart';

/// Loads and saves a List of DataPoints using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileBasedDataPointDataSource implements DataPointDataSource {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileBasedDataPointDataSource(
      this.tag,
      this.getDirectory,
      );

  @override
  Future<List<DataPoint>> load() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = const JsonDecoder().convert(string);
    final dataPoints = (json['dataPoints'])
        .map<DataPoint>((dataPoint) => DataPoint.fromJson(dataPoint))
        .toList();
    return dataPoints;
  }

  @override
  Future<File> save(List<DataPoint> dataPoints) async {
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