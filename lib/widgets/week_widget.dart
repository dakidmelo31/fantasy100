import 'dart:ui';

import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/week_data.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:provider/provider.dart';

class WeeklyWidget extends StatelessWidget {
  const WeeklyWidget({super.key, required this.weekID});
  final String weekID;

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);

    final week = data.getWeek(weekID);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.fastEaseInToSlowEaseOut,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: week == null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(36)),
                child: SizedBox(
                    height: kToolbarHeight * 2,
                    width: size.width * .95,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                            "Room Not Available, please check that your internet is stable and you're logged in, then drag down to reload"),
                      ),
                    )),
              ),
            )
          : SizedBox(
              height: 280,
              width: size.width,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      children: [
                        Material(
                          shadowColor: Colors.black.withOpacity(.35),
                          elevation: 0,
                          shape: Globals.radius(36),
                          color: Colors.white.withOpacity(.25),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50.0, horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 170,
                                        child: Text(week.description)),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Now Playing",
                                          style: GoogleFonts.jost(
                                              fontSize: 12,
                                              color:
                                                  Colors.black.withOpacity(.3)),
                                        ),
                                        Text(
                                          prettyNumber(week.registeredPlayers),
                                          style: GoogleFonts.damion(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${prettyNumber(week.entryFee)} CFA"),
                                    ],
                                  ),
                                ),
                                AnimatedSwitcher(
                                  duration: Globals.mainDuration,
                                  switchInCurve: Curves.fastEaseInToSlowEaseOut,
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                          scale: animation, child: child),
                                  child: !week.participantsID
                                          .contains(auth.currentUser?.uid)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  week.isOpen
                                                      ? FontAwesomeIcons
                                                          .lockOpen
                                                      : FontAwesomeIcons.lock,
                                                  color: week.isOpen
                                                      ? const Color(0xff00aa00)
                                                      : Globals.pink,
                                                  size: 15,
                                                ),
                                                Text(week.isOpen
                                                    ? "Join Room"
                                                    : "Closed")
                                              ],
                                            ),
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          36)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 28.0,
                                                        vertical: 16),
                                                child: CountDownText(
                                                    due: week.endsAt,
                                                    style: Globals.heading,
                                                    finishedText:
                                                        "GameWeek 35 Completed"),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(prettyNumber(
                                                    week.registeredPlayers *
                                                        week.entryFee)),
                                                Text(" CFA")
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                            )
                                          ],
                                        )
                                      : MaterialButton(
                                          color: Colors.black,
                                          textColor: Colors.white,
                                          shape: Globals.radius(26),
                                          height: 50,
                                          onPressed: () {
                                            HapticFeedback.heavyImpact();
                                            toast(message: "Entering");
                                          },
                                          child:
                                              const Text("Enter the Challenge"),
                                        ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
