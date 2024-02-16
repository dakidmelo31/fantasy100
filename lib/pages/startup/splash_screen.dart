import 'dart:io';

import 'package:concentric_transition/concentric_transition.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/chat/chat_overview.dart';
import 'package:hospital/pages/empty_page.dart';
import 'package:hospital/pages/qr_page.dart';
import 'package:hospital/pages/startup/wave_screen.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';

import '../../main.dart';
import '../dashboard.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen(this.notificationAppLaunchDetails, {super.key});

  NotificationAppLaunchDetails? notificationAppLaunchDetails;
  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _notificationsEnabled = false;

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted =
          await androidImplementation?.requestNotificationsPermission();

      Future.delayed(Duration.zero, () {
        setState(() {
          _notificationsEnabled = granted ?? false;
        });
      });
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                navigatorKey.currentState!.pushReplacement(RightTransition(
                    child: EmptyPage(receivedNotification.payload)));
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      if (mounted) {
        navigatorKey.currentState!
            .pushReplacement(RightTransition(child: EmptyPage(payload)));
      }
    });
  }

  void _configureFirebaseMessagingStream() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("from here now");
      debugPrint("Payload: ${message.data['payload']}");
      if (message.data.containsKey("payload")) {
        debugPrint(
            message.data['payload'] + "____________________________________-");
        navigatorKey.currentState!.pushReplacement(
            RightTransition(child: EmptyPage(message.data['payload'])));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint(message.data['payload']);

      Map<String, dynamic> data = message.data;
      final String title = data['title'];
      final String body = data['description'];
      final String image = data['image'] ?? "";
      final String payload = data['payload'];
      // debugPrint("Messaging now: $message");
      // debugPrint("Data: $data");
      id++;

      // debugPrint(data['type']);
      if (data['type'] == "msg" || data['type'] == "request") {
        Globals.msgNotification(payload,
            title: title, body: body, image: image);
        // Globals.bidNotification(payload, title: title, body: body, image: image, smallPhoto: data['userImage']);
      } else if (data['type'] == 'momo') {
        Globals.momoNotification(payload, title: title, body: body);
      } else if (data['type'] == "ticket") {
        // toast(message: "ticket message received");
        Globals.msgNotification("payload",
            title: "title", body: "body", image: "image");
        debugPrint("Ticket data received");
      } else if (data['type'] == "general") {
        // toast(message: "general message received");
        Globals.localNotification(title: title, body: body, image: image);
        debugPrint("Ticket data received");
      } else {
        debugPrint("should be running here______+++++++++++++++++++++++");
        if (auth.currentUser != null &&
            data.containsKey("userID") &&
            data['userID'] == auth.currentUser!.uid) {
        } else {
          Globals.bidNotification(payload,
              title: title,
              body: body,
              image: image,
              smallPhoto: data['userImage']);
        }
      }
    });
  }

  Future<void> sortOfFix() async {
    NotificationAppLaunchDetails? notifDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notifDetails != null &&
        notifDetails.didNotificationLaunchApp &&
        notifDetails.notificationResponse != null &&
        notifDetails.notificationResponse!.payload!.isNotEmpty) {
      debugPrint("Coming from notification details");
      navigatorKey.currentState?.push(RightTransition(
          child: EmptyPage(notifDetails.notificationResponse?.payload)));
    }
  }

  Future<void> _switchHome() async {
    Future.delayed(const Duration(seconds: 4), () {
      navigatorKey.currentState!
          .pushReplacement(LeftTransition(child: Dashboard()));
    });
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(
        context,
        '/chat',
        arguments: message,
      );
    }
  }

  int _count = 10;
  late final Animation<double> _mainAnim;

  late final AnimationController _animationController;

  bool _flip = false;
  bool _flip2 = false;
  late final Animation<double> _animation;

  @override
  void initState() {
    _switchHome();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..forward();
    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(() {
          _flip = true;
        });
      },
    );
    Future.delayed(
      Duration(seconds: 2),
      () {
        setState(() {
          _flip2 = true;
        });
      },
    );

    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.decelerate);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WaveScreen();
  }
}
