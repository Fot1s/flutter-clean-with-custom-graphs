// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../pages/home/my_home_page.dart' as _i1;
import '../pages/isolates_testing/isolates_testing_page.dart' as _i3;
import '../pages/new_glucose_reading/new_glucose_reading_page.dart' as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MyHomePage());
    },
    NewGlucoseReadingRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.NewGlucoseReadingPage());
    },
    IsolatesTestingRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.IsolatesTestingPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(MyHomeRoute.name, path: '/'),
        _i4.RouteConfig(NewGlucoseReadingRoute.name,
            path: '/new-glucose-reading-page'),
        _i4.RouteConfig(IsolatesTestingRoute.name,
            path: '/isolates-testing-page')
      ];
}

/// generated route for [_i1.MyHomePage]
class MyHomeRoute extends _i4.PageRouteInfo<void> {
  const MyHomeRoute() : super(name, path: '/');

  static const String name = 'MyHomeRoute';
}

/// generated route for [_i2.NewGlucoseReadingPage]
class NewGlucoseReadingRoute extends _i4.PageRouteInfo<void> {
  const NewGlucoseReadingRoute()
      : super(name, path: '/new-glucose-reading-page');

  static const String name = 'NewGlucoseReadingRoute';
}

/// generated route for [_i3.IsolatesTestingPage]
class IsolatesTestingRoute extends _i4.PageRouteInfo<void> {
  const IsolatesTestingRoute() : super(name, path: '/isolates-testing-page');

  static const String name = 'IsolatesTestingRoute';
}
