// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationBuilder {
//   FirebaseMessaging fbMessing= FirebaseMessaging.instance;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

//   init() async {


// NotificationSettings settings = await fbMessing.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );
// print(settings.authorizationStatus);
//  const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
//  await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  

//   if (message.notification != null && message.notification.title!="12345") {
//  showNotification();
//   }

  
// });

// String token = await fbMessing.getToken();
// print("firebaseToken =$token");

//   }

// showNotification() async {

 
// // 
// // 
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
// const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('ic_launcher');
// final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
// final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS);
//  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     onSelectNotification: onSelectNotification);



//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: false);
//         var iOSChannelSpecifics = IOSNotificationDetails();
       
//  NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSChannelSpecifics);


// await flutterLocalNotificationsPlugin.show(
//     0, 'plain title', 'plain body', platformChannelSpecifics,
//     payload: 'item x');
// }


// Future onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//  }
//   Future<dynamic> onSelectNotification(String payload){

//   }
// }


//T3K4UY7FDG
//certificate pass//wplpMjWPosA4