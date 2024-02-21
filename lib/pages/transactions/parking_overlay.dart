import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/models/manager.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class ManagerOverlay extends StatelessWidget {
  ManagerOverlay({super.key, required this.index});
  final int index;
  late bool test = index % 3 == 0;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: false);
    final Manager manager = data.getManager(index);
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: "$index",
                child: SizedBox(
                  height: 370,
                  width: size.width * .95,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          surfaceTintColor: Globals.primaryColor,
                          elevation: 15,
                          shadowColor: Globals.black.withOpacity(.1),
                          child: InkWell(
                            customBorder: Globals.radius(10),
                            onTap: () {
                              HapticFeedback.heavyImpact();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Team Name",
                                        style: Globals.subtitle,
                                      ),
                                      Text(
                                        "Mr Melo FC",
                                        style: Globals.title,
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Username",
                                        style: Globals.subtitle,
                                      ),
                                      Text(
                                        "Ndoye Philip Ndula",
                                        style: Globals.title,
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Current Ranking",
                                        style: Globals.subtitle,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "#",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Globals.black,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            " 205",
                                            style: Globals.title,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "GW 25 Points",
                                        style: Globals.subtitle,
                                      ),
                                      Text(
                                        "65",
                                        style: Globals.heading,
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.zero,
                                    topRight: Radius.zero,
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  margin: EdgeInsets.zero,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * .55,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                manager.verified
                                                    ? "FPL team Verified"
                                                    : "FPL team not verified",
                                                style: Globals.title,
                                              ),
                                            ],
                                          ),
                                        ),
                                        CupertinoSwitch(
                                          value: true,
                                          activeColor: const Color(0xff00aa00),
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 45.0, horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: () => Navigator.pop(context),
                      heroTag: "backbutton",
                      backgroundColor: Globals.black,
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Icon(FontAwesomeIcons.arrowLeftLong),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      heroTag: "flagButton",
                      elevation: 0,
                      backgroundColor: Globals.transparent,
                      foregroundColor: Globals.primaryColor,
                      shape: const CircleBorder(),
                      child: const Icon(FontAwesomeIcons.flag),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
