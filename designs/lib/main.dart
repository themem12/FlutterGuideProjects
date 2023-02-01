import 'package:designs/screens/compose_design.dart';
import 'package:designs/screens/scroll_design.dart';
import 'package:flutter/material.dart';
import 'package:designs/screens/basic_design.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Material App',
      initialRoute: 'scroll_design',
      routes: {
        'basic_design': (_) => const BasicDesignScreen(),
        'scroll_design': (_) => const ScrollScreen(),
        'compose_design': (_) => const ComposeScreen(),
      },
    );
  }
}
