import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/pages/qr_page.dart';
import 'package:lottie/lottie.dart';

import '../utils/globals.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key});

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 22.0,
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QRPage.routeName);
        },
        customBorder: const CircleBorder(),
        child: ClipOval(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: true
                  ? Lottie.asset("$dir/qr.json",
                      width: 85, height: 85, alignment: Alignment.center)
                  : const Icon(
                      FontAwesomeIcons.qrcode,
                      size: 40,
                      color: Globals.primaryColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
