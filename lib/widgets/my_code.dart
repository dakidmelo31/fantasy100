import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/globals.dart';

class MyCode extends StatefulWidget {
  const MyCode({super.key});

  @override
  State<MyCode> createState() => _MyCodeState();
}

class _MyCodeState extends State<MyCode> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return QrImageView.withQr(
        size: size.width * .95,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        backgroundColor: Globals.white,
        eyeStyle: const QrEyeStyle(
            color: Globals.primaryColor, eyeShape: QrEyeShape.circle),
        dataModuleStyle: const QrDataModuleStyle(
            color: Globals.primaryColor,
            dataModuleShape: QrDataModuleShape.circle),
        embeddedImageStyle: const QrEmbeddedImageStyle(
          color: Globals.primaryColor,
        ),
        qr: QrCode.fromData(
            data: "data", errorCorrectLevel: QrErrorCorrectLevel.Q));
  }
}
