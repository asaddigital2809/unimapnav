import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unimapnav/firebase_options.dart';
import 'package:unimapnav/services/Notification.dart';
import 'package:unimapnav/views/aauth/login_screen.dart';
import 'package:unimapnav/views/splash/splashScreen.dart';
String fcmGlobal = '';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initNotification();
  NotificationPop notificationPop = NotificationPop();
  notificationPop.setFcmToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uni Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const SplashScreen(),
    );
}
}
initNotification() async {
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
      });
  if (Platform.isAndroid) {
    var status = await Permission.notification.status;
    if (status.isGranted) {
      return;
    } else {
      Permission.notification.request();
    }
  } else {
    var status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
      return;
    }
  }
}



