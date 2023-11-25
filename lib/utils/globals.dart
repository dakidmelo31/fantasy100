import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Globals {
  static const primaryColor = Color(0xffff5500);
  static const backgroundColor = Color(0xfff5f5f5);
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
