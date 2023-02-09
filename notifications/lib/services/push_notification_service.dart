import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../firebase_options.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static final StreamController<String> _messageStreamController = StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;

  static Future initializeApp() async {
    //Push notifications
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    token = await messaging.getToken();
    print(token);
    //Handlers
    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onOpenHandler );
    //Local notifications
  }

  static Future _backgroundHandler(RemoteMessage message) async{
    // print('Background handler ${message.messageId}');
    print(message.data);
    _messageStreamController.add(message.data['producto'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    // print('On Message Handler handler ${message.messageId}');
    print(message.data);
    _messageStreamController.add(message.data['producto'] ?? 'No data');
  }

  static Future _onOpenHandler(RemoteMessage message) async{
    // print('On Open Handler ${message.messageId}');
    print(message.data);
    _messageStreamController.add(message.data['producto'] ?? 'No data');
  }

  static closeStreams() {
    _messageStreamController.close();
  }

}