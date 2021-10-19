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

  final List<DataPoint> glucoseData = [];

  String get title => _title;

  double get averageGlucose {
    var glucose = glucoseData.length == 1
          ? glucoseData.first.value
          : glucoseData.map((e) => e.value).reduce((value, element) => value + element) / glucoseData.length ;
    return glucose * 18 ;//convert to mg/dl
  }

  void initialise() async {
    _loadGlucoseData().then((value) {
      glucoseData.addAll(value) ;
      notifyListeners() ;
    }) ;
  }

  void reloadGlucoseData() async {
    glucoseData.clear() ;
    notifyListeners() ;

    _loadGlucoseData().then((value) {
      glucoseData.addAll(value) ;
      notifyListeners() ;
    }) ;
  }

  Future<List<DataPoint>> _loadGlucoseData()  {
    return _repository.loadDataPoints() ;
  }

  Future navigateToNewGlucoseReadingPage(BuildContext context) async {
    return AutoRouter.of(context).push(const NewGlucoseReadingRoute()) ;
  }
}