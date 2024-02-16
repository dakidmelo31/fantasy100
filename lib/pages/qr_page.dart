import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/main.dart';
import 'package:hospital/pages/dashboard.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/widgets/my_code.dart';
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
    return Scaffold(
      backgroundColor: Globals.backgroundColor.withOpacity(.095),
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                  child: Hero(
                      tag: "qr_code",
                      child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          shadowColor: Colors.black.withOpacity(.15),
                          elevation: 16,
                          child: const MyCode()))),
            ),
            Positioned(
                bottom: 20,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14.0),
                    child: Row(children: [
                      Card(
                        elevation: 05,
                        shadowColor: Globals.primaryColor.withOpacity(.25),
                        color: Globals.white,
                        shape: CircleBorder(),
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              FontAwesomeIcons.arrowLeftLong,
                              color: Globals.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 33),
                      Text(
                        "Back to Return",
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
