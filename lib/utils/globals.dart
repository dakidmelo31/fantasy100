import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../main.dart';

const dir = "assets/lottie";

Future<void> toast(
    {required String message,
    Color? backgroundColor = Colors.black,
    Color? textColor = Colors.white,
    ToastGravity? toastPosition,
    Toast length = Toast.LENGTH_SHORT}) async {
  if (message.isEmpty ||
      message.toUpperCase() == "PAYMENT" ||
      message.toUpperCase() == "USER HAS BEEN NOTIFIED") {
    return;
  }

  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      textColor: textColor,
      backgroundColor: backgroundColor,
      toastLength: length,
      gravity: toastPosition);
}

FirebaseMessaging messaging = FirebaseMessaging.instance;
const IP = "192.168.220.230";

const space = SizedBox(height: kToolbarHeight);

launchWhatsApp({required String phoneNumber, required String message}) async {
  final link = WhatsAppUnilink(phoneNumber: phoneNumber, text: message);
  // ignore: deprecated_member_use
  await launch("$link");
}

class Globals {
  static const appName = "Fantasy100";

  static const brown = Color(0xff1A1423);

  static const photoPlaceholder =
      'https://firebasestorage.googleapis.com/v0/b/fantasy100.appspot.com/o/male.jpg?alt=media&token=c05f83d4-b3d3-4930-9c94-6ef6220698d1';

  static const classicLeague = 619605;

  static bool verified = false;

  static Future<void> sendGeneralNotification(
      {required String title,
      required String receiverID,
      required String message,
      required String image,
      required String ticketID,
      String type = ''}) async {
    var dio = Dio();
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: "jwt");
    dio.options.headers["x-access-token"] = jwt.toString();
    debugPrint("My id: ${auth.currentUser?.uid}");
    debugPrint("JWT: $jwt");

    debugPrint("URL: ${'https://$IP/api/v2/general'}");
    var res = await dio.post('https://$IP/api/v2/general', data: {
      "userID": auth.currentUser!.uid,
      "ticketID": ticketID,
      "receiverID": receiverID,
      "bidID": receiverID,
      "image": image,
      "type": type,
      "title": title,
      "description": message,
    }).catchError((onError) {
      debugPrint("Error found: $onError");
      return onError;
    });
    var json = res.data as Map<String, dynamic>;
    debugPrint(res.toString());
    // toast(message: json["message"], length: Toast.LENGTH_LONG);
    // debugPrint("$res");

    // late Map payload;// = json.decode(ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
  }

  static String referralCodeGen({int len = 8}) {
    final Random random = Random();
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';

    for (int i = 0; i < len; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  // static const primaryColor = Color(0xffFF0022);
  static const primaryColor = Color(0xff2B9720);
  // static const primaryColor = Color(0xffDD1C1A);
  static const backgroundColor = Color(0xfffcfcfc);

  static const white = Colors.white;

  static const accentColor = Color(0xFFEEAA00);

  static const whiteText =
      TextStyle(color: Colors.white, fontFamily: "Lato", fontSize: 16);
  static const lightText =
      TextStyle(color: Color(0xff000000), fontFamily: "Lato", fontSize: 16);
  static const lightWhiteText =
      TextStyle(color: Color(0xffdddddd), fontFamily: "Lato", fontSize: 16);
  static const feeText = TextStyle(
      color: Color(0xff333333),
      fontFamily: "Lato",
      fontWeight: FontWeight.w300);
  static const subtitle = TextStyle(
      color: Colors.black, fontFamily: "Lato", fontWeight: FontWeight.w300);
  static const greySubtitle = TextStyle(
      color: Color(0xffaaaaaa),
      fontFamily: "Lato",
      fontWeight: FontWeight.w300);
  static const title = TextStyle(
      color: Colors.black,
      fontFamily: "Lato",
      overflow: TextOverflow.ellipsis,
      fontSize: 16,
      fontWeight: FontWeight.w800);
  static const primaryText = TextStyle(
      color: primaryColor,
      fontFamily: "Lato",
      fontSize: 16,
      fontWeight: FontWeight.w800);
  static const primaryTitle = TextStyle(
      color: primaryColor,
      fontFamily: "Lato",
      fontSize: 16,
      fontWeight: FontWeight.w800);
  static const whiteTile = TextStyle(
      color: Colors.white,
      fontFamily: "Lato",
      fontSize: 16,
      fontWeight: FontWeight.w800);
  static const greyTitle = TextStyle(
      color: Color(0xffeeddcc), fontSize: 16, fontWeight: FontWeight.w900);
  static const whiteTextBigger =
      TextStyle(color: Colors.white, fontFamily: "Lato", fontSize: 26);

  static const mainDuration = Duration(milliseconds: 700);
  static const revDuration = Duration(milliseconds: 300);

  static const black = Color(0xff1A1423);
  static const blacker = Color(0xFF2B2139);
  static const darkBlue = Color(0xff030027);
  static const lightBlack = Color(0xff1A1423);
  static const transparent = Color(0x00000000);

  static const timeText =
      TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w700);
  static const heading = TextStyle(
      fontFamily: "Lato",
      color: Color(0xff1E1E24),
      fontSize: 22,
      fontWeight: FontWeight.w700);
  static const whiteHeading = TextStyle(
      fontFamily: "Lato",
      fontSize: 26,
      color: Colors.white,
      fontWeight: FontWeight.w400);

  static const mainDurationLonger = Duration(milliseconds: 1200);
  // static const mainDuration = Duration(milliseconds: 800);
  static const gemini = "AIzaSyC63F6E_pUls-zyvkU5I7zKCj1Muv3d9ek";
  static Future<void> flipSettings({required String field}) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(field)) {
      prefs.remove(field);
    } else {
      prefs.setBool(field, true);
    }
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      'General Notifications',
      enableVibration: true,
      channelShowBadge: true,
      groupKey: "Parking",
      playSound: true,
      showWhen: true,
      colorized: true,
      color: Globals.primaryColor,
      subText:
          "You're past your free parking time, You will be charged beginning now",
      visibility: NotificationVisibility.public,
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static bool parked = false;
  static Future<void> toast(String msg,
      {Color backgroundColor = Colors.white,
      Toast length = Toast.LENGTH_LONG,
      Color color = Colors.black,
      ToastGravity position = ToastGravity.BOTTOM}) async {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: backgroundColor,
        gravity: position,
        textColor: color,
        toastLength: length);
  }

  static RoundedRectangleBorder radius(double i) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(i));
  }

  static vibrate() async {
    if (await Vibration.hasCustomVibrationsSupport() == true) {
      Vibration.vibrate(duration: 100, amplitude: 20);
    } else {
      Vibration.vibrate(duration: 100, amplitude: 20);
      await Future.delayed(const Duration(milliseconds: 50));
      Vibration.vibrate(duration: 100, amplitude: 20);
    }
  }

  vibrateLonger() async {
    if (await Vibration.hasCustomVibrationsSupport() == true) {
      Vibration.vibrate(duration: 500, amplitude: 20);
    } else {
      Vibration.vibrate(duration: 500, amplitude: 20);
      await Future.delayed(const Duration(milliseconds: 50));
      Vibration.vibrate(duration: 500, amplitude: 20);
    }
  }

  static Future<String> uploadPhoto(File file) async {
    Uuid uuid = const Uuid();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("profiles/${uuid.v4()}");
    UploadTask uploadTask = ref.putFile(File(file.path));
    String location = await uploadTask.then((event) {
      return event.ref.getDownloadURL().then((value) async {
        debugPrint("current URL: $value");
        return value;
      }).then(
        (value) => value,
      );
    });
    return location;
  }

  static Color blue = const Color.fromARGB(255, 32, 0, 215);
  static Color pink = Colors.pink;

  static const bigText = 28.0;

  static Future<void> showNotificationWithActions(String payload,
      {required String type,
      required String title,
      required String description,
      required String image,
      required String userPhoto}) async {
    debugPrint("userPHOTO: $userPhoto -----------------------");
    final String bigPicturePath =
        await downloadAndSaveFile(image, 'bigPicture');
    final String largeIconPath = userPhoto == ''
        ? bigPicturePath
        : await downloadAndSaveFile(userPhoto, 'largeIcon');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: title,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'big text channel id', 'big text channel name',
            channelDescription: 'big text channel description',
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(
          subtitle: title,
        ));
    await FlutterLocalNotificationsPlugin()
        .show(id == null ? 10 : id++, title, description, notificationDetails,
            payload: payload)
        .catchError((onError) {
      debugPrint("-------------------------------------------------$onError");
    });
  }

  static Future<Uint8List> getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  static Future<void> showBigPictureNotificationURL(
      {required String bidID,
      required String title,
      required String description,
      required String plainTitle}) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
        await getByteArrayFromUrl(
            'https://media.istockphoto.com/id/1391892431/photo/childrens-football.jpg?b=1&s=170667a&w=0&k=20&c=VXOh4Hvn1RvO6EmpnCUx-Wf4JinqnUp89EevA2sLgXQ='));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        await getByteArrayFromUrl(
            "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture,
            largeIcon: largeIcon,
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: description,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('bidChannel', 'Bid Notifications',
            channelDescription:
                'Receive and show bid details associated with bids',
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await FlutterLocalNotificationsPlugin()
        .show(id++, plainTitle, description, notificationDetails);
  }

  static Future<void> localNotification(
      {required String title,
      required String body,
      required String image}) async {
    const int maxProgress = 60;
    int seconds = 90;
    bool shouldCancelNotification = false;

    while (true) {
      if (shouldCancelNotification) {
        bool ans = await Future.delayed(const Duration(seconds: 76), () {
          flutterLocalNotificationsPlugin.cancel(10);
        }).then((value) {
          return true;
        });
      }

      if (seconds >= 90) {
        break;
      }

      shouldCancelNotification = true;

      await Future.delayed(const Duration(seconds: 1), () async {
        // Android notification settings
        final androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'Parking',
          'Parking Session',
          channelDescription: 'Active Parking Session Notifications Go Here',
          importance: Importance.low,
          silent: true,
          icon: "@drawable/app_icon",
          priority: Priority.min,
          ongoing: true,
          showProgress: true,
          maxProgress: maxProgress,
          colorized: true,
          color: Globals.primaryColor,
          enableVibration: false,
          indeterminate: false,
          groupKey: "Parking",
          onlyAlertOnce: true,
          ticker: 'Active Parking: ${_formatTime(seconds)}',
        );

        // iOS notification settings
        const darwinNotificationDetails = DarwinNotificationDetails(
          categoryIdentifier: darwinNotificationCategoryText,
          interruptionLevel: InterruptionLevel.critical,
          threadIdentifier: 'Parking',
          subtitle: 'Santa Lucia Super Mall, Deido active parking',
        );

        final notificationDetails = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: darwinNotificationDetails,
          macOS: darwinNotificationDetails,
        );

        seconds++;

        await flutterLocalNotificationsPlugin.show(
          10,
          'Active Parking: ${_formatTime(seconds)}',
          'Santa Lucia Super Mall, Deido active parking',
          notificationDetails,
          payload: 'parking##id',
        );
      });
    }
  }

  static String _formatTime(int seconds) {
    final hours = (seconds / (60 * 60)).floor();
    final minutes = ((seconds / 60) % 60).floor();
    final remainingSeconds = seconds % 60;

    final formattedTime = StringBuffer();

    if (hours >= 1) {
      formattedTime.write('$hours hr ');
    }

    if (minutes >= 1) {
      formattedTime.write('$minutes mins ');
    }

    formattedTime.write('$remainingSeconds s');

    return formattedTime.toString();
  }

  static Future<void> msgNotification(String payload,
      {required String title,
      required String body,
      required String image}) async {
    final AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Chat',
      'Chat Messages',
      channelDescription:
          'Your main channel for all chat related notifications',
      largeIcon: DrawableResourceAndroidBitmap("@drawable/ic_launcher"),
      playSound: true,
      icon: "@drawable/ic_launcher",
      enableVibration: true,
      importance: Importance.max,
      colorized: true,
      color: Globals.primaryColor,
      subText: "Chat",
    );
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(
          subtitle: title,
        ));

    FlutterLocalNotificationsPlugin().show(
      id++,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> bidNotification(String payload,
      {required String title,
      required String body,
      required String image,
      String smallPhoto = ''}) async {
    final String bigPicturePath =
        await downloadAndSaveFile(image, 'bigPicture');
    debugPrint("bigPath: $bigPicturePath");
    final String largeIconPath =
        await downloadAndSaveFile(smallPhoto, 'largeIcon');
    debugPrint("smallPath: $largeIconPath");

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: title,
            htmlFormatContent: true,
            hideExpandedLargeIcon: true,
            htmlFormatTitle: true,
            htmlFormatContentTitle: true,
            summaryText: body,
            htmlFormatSummaryText: true);

    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Bid News", 'All Bid News',
            channelDescription: 'Notifications on Bid Updates and knockoffs',
            icon: '@drawable/ic_launcher',
            enableLights: true,
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            color: Globals.primaryColor,
            colorized: true,
            enableVibration: true,
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(
          subtitle: title,
        ));

    FlutterLocalNotificationsPlugin().show(
      id++,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static bool gemInformation = false;

  static Future<void> showBigPictureNotificationBase64() async {
    final String largeIcon =
        await _base64encodedImage('https://dummyimage.com/48x48');
    final String bigPicture =
        await _base64encodedImage('https://dummyimage.com/400x800');

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
                bigPicture), //Base64AndroidBitmap(bigPicture),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: true,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'big text channel id', 'big text channel name',
            channelDescription: 'big text channel description',
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id, 'big text title', '', notificationDetails);
  }

  static Future<void> momoNotification(String payload,
      {required String title, required String body}) async {
    final AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Payment', 'Payment Notifications',
      channelDescription: 'Channel for all payment related notifications',
      icon: "@drawable/brown_ic",
      // icon: "@drawable/brown_ic",
      // largeIcon: const DrawableResourceAndroidBitmap("@drawable/ic_notification_icon"),
      largeIcon: DrawableResourceAndroidBitmap("@drawable/brown_ic"),
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      colorized: true,
      color: Globals.primaryColor,
      subText: "MoMo",
    );
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(
          subtitle: title,
        ));

    FlutterLocalNotificationsPlugin().show(
      id++,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static void signup(String phone) {}

  static Future<void> googleSignup() async {
    GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account != null) {
      final idToken = account.id;
      debugPrint(idToken);

// Use the ID token to sign in with Firebase
      final AuthCredential credential =
          GoogleAuthProvider.credential(idToken: idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      toast("Successfully logged in");

      // Access user information (if authenticated)
    } else {
      toast("Failed to signin, try again");
    }
  }
}

String googleToken = '';

final googleSignIn = GoogleSignIn(
  scopes: ['email'],
);
Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

Widget placeholder = Lottie.asset(
  "$dir/load1.json",
  fit: BoxFit.contain,
  filterQuality: FilterQuality.high,
);
Widget scanning = Lottie.asset(
  "$dir/scan.json",
  fit: BoxFit.contain,
  height: 80,
  width: 80,
  filterQuality: FilterQuality.high,
);
Widget mainLoader = Lottie.asset(
  "assets/lottie/load1.json",
  fit: BoxFit.contain,
  filterQuality: FilterQuality.high,
);
Widget errorWidget2 = Lottie.asset(
  "assets/lottie/no-connection2.json",
  fit: BoxFit.contain,
  filterQuality: FilterQuality.high,
);
Widget returnWidget = Lottie.asset("assets/lottie/return1.json",
    fit: BoxFit.contain,
    filterQuality: FilterQuality.high,
    width: 70,
    height: 70);
double ourCut = .02;

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

// final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> _base64encodedImage(String url) async {
  // final http.Response response = await http.get(Uri.parse(url));
  // final String base64Data = base64Encode(response.bodyBytes);
  return 'base64Data';
}

String prettyNumber(dynamic num) {
  return NumberFormat().format(num);
}

List<Map<String, dynamic>> dummyGroups = [
  {
    "title": "Mega Contest",
    "playersID": [],
    "entryFee": 200,
    "limit": 1000000,
    "closed": false,
    "cashPrize": 250000,
    "endsAt": DateTime.now().add(Duration(days: 12)).millisecondsSinceEpoch,
    "winningPositions": [
      {
        "title": "First Position",
        "prize": 60,
        "mandatoryGames": 10,
        "bonus": 1000,
        "winnerID": null
      },
      {
        "title": "Second Position",
        "prize": 12,
        "mandatoryGames": 10,
        "bonus": 1000,
        "winnerID": null
      },
      {
        "title": "Third Position",
        "prize": 7,
        "mandatoryGames": 10,
        "bonus": 2000,
        "winnerID": null
      },
      {
        "title": "Fourth Position",
        "prize": 5,
        "mandatoryGames": 10,
        "bonus": 2500,
        "winnerID": null
      },
    ]
  },
  {
    "title": "Lucky Stars Align",
    "playersID": [],
    "entryFee": 100,
    "limit": 250000,
    "closed": false,
    "cashPrize": 50000,
    "endsAt": DateTime.now().add(Duration(days: 12)).millisecondsSinceEpoch,
    "winningPositions": [
      {
        "title": "First Position",
        "prize": 10,
        "mandatoryGames": 5,
        "bonus": 1000,
        "winnerID": null
      },
      {
        "title": "Second Position",
        "prize": 8,
        "mandatoryGames": 5,
        "bonus": 500,
        "winnerID": null
      },
      {
        "title": "Third Position",
        "prize": 5,
        "mandatoryGames": 5,
        "bonus": 250,
        "winnerID": null
      },
      {
        "title": "Fourth Position",
        "prize": 3,
        "mandatoryGames": 5,
        "bonus": 100,
        "winnerID": null
      },
      {
        "title": "Fifth Position",
        "prize": 2,
        "mandatoryGames": 5,
        "winnerID": null
      }
    ]
  },
  {
    "title": "Epic Encounters",
    "playersID": [],
    "entryFee": 250,
    "limit": 750000,
    "closed": false,
    "cashPrize": 150000,
    "endsAt": DateTime.now().add(Duration(days: 12)).millisecondsSinceEpoch,
    "winningPositions": [
      {
        "title": "First Position",
        "prize": 30,
        "mandatoryGames": 12,
        "bonus": 5000,
        "winnerID": null
      },
      {
        "title": "Second Position",
        "prize": 15,
        "mandatoryGames": 12,
        "bonus": 2500,
        "winnerID": null
      },
      {
        "title": "Third Position",
        "prize": 10,
        "mandatoryGames": 12,
        "bonus": 1000,
        "winnerID": null
      },
      {
        "title": "Fourth Position",
        "prize": 7,
        "mandatoryGames": 12,
        "bonus": 500,
        "winnerID": null
      },
      {
        "title": "Fifth Position",
        "prize": 5,
        "mandatoryGames": 12,
        "winnerID": null
      }
    ]
  },
  {
    "title": "Fortunate Frenzy",
    "playersID": [],
    "entryFee": 200,
    "limit": 1000000,
    "closed": false,
    "cashPrize": 250000,
    "endsAt": DateTime.now().add(Duration(days: 12)).millisecondsSinceEpoch,
    "winningPositions": [
      {
        "title": "First Position",
        "prize": 25,
        "mandatoryGames": 10,
        "bonus": 5000,
        "winnerID": null
      },
      {
        "title": "Second Position",
        "prize": 12,
        "mandatoryGames": 10,
        "bonus": 2500,
        "winnerID": null
      },
      {
        "title": "Third Position",
        "prize": 8,
        "mandatoryGames": 10,
        "bonus": 1000,
        "winnerID": null
      },
      {
        "title": "Fourth Position",
        "prize": 5,
        "mandatoryGames": 10,
        "bonus": 500,
        "winnerID": null
      },
      {
        "title": "Fifth Position",
        "prize": 3,
        "mandatoryGames": 10,
        "bonus": 250,
        "winnerID": null
      }
    ]
  },
  {
    "title": "Masterful Mania",
    "playersID": [],
    "entryFee": 150,
    "limit": 500000,
    "closed": false,
    "cashPrize": 100000,
    "endsAt": DateTime.now().add(Duration(days: 12)).millisecondsSinceEpoch,
    "winningPositions": [
      {
        "title": "First Position",
        "prize": 20,
        "mandatoryGames": 15,
        "bonus": 3000,
        "winnerID": null
      },
      {
        "title": "Second Position",
        "prize": 10,
        "mandatoryGames": 15,
        "bonus": 2000,
        "winnerID": null
      },
      {
        "title": "Third Position",
        "prize": 7,
        "mandatoryGames": 15,
        "bonus": 1000,
        "winnerID": null
      },
      {
        "title": "Fourth Position",
        "prize": 5,
        "mandatoryGames": 15,
        "bonus": 500,
        "winnerID": null
      },
      {
        "title": "Fifth Position",
        "prize": 3,
        "mandatoryGames": 15,
        "winnerID": null
      }
    ]
  },
];
