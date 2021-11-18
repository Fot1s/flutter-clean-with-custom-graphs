import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lab_coffee/core/domain/entities/data_point.dart';
import 'package:lab_coffee/core/domain/interactors/get_glucose_levels.dart';
import 'package:lab_coffee/service_locator.dart';
import 'package:lab_coffee/presentation/app/router.gr.dart';
import 'package:stacked/stacked.dart';

class MyHomePageViewModel extends BaseViewModel {
  final String _title = 'Home View';
//  final DataPointRepository _repository = serviceLocator<DataPointRepository>() ;
  final GetGlucoseLevels _getGlucoseLevels = serviceLocator<GetGlucoseLevels>() ;

  final List<DataPoint> glucoseData = [];

  String get title => _title;

  double get averageGlucose {
    var glucose = glucoseData.isEmpty
      ? 0
      : glucoseData.length == 1
        ? glucoseData.first.value
        : glucoseData.map((e) => e.value).reduce((value, element) => value + element) / glucoseData.length ;
    return glucose * 18 ;//convert to mg/dl
  }

  void initialise() {
    _loadGlucoseData().then((value) {
      glucoseData.addAll(value) ;
      notifyListeners() ;
    }) ;
  }

  void reloadGlucoseData() {
    glucoseData.clear() ;
    notifyListeners() ;

    _loadGlucoseData().then((value) {
      glucoseData.addAll(value) ;
      notifyListeners() ;
    }) ;
  }

  Future<List<DataPoint>> _loadGlucoseData()  {
    return _getGlucoseLevels() ;
  }

  Future navigateToNewGlucoseReadingPage(BuildContext context) {
    return AutoRouter.of(context).push(const NewGlucoseReadingRoute()) ;
  }
}