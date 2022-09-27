import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:polar/main.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationService {
  String? fbToken = " ";
  final FirebaseAuth _firebaseAuth;
  final key = Key.fromUtf8('DTgfDQIQAgceGg8dFADDEwEOECEZCxgMBiAUFQwKFhg=');
  final iv = IV.fromLength(16);

  AuthenticationService(this._firebaseAuth);

  Future<void> signIn() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          RemoteNotification notification =
              message.notification as RemoteNotification;
          AndroidNotification android =
              message.notification?.android as AndroidNotification;

          // If `onMessage` is triggered with a notification, construct our own
          // local notification to show to users using the created channel.
          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    icon: '@mipmap/ic_launcher',
                    // other properties...
                  ),
                ));
          }
        });
      }
      getToken();
    } on FirebaseAuthException catch (e) {}
  }

  Future<BasicUser> get_basic_info() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://www.polaraccesslink.com/v3/users/${globals.x_user_id}'),
      headers: <String, String>{
        'Authorization': 'Bearer ${globals.access_token}',
        'Accept': 'application/json'
      },
    );
    return userFromJson(response.body);
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(globals.x_user_id.toString())
        .set({
      'token': token,
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((token) => fbToken = token);
    saveToken(fbToken!);
  }
}
