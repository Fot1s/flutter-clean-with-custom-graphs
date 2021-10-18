// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../pages/home/my_home_page.dart' as _i1;
import '../pages/new_glucose_reading/new_glucose_reading_page.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Home.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MyHomePage());
    },
    NewGlucoseReading.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.NewGlucoseReadingPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(Home.name, path: '/'),
        _i3.RouteConfig(NewGlucoseReading.name,
            path: '/new-glucose-reading-page')
      ];
}

/// generated route for [_i1.MyHomePage]
class Home extends _i3.PageRouteInfo<void> {
  const Home() : super(name, path: '/');

  static const String name = 'Home';
}

/// generated route for [_i2.NewGlucoseReadingPage]
class NewGlucoseReading extends _i3.PageRouteInfo<void> {
  const NewGlucoseReading() : super(name, path: '/new-glucose-reading-page');

  static const String name = 'NewGlucoseReading';
}
