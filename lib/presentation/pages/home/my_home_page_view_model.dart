import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lab_coffee/core/data/data_point_repository.dart';
import 'package:lab_coffee/core/domain/data_point.dart';
import 'package:lab_coffee/presentation/app/service_locator.dart';
import 'package:lab_coffee/presentation/app/router.gr.dart';
import 'package:stacked/stacked.dart';

class MyHomePageViewModel extends BaseViewModel {
  final String _title = 'Home View';
  final DataPointRepository _repository = serviceLocator<DataPointRepository>() ;

  String get title => _title;
  double averageGlucose =0 ;
  List<DataPoint>? glucoseData ;

  void initialise() async {
    glucoseData = await _loadGlucoseData() ;
    notifyListeners() ;
  }

  void reloadGlucoseData() async {
    glucoseData = null ;
    notifyListeners() ;
    glucoseData = await _loadGlucoseData() ;
    notifyListeners() ;
  }

  Future<List<DataPoint>>? _loadGlucoseData()  {
    return _repository.loadDataPoints() ;
  }

  Future navigateToNewGlucoseReadingPage(BuildContext context) async {
    return AutoRouter.of(context).push(const NewGlucoseReading()) ;
  }
}