import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  NotificationManager._() {
    _firebaseMessaging = FirebaseMessaging.instance;
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  RemoteMessage messages = const RemoteMessage();

  late final FirebaseMessaging _firebaseMessaging;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static NotificationManager fcmInstance = NotificationManager._();

  Future<void> init() async {
    try {
      await configuration();
      await registerNotification();
    } catch (e) {
      print("e : ${e}");
    }
  }

  Future<void> configuration() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {}
  }

  Future<void> registerNotification() async {
    await _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        NotificationDetails(
          android: AndroidNotificationDetails(
            "جولدين يجم",
            "جولدين جيم",
            enableLights: true,
            importance: Importance.max,
            priority: Priority.max,
            onlyAlertOnce: true,
          ),
        ),
      );
    });
  }
}
