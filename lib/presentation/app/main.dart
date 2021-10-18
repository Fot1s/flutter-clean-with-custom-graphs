import 'package:flutter/material.dart';
import 'package:lab_coffee/presentation/theme/theme_data.dart';

import 'router.gr.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

    return MaterialApp.router(
      title: 'Clean Custom Graphs',
      theme: MyTheme.mainTheme,
      routerDelegate:_appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}


