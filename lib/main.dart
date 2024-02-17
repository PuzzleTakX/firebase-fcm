import 'dart:io';

import 'package:fcm_firebase/home_screen.dart';
import 'package:fcm_firebase/service_firebase/background_firbase.dart';
import 'package:fcm_firebase/service_firebase/firebase_core_init.dart';
import 'package:fcm_firebase/service_firebase/firebase_options.dart';
import 'package:fcm_firebase/utils/http_overrides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        name: 'firbase-fcm-puzzletak',
        options: DefaultFirebaseOptions.currentPlatform,
      ).whenComplete(() {});
    }
    // auto enable notification
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance.subscribeToTopic("general");
    await FirebaseMessaging.instance.subscribeToTopic("rayapars");

    // notification on background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // notification on foreground
    FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);

  } catch (e) {print(e);}
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  print(
      "_firebaseMessagingBackgroundHandler_firebaseMessagingBackgroundHandler_firebaseMessagingBackgroundHandler");
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'firbase-fcm-puzzletak',
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {});
  }
  Map<String, dynamic> data = message.data;
  // await updateCountMessage(int.parse(message.data['id'].toString()));
  notificationBackground(data);
}
Future<void>notificationBackground(Map<String, dynamic> data) async {

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (cc) {
        // Helper.launchURL(cc.toString());
      });

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    color: Colors.deepPurpleAccent,
    styleInformation: BigTextStyleInformation( data['body'].toString()),
  );
  var iOSPlatformChannelSpecifics =  IOSNotificationDetails();
  var platformChannelSpecifics =  NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    data['title'].toString(),
    data['body'].toString(),
    platformChannelSpecifics,
    payload: data['link'].toString(),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
