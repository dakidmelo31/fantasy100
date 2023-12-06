import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Globals {
  static const primaryColor = Color(0xffff5500);
  static const backgroundColor = Color(0xfff9f9f9);

  static const white = Colors.white;

  static const accentColor = Color(0xFFEEAA00);

  static const whiteText =
      TextStyle(color: Colors.white, fontFamily: "Lato", fontSize: 16);
  static const whiteTextBigger =
      TextStyle(color: Colors.white, fontFamily: "Lato", fontSize: 26);

  static const mainDuration = Duration(milliseconds: 700);
  static const revDuration = Duration(milliseconds: 300);

  static const black = Color(0xff000000);
  static const transparent = Color(0x00000000);
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
}

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
// final FirebaseAuth auth = FirebaseAuth.instance;
