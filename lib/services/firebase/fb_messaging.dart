import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_learning/services/firebase/received_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FBMessaging {
  FBMessaging._();

  static final fbMessaging = FBMessaging._();

  late FirebaseMessaging firebaseMessaging;
  String? selectedNotificationPayload;
  final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

  late final AndroidInitializationSettings initializationSettingsAndroid;
  late final IOSInitializationSettings initializationSettingsIOS;
  late final MacOSInitializationSettings initializationSettingsMacOS;
  late final LinuxInitializationSettings initializationSettingsLinux;
  late final InitializationSettings initializationSettings;

  Future<void> init() async {
    await configureLocalTimeZone();

    //---firebase messaging---
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp();

    //---local notification---
    //android
    initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          didReceiveLocalNotificationSubject.add(
            ReceivedNotification(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
        });

    initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  void initState() {
    //---firebase messaging---
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) {
      stderr.write("FCM: $value");
    });
    FirebaseMessaging.onMessage.listen((message) {
      stderr.write("message received");
      stderr.write("event: ${message.notification?.body}");
      stderr.write(message.data.values);

      if (message.notification != null) {
        showNotification(message.notification!);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      stderr.write("message opened");
    });

    //---local notification---
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) {
      if (payload != null) {
        stderr.write('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    });
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  void showNotification(RemoteNotification notification) async {
    String? title = notification.title;
    String? body = notification.body;
    String? imageUrl = notification.android?.imageUrl ?? notification.apple?.imageUrl;
    if (title != null && body != null) {
      if (imageUrl != null) {
        await createBigPictureNotification(title, body, imageUrl);
      } else {
        await createNotification(title, body);
      }
    }
  }

  Future<void> createNotification(String title, String body) async {
    //android
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails('channel_ID', 'channel name',
        channelDescription: "channel description",
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.max,
        ticker: 'test ticker');

    //ios
    var iOSChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  Future<void> createBigPictureNotification(String title, String body, String imageUrl) async {
    final String largeIcon = await base64encodedImage(imageUrl);
    final String bigPicture = await base64encodedImage(imageUrl);

    //android
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(bigPicture), //Base64AndroidBitmap(bigPicture),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            contentTitle: 'title',
            htmlFormatContentTitle: true,
            summaryText: 'body',
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('channel_ID', 'channel name',
        channelDescription: "channel description",
        styleInformation: bigPictureStyleInformation,
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.max,
        ticker: 'test ticker');

    //ios
    final String bigPicturePath = await downloadAndSaveFile(imageUrl, 'bigPicture.jpg');
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(attachments: <IOSNotificationAttachment>[IOSNotificationAttachment(bigPicturePath)]);

    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<String> base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }
}
