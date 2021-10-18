import 'package:auto_route/annotations.dart';
import 'package:lab_coffee/presentation/pages/home/my_home_page.dart';
import 'package:lab_coffee/presentation/pages/new_glucose_reading/new_glucose_reading_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MyHomePage, initial: true, name: "home"),
    AutoRoute(page: NewGlucoseReadingPage, name: "newGlucoseReading"),
  ],
)
class $AppRouter {
}