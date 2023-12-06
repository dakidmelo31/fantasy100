import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/globals.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key});

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 22.0,
      onPressed: () {},
      color: Colors.white,
      shape: CircleBorder(),
      child: ClipOval(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
              child: Icon(
            FontAwesomeIcons.qrcode,
            size: 40,
            color: Globals.primaryColor,
          )),
        ),
      ),
    );
  }
}
