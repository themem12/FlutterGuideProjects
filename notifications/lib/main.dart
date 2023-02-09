import 'package:flutter/material.dart';
import 'package:notifications/screens/screens.dart';
import 'package:notifications/services/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  await PushNotificationsService.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationsService.messageStream.listen((message) {
      print('MyApp $message');
      navigatorKey.currentState?.pushNamed('message', arguments: message);
      final SnackBar snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      routes: {
        'home':(_) => const HomeScreen(),
        'message':(_) => const MessageScreen(),
      },
    );
  }
}