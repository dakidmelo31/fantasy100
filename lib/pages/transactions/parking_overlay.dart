import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/utils/globals.dart';
import 'package:jiffy/jiffy.dart';

class ParkingOverlay extends StatelessWidget {
  ParkingOverlay({super.key, required this.index});
  final int index;
  late bool test = index % 3 == 0;
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: Hero(
              tag: "$index",
              child: Card(
                shape: Globals.radius(26),
                elevation: 70,
                surfaceTintColor: Globals.primaryColor,
                shadowColor: Colors.black.withOpacity(.18),
                color: Colors.white,
                child: InkWell(
                  highlightColor: Colors.white,
                  onTap: () {},
                  splashColor: Colors.grey.withOpacity(.1),
                  customBorder: Globals.radius(26),
                  child: SizedBox(
                    width: size.width * .9,
                    height: 310.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: 28.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "2 hours",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Globals.primaryColor),
                                    ),
                                    Text(
                                      " : ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                    Text(
                                      "49 Minutes",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffaaaaaa)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 8.0, right: 4),
                                  child: Text(
                                    test ? "N\$ 50.0" : 'Free',
                                    style: TextStyle(
                                        color: !test
                                            ? const Color(0xff00aa00)
                                            : Globals.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  "Marious Mega Shopping Mall, Central Santa Lucia, Deido",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 12, top: 6, bottom: 12, left: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    elevation: 10,
                                    shape: const CircleBorder(),
                                    color: Globals.primaryColor,
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        FontAwesomeIcons.arrowLeftLong,
                                        color: Globals.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 4),
                                    child: Text(
                                      Jiffy.parseFromDateTime(DateTime.now()
                                              .subtract(
                                                  const Duration(days: 65)))
                                          .yMEd
                                          .toString(),
                                      style: const TextStyle(
                                          color: Color(0xffaaaaaa),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      MaterialButton(
                                        elevation: 7,
                                        shape: const CircleBorder(),
                                        color: Globals.white,
                                        onPressed: () {
                                          HapticFeedback.heavyImpact();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Icon(
                                            FontAwesomeIcons.mapPin,
                                            color: Globals.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Visit",
                                        style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
