import 'package:flutter/material.dart';
import 'package:form_validation/screens/screens.dart';
import 'package:form_validation/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => ProductsService(),),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'checkIn': (context) => const CheckAuthScreen(),
        'home': (context) => const HomeScreen(),
        'login': (context) => const LoginScreen(),
        'product': (context) => const ProductScreen(),
        'register': (context) => const RegisterScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        ),
      ),
    );
  }
}
