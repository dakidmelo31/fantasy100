import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hospital/pages/chat/chat_overview.dart';
import 'package:hospital/pages/dashboard.dart';
import 'package:hospital/pages/empty_page.dart';
import 'package:hospital/pages/home_dashboard.dart';
import 'package:hospital/pages/qr_page.dart';
import 'package:hospital/pages/startup/auth_page.dart';
import 'package:hospital/pages/startup/splash_screen.dart';
import 'package:hospital/pages/startup/startup.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/app_theme.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import 'firebase_options.dart';
import 'utils/globals.dart';

int id = 0;

String? selectedNotificationPayload;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final StreamController<ReceivedNotification> didReceiveNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel(Globals.appName);

class ReceivedNotification {
  final int id;
  final String? title;
  final String? payload;
  final String? body;

  ReceivedNotification(
      {required this.payload,
      required this.id,
      required this.title,
      required this.body});
}

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

bool setupComplete = false;

final navigatorKey = GlobalKey<NavigatorState>();
String initialRoute = SplashScreen.routeName;

Future<void> getTime() async {
  // Globals.globalTime = await NTP.now();
}

final FirebaseMessaging messaging = FirebaseMessaging.instance;

@pragma("vm:entry-point")
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint("notificationTapBackground function called");

  debugPrint(
      "Notification Response: id: ${notificationResponse.id} input: ${notificationResponse.input}, Payload: ${notificationResponse.payload}");
}

Future<void> setupFirebaseMessaging() async {
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFirebaseMessaging();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void showFlutterNotification(RemoteMessage message) {
  debugPrint("Remote Message $message");
  debugPrint("Remote Message ${message.data}");

  selectedNotificationPayload = message.data['payload'];
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    String title = message.notification!.title!;
    String body = message.notification!.body!;
    String payload = message.data['payload'];
    String image = message.data['image'];

    debugPrint("Notification Opened App: $payload");
    List<String> data = payload.split("##");
    if (data[1] == 'msg') {
      Globals.msgNotification(payload, title: title, body: body, image: image);
    } else {}
  }
}

int userID = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // localAuth = LocalAuthentication();
  Future.delayed(const Duration(minutes: 5), getTime);

  await _configureLocalTimeZone();
  final prefs = await SharedPreferences.getInstance();

  Globals.finale =
      DateTime.fromMillisecondsSinceEpoch(await prefs.getInt("finale") ?? 0);

  googleToken = prefs.getString("userToken") ?? '';
  userID = prefs.getInt("userID") ?? 0;
  Globals.verified = prefs.getBool("verified") ?? false;

  toast(message: googleToken);

  // if (googleToken.trim().isNotEmpty) {
  //   debugPrint(googleToken);
  //   final AuthCredential authCredential =
  //       GoogleAuthProvider.credential(idToken: googleToken);
  //   await auth.signInWithCredential(authCredential);
  //   toast(message: auth.currentUser.toString());
  // } else {
  //   toast(message: "Not signed up");
  // }

  //disable printing
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  //Push notification setup
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  initialRoute = SplashScreen.routeName;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = EmptyPage.routeName;
  }

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("ic_launcher");
  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(darwinNotificationCategoryText, actions: [
      DarwinNotificationAction.text("id_1", "Make Offer",
          buttonTitle: "Offer", placeholder: "amount")
    ]),
    DarwinNotificationCategory(darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Close',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
        ]),
  ];

  final DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (id, title, body, payload) {
            didReceiveNotificationStream.add(ReceivedNotification(
                payload: payload, id: id, title: title, body: body));
          },
          notificationCategories: darwinNotificationCategories);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings);

  //Initializing flutter Local Notification Plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectNotificationStream.add(notificationResponse.payload);

        navigatorKey.currentState?.push(
            RightTransition(child: EmptyPage(notificationResponse.payload)));
        debugPrint("Notification got selected");
        break;

      case NotificationResponseType.selectedNotificationAction:
        if (notificationResponse.actionId == navigationActionId) {
          selectNotificationStream.add(notificationResponse.payload);
        }
        if (notificationResponse.input != null) {
          if (notificationResponse.input!.isNotEmpty) {
            debugPrint("You sent: ${notificationResponse.input!}");
          }
        }
        debugPrint("${notificationResponse.payload}");
        debugPrint("Notification Action got selected");
        break;
    }
  }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));

  runApp(const AppDomain());
}

class AppDomain extends StatelessWidget {
  const AppDomain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: initialRoute,
        theme: OMITheme.lightTheme(),
        navigatorKey: navigatorKey,
        darkTheme: OMITheme.darkTheme(),
        routes: {
          Dashboard.routeName: (_) => const Dashboard(),
          HomeBoard.routeName: (_) => const HomeBoard(),
          SplashScreen.routeName: (_) => SplashScreen(null),
          AuthPage.routeName: (_) => const AuthPage(),
          Startup.routeName: (_) => const Startup(),
          QRPage.routeName: (_) => const QRPage(),
          EmptyPage.routeName: (_) => EmptyPage(null),
          ChatOverview.routeName: (_) => const ChatOverview()
        },
      ),
    );
  }
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
