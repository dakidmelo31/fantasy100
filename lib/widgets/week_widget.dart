import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/weekly_participants.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
  const Room({super.key, required this.weekID});
  final String weekID;

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);

    final room = data.getWeek(widget.weekID);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.fastEaseInToSlowEaseOut,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: room == null
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
                          child: InkWell(
                            customBorder: Globals.radius(36),
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              Navigator.push(
                                  context,
                                  SizeTransition2(
                                      WeeklyParticipants(weekID: room.weekID)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 50.0, horizontal: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 170,
                                          child: Text(room.description)),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Cash Prize",
                                            style: GoogleFonts.jost(
                                                fontSize: 12,
                                                color: Colors.black
                                                    .withOpacity(.3)),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                prettyNumber(
                                                    room.participantsID.length *
                                                        room.entryFee),
                                                style:
                                                    GoogleFonts.sawarabiGothic(
                                                        fontSize: 26,
                                                        color: room.isOpen
                                                            ? const Color(
                                                                0xff000033)
                                                            : const Color(
                                                                0xff00aa00),
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              Text(
                                                " F",
                                                style: GoogleFonts.poppins(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 20,
                                                    color: Colors.black
                                                        .withOpacity(.9)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Entry fee ",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                            "${prettyNumber(room.entryFee)} CFA"),
                                      ],
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    duration: Globals.mainDuration,
                                    switchInCurve:
                                        Curves.fastEaseInToSlowEaseOut,
                                    transitionBuilder: (child, animation) =>
                                        ScaleTransition(
                                            scale: animation, child: child),
                                    child: room.participantsID
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      room.isOpen
                                                          ? FontAwesomeIcons
                                                              .lockOpen
                                                          : FontAwesomeIcons
                                                              .lock,
                                                      color: room.isOpen
                                                          ? const Color(
                                                              0xff00aa00)
                                                          : Globals.pink,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Text(room.isOpen
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 28.0,
                                                      vertical: 16),
                                                  child: CountDownText(
                                                      due: room.endsAt,
                                                      style: room.endsAt
                                                              .isBefore(DateTime
                                                                  .now())
                                                          ? GoogleFonts
                                                              .poppins()
                                                          : GoogleFonts
                                                              .poppins(),
                                                      finishedText: "Complete"),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                data.me!.photo,
                                                            width: 20,
                                                            height: 20,
                                                            alignment: Alignment
                                                                .center,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(prettyNumber(room
                                                          .participantsID
                                                          .length)),
                                                    ],
                                                  ),
                                                  const Text("Now Playing")
                                                ],
                                              )
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: 28.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  onTap: () {
                                                    showCupertinoDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            CupertinoAlertDialog(
                                                              title: const Text(
                                                                  "Players Protection"),
                                                              content: Text(
                                                                room.info,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                              actions: [
                                                                CupertinoDialogAction(
                                                                  child:
                                                                      const Text(
                                                                          "Okay"),
                                                                  isDefaultAction:
                                                                      true,
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  textStyle: GoogleFonts
                                                                      .poppins(
                                                                          color:
                                                                              Colors.black),
                                                                )
                                                              ],
                                                            ));
                                                  },
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(18.0),
                                                      child: Icon(
                                                        FontAwesomeIcons.info,
                                                        color: Colors.black,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                AnimatedSwitcher(
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  switchInCurve:
                                                      Curves.elasticInOut,
                                                  switchOutCurve: Curves
                                                      .fastEaseInToSlowEaseOut,
                                                  transitionBuilder:
                                                      (child, animation) =>
                                                          ScaleTransition(
                                                    scale: animation,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: FadeTransition(
                                                          opacity: animation,
                                                          child: child),
                                                    ),
                                                  ),
                                                  child: playing
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        36),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          width: 170,
                                                          height: 50,
                                                          child: placeholder,
                                                        )
                                                      : MaterialButton(
                                                          minWidth: 170,
                                                          color: Colors.black,
                                                          textColor:
                                                              Colors.white,
                                                          shape: Globals.radius(
                                                              26),
                                                          height: 50,
                                                          onPressed: () async {
                                                            HapticFeedback
                                                                .heavyImpact();
                                                            bool dontAskAgain =
                                                                true;

                                                            bool? outcome;

                                                            if (!Globals
                                                                .dontAskAgain) {
                                                              outcome =
                                                                  await showCupertinoDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) {
                                                                        return StatefulBuilder(
                                                                          builder: (context, setState) =>
                                                                              CupertinoAlertDialog(
                                                                            title:
                                                                                const Text("Confirm participation"),
                                                                            content:
                                                                                Column(
                                                                              children: [
                                                                                const Text("You can enter as many competitions (rooms) as you like, but you can only receive a prize for winning in one of them. If you win in multiple groups, you'll be awarded the prize from the competition with the highest payout.\n\n"
                                                                                    "This helps spread the wealth and allows more players to win! Joining multiple competitions increases your overall chances of winning a prize."),
                                                                                Material(
                                                                                  elevation: 0,
                                                                                  color: Colors.transparent,
                                                                                  surfaceTintColor: Colors.transparent,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Checkbox(
                                                                                          activeColor: Globals.primaryColor,
                                                                                          value: dontAskAgain,
                                                                                          onChanged: (v) {
                                                                                            setState(() {
                                                                                              dontAskAgain = v!;
                                                                                            });
                                                                                          }),
                                                                                      const Text("Okay don't show this again")
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            actions: [
                                                                              CupertinoDialogAction(
                                                                                child: const Text(
                                                                                  "Enter",
                                                                                  style: Globals.primaryText,
                                                                                ),
                                                                                isDefaultAction: true,
                                                                                onPressed: () {
                                                                                  Navigator.pop(context, true);
                                                                                },
                                                                              ),
                                                                              CupertinoDialogAction(
                                                                                child: const Text(
                                                                                  "Cancel",
                                                                                  style: TextStyle(color: Colors.black),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context, false);
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }).then((value) async {
                                                                Globals.flipSettings(
                                                                    field:
                                                                        "dontAskAgain");
                                                                if (!Globals
                                                                        .dontAskAgain &&
                                                                    dontAskAgain) {
                                                                  Globals.dontAskAgain =
                                                                      dontAskAgain;
                                                                }
                                                              });
                                                            }

                                                            if (Globals.dontAskAgain ==
                                                                    false &&
                                                                outcome !=
                                                                    true) {
                                                              return;
                                                            }

                                                            setState(() {
                                                              playing = true;
                                                            });

                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds:
                                                                        1));
                                                            await data
                                                                .enterRoom(room
                                                                    .weekID);
                                                            setState(() {
                                                              playing = false;
                                                            });
                                                          },
                                                          child: const Text(
                                                              "Enter the Challenge"),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  )
                                ],
                              ),
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
