import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/week_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WeeklyCompetition extends StatefulWidget {
  const WeeklyCompetition({super.key});

  @override
  State<WeeklyCompetition> createState() => _WeeklyCompetitionState();
}

class _WeeklyCompetitionState extends State<WeeklyCompetition> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);
    final weeklyCompetition = data.weeklyCompetition;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        body: Stack(
          children: [
            if (false)
              Image.asset("assets/4.jpg",
                  fit: BoxFit.cover, width: size.width, height: size.height),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: SizedBox(
                width: size.width,
                height: size.height,
              ),
            ),
            Opacity(
              opacity: .6,
              child: Lottie.asset("$dir/bg2.json",
                  fit: BoxFit.cover, width: size.width, height: size.height),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    onStretchTrigger: () async {
                      debugPrint("UserID: ${auth.currentUser?.uid}");
                      Future.delayed(Duration.zero, () async {
                        await data.refreshGameweek();
                        Globals.vibrate();

                        toast(message: "Gameweek Data Updated");
                        setState(() {});
                      });
                      HapticFeedback.heavyImpact();
                    },
                    stretchTriggerOffset: 150,
                    pinned: true,
                    floating: true,
                    snap: false,
                    title: Card(
                        surfaceTintColor: Colors.transparent,
                        color: Colors.black.withOpacity(.0),
                        elevation: 0,
                        shape: Globals.radius(36),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(
                              "GameWeek 32",
                              style: Globals.heading,
                            )),
                          ),
                        )),
                    expandedHeight: size.height * .55,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          const Spacer(),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: kToolbarHeight),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "95",
                                  style: GoogleFonts.cabin(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  " Pts",
                                  style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      color: Colors.black.withOpacity(.25),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 26, right: 8.0),
                                  child: FloatingActionButton.small(
                                    heroTag: "add_more",
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.push(context,
                                          SizeTransition22(const TopUp()));
                                    },
                                    backgroundColor: Colors.black,
                                    shape: const CircleBorder(),
                                    elevation: 0,
                                    child: const Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        strokeAlign: 1,
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Invite Friends"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        strokeAlign: 1,
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Create Room"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8.0),
                                  child: FloatingActionButton.small(
                                    heroTag: "add_more2",
                                    onPressed: () {},
                                    backgroundColor: Colors.transparent,
                                    shape: const CircleBorder(),
                                    elevation: 0,
                                    child: const Icon(
                                      FontAwesomeIcons.info,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Weekly Competition",
                              style: GoogleFonts.righteous(
                                  fontSize: 60, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * .75,
                                    child: const Text(
                                        "You are free to join any group. The rule is simple: Winner takes all"),
                                  ),
                                  InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: () {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (_) {
                                            return CupertinoAlertDialog(
                                              title:
                                                  const Text("Fair Play Rules"),
                                              content: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(
                                                    "The The main purpose of the multiple game rooms feature is to give every manager a shot at winning during a gameweek. This means you are free to take part in one or all, but you may not win in more than one.\n",
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SelectableText(
                                                    "In an event you score the highest point across multiple groups, we will credit you with the highest amount won, and the winnings of the other rooms you are topping will trickle down to the next best manager.\nHowever we will also give you a winning bonus and a manager gift for acknowledgement of your managerial briliance",
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SelectableText(
                                                    "\nNote that in this event the subsequent winner in the room forfeited will be the closest manager without a win for the gameweek in question.",
                                                    textAlign: TextAlign.left,
                                                  )
                                                ],
                                              ),
                                              actions: [
                                                CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Okay",
                                                    style: Globals.title,
                                                  ),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(FontAwesomeIcons.info),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      collapseMode: CollapseMode.parallax,
                      stretchModes: const [
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
                        StretchMode.zoomBackground
                      ],
                    ),
                    automaticallyImplyLeading: false,
                    foregroundColor: Colors.black,
                    forceElevated: false,
                    scrolledUnderElevation: 0,
                    stretch: true,
                    forceMaterialTransparency: true,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Other Sweet Game Plans",
                        style: Globals.heading,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                          "No Room available at the moment, refresh or come back later to check"),
                    ),
                    ListView.builder(
                      itemCount: data.weeklyCompetition.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => WeeklyWidget(
                          weekID: data.weeklyCompetition[index].weekID),
                    )
                  ]))
                ],
                physics: const BouncingScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
