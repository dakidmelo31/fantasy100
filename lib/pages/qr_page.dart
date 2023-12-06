import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital/main.dart';
import 'package:hospital/pages/dashboard.dart';
import 'package:hospital/utils/globals.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});
  static const routeName = '/qr_page';

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Material(
      child: CupertinoPageScaffold(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      )),
    );
  }
}
