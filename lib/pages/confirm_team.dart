import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ConfirmTeam extends StatefulWidget {
  const ConfirmTeam({super.key, required this.teamID});
  final int teamID;

  @override
  State<ConfirmTeam> createState() => _ConfirmTeamState();
}

class _ConfirmTeamState extends State<ConfirmTeam> {
  bool refreshing = false, confirming = false;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: true);
    // final result = ;
    final size = getSize(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        data.foundTeam = null;
      },
      child: Scaffold(
          backgroundColor: Globals.white,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Not Seeing your team?"),
                        content: const Column(
                          children: [
                            Text(
                                "If you are not getting a team on this page even after correctly enterring your team code then get help from us")
                          ],
                        ),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              toast(message: "launching whatsapp");
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              FontAwesomeIcons.whatsapp,
                              color: Color(0xff00aa00),
                            ),
                          ),
                          CupertinoDialogAction(
                            isDefaultAction: false,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: Globals.greySubtitle,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.circleInfo)),
              const SizedBox(width: 10)
            ],
            elevation: 0,
            surfaceTintColor: Colors.white,
            foregroundColor: Globals.black,
            backgroundColor: Globals.white,
            title: Text("Checking ${widget.teamID}"),
            forceMaterialTransparency: false,
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollNotification &&
                  notification.metrics.extentBefore == 0) {
                HapticFeedback.heavyImpact();
                if (!refreshing) {
                  setState(() {
                    refreshing = true;
                  });
                  toast(message: "Checking again");
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      data.searchManager(widget.teamID);
                      Future.delayed(Duration(seconds: 4), () {
                        setState(() {
                          refreshing = false;
                        });
                      });
                    }
                  });
                }
              }
              return false;
            },
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                SizedBox(
                  height: size.height - kToolbarHeight * 2,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "This is what we found",
                          style: Globals.greySubtitle,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Globals.mainDuration,
                        switchInCurve: Curves.fastEaseInToSlowEaseOut,
                        switchOutCurve: Curves.fastLinearToSlowEaseIn,
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: data.foundTeam == null
                            ? data.failed
                                ? const Text("Failed to get user")
                                : placeholder
                            : confirming
                                ? Lottie.asset(
                                    "$dir/misc10.json",
                                    width: 170,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    repeat: true,
                                    reverse: true,
                                    filterQuality: FilterQuality.high,
                                    options:
                                        LottieOptions(enableMergePaths: true),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      surfaceTintColor: Globals.primaryColor,
                                      elevation: 15,
                                      shadowColor:
                                          Globals.black.withOpacity(.1),
                                      child: InkWell(
                                        customBorder: Globals.radius(10),
                                        onTap: () {
                                          HapticFeedback.heavyImpact();
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Team Name",
                                                    style: Globals.subtitle,
                                                  ),
                                                  Text(
                                                    data.foundTeam!.teamName,
                                                    style: Globals.title,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Username",
                                                    style: Globals.subtitle,
                                                  ),
                                                  Text(
                                                    data.foundTeam!.username,
                                                    style: Globals.title,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Current Ranking",
                                                    style: Globals.subtitle,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "#",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Globals.black,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        " " +
                                                            prettyNumber(data
                                                                .foundTeam!
                                                                .rank),
                                                        style: Globals.title,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "GW 25 Points",
                                                    style: Globals.subtitle,
                                                  ),
                                                  Text(
                                                    prettyNumber(
                                                        data.foundTeam!.score),
                                                    style: Globals.heading,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Card(
                                              elevation: 0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                topLeft: Radius.zero,
                                                topRight: Radius.zero,
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )),
                                              color: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              margin: EdgeInsets.zero,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * .55,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          data.foundTeam!
                                                                  .verified
                                                              ? const Text(
                                                                  "Team already Claimed",
                                                                  style: Globals
                                                                      .title,
                                                                )
                                                              : const Text(
                                                                  "Claim your team",
                                                                  style: Globals
                                                                      .primaryTitle,
                                                                ),
                                                          const Text(
                                                            "Choose verify team",
                                                            style: Globals
                                                                .greySubtitle,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    CupertinoSwitch(
                                                      value: data
                                                          .foundTeam!.verified,
                                                      activeColor: const Color(
                                                          0xff00aa00),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 48.0),
                        child: Hero(
                          tag: "userFloatingButton",
                          child: MaterialButton(
                            color: Globals.black,
                            shape: Globals.radius(10),
                            elevation: 0,
                            textColor: Globals.white,
                            onPressed: () async {
                              toast(message: "confirmed");
                              setState(() {
                                confirming = true;
                              });

                              firestore
                                  .collection("users")
                                  .doc(auth.currentUser!.uid)
                                  .set(data.foundTeam!.toMap(),
                                      SetOptions(merge: true));

                              // // data.searchManager(widget.teamID);
                              // data.searchManager(8513103);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child:
                                  Text("Yes, I confirm that this is my Team"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
