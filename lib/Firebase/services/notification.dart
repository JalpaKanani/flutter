import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

Future<void> backgroundHandler(RemoteMessage message) async {
  print('message received${message.notification!.title}');
}

class NotificationService {
  static Future<void> initialize() async {
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if(settings.authorizationStatus == AuthorizationStatus.authorized){
        String? token = await FirebaseMessaging.instance.getToken();
        if(token!= null){
          print(token);
        }
      }


      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      print('notification initialized');
    }
  }
}
