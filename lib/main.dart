import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/services/navigation/route_names.dart';
import '/services/navigation/routes.dart';
import '/services/service_locator.dart';
import '/themes/app_theme.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('appBox');

  final serviceLocator = ServiceLocator();
  await serviceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PP-17',
      theme: DefaultThemeGetter.get(),
      routes: Routes.get(context),
      initialRoute: RouteNames.splash,
    );
  }
}
