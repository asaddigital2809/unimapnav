import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class NotificationPop {
  static String serverKey =
      "AAAAXVHRoXQ:APA91bH0Rniq4K5kUqEBcbPOxnARyR3S_H58YTKLqj8ftQWHpAA7ObkrTb2hMN8_jHccTQOfTj-TwiDEXqTS9r6kH42zAbpLdLa6HnuMQx0JYkgzRevv30a8_XaXlipIu4-CF2wJNL2l";
  StreamSubscription? _subscription;

  AndroidNotificationChannel? channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  NotificationContent? notificationContent;

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    print('Handling a background message ${message.messageId}');
  }

  subCribedTopics(topic) async {
    print("Subcribed Called");

    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  NotificationPop() {
    mnotificationPop();
    // getNotification();
  }

  onOpenApp(
      RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) async {
    // var type = message.data['notification_type'].toString();
    // log(type);
    // if(type == 'neworder' ){
    //   print(message.data['order_id']);
    //   Provider.of<SocketProvider>(navigatorKey.currentState!.context, listen: false).newOrderListener(message.data['order_id']);
    // }else if(type == 'updateorder'){
    //   Provider.of<SocketProvider>(navigatorKey.currentState!.context, listen: false)
    //       .getAllActiveOrder((bool status,String msg) {
    //     if(status){
    //       Provider.of<SocketProvider>(navigatorKey.currentState!.context, listen: false).calculateTotalActiveOrders();
    //     }
    //   });
    // }
  }

  setFcmToken() async {
    FirebaseMessaging _firebaseMessaging = await FirebaseMessaging.instance;

    _firebaseMessaging.getToken().then((value) async {
      fcmGlobal = value.toString();
    });
  }

  mnotificationPop() async {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('res_alert_short'));

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  getNotification(BuildContext context) async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('A new onMessageOpenedApp event was published!!!!1');
      }
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      AwesomeNotifications().initialize(
        'resource://mipmap/ic_launcher',
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'call_channel',
              /* same name */
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              soundSource: 'resource://raw/res_alert_short',
              playSound: true,
              defaultColor: Colors.white,
              ledColor: Colors.white)
        ],
      );
      print(
          "message type<<<${message.data['notification_type']}${DateTime.now()}");

      var type = message.data['notification_type'].toString();
      // await Future.delayed(const Duration(seconds: 2));
      // if(isNewOrderListened == false){
      //   if (type.contains('neworder_hiden') || type == 'neworder_hiden') {
      //     newOrderListener(message.data['order_id'],context);
      //   } else if (type == 'updateorder') {
      //     // Provider.of<SocketProvider>(context, listen: false)
      //     //     .getAllActiveOrder((bool status,String msg) {
      //     //   if(status){
      //     //     Provider.of<SocketProvider>(context, listen: false).calculateTotalActiveOrders();
      //     //   }
      //     // });
      //   }
      //   RemoteNotification? notification = message.notification;
      //   AndroidNotification? android = message.notification?.android;
      //   if (notification != null && android != null && !kIsWeb) {
      //     notificationContent  = NotificationContent(
      //         id: 10,
      //         channelKey: 'call_channel',
      //         title:notification.title,
      //         body: notification.body,
      //         displayOnForeground: false,
      //         // bigPicture: message.data['image'],
      //         wakeUpScreen: true,
      //         customSound: 'resource://raw/res_alert_short',
      //         criticalAlert: true
      //       // icon:
      //     );
      //     if (notificationContent != null) {
      //       AwesomeNotifications().createNotification(content: notificationContent!);
      //     }
      //   }
      // }
    });
  }

  getLocalNotification() async {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
        playSound: true,
        showBadge: true);
    AwesomeNotifications().initialize(
      'resource://mipmap/ic_launcher',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'call_channel',
            /* same name */
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Colors.white,
            playSound: true,
            ledColor: Colors.white)
      ],
    );
    notificationContent = NotificationContent(
        id: 10,
        channelKey: 'call_channel',
        title: 'QUICK UP Rider',
        body: 'You have received a new order',
        wakeUpScreen: true,
        displayOnForeground: false,
        criticalAlert: true);
    if (notificationContent != null) {
      AwesomeNotifications().createNotification(content: notificationContent!);
    }
  }
}
