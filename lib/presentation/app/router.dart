import 'package:auto_route/annotations.dart';
import 'package:lab_coffee/presentation/pages/home/my_home_page.dart';
import 'package:lab_coffee/presentation/pages/isolates_testing/isolates_testing_page.dart';
import 'package:lab_coffee/presentation/pages/new_glucose_reading/new_glucose_reading_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MyHomePage, initial: true),
    AutoRoute(page: NewGlucoseReadingPage),
    AutoRoute(page: IsolatesTestingPage),
  ],
)
class $AppRouter {
}