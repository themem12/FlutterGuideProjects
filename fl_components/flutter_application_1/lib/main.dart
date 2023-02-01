import 'package:flutter_application_1/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getMenuRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.themeLight,
    );
  }
}
