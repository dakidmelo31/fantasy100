import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmTeam extends StatefulWidget {
  const ConfirmTeam({super.key, required this.teamID});
  final int teamID;

  @override
  State<ConfirmTeam> createState() => _ConfirmTeamState();
}

class _ConfirmTeamState extends State<ConfirmTeam> {
  bool refreshing = false, confirming = false, confirmed = false;
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
                              Navigator.pop(context, true);
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
                    ).then((value) async {
                      if (value == true) {
                        launchWhatsApp(
                            phoneNumber: "+237650981130",
                            message:
                                "Hi, I can't find my team from your app ( ${Globals.appName})");
                      }
                    });
                  },
                  icon: const Icon(FontAwesomeIcons.circleInfo)),
              const SizedBox(width: 10)
            ],
            elevation: 0,
            surfaceTintColor: Colors.white,
            foregroundColor: Globals.primaryBackground,
            backgroundColor: Globals.white,
            title: Row(
              children: [
                const Text("Looking up  "),
                Text(
                  "${widget.teamID}",
                  style: Globals.heading,
                ),
              ],
            ),
            forceMaterialTransparency: false,
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // debugPrint("Interest: " + notification.metrics.pixels.toString());
              // debugPrint(
              //     "Total: " + notification.metrics.extentTotal.toString());
              if (!confirmed &&
                  !confirming &&
                  notification.metrics.pixels < -100) {
                HapticFeedback.heavyImpact();

                if (!refreshing) {
                  setState(() {
                    refreshing = true;
                  });
                  toast(message: "Checking again");
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      data.foundTeam = null;

                      data.searchManager(widget.teamID);
                      Future.delayed(const Duration(seconds: 4), () {
                        if (mounted) {}
                      });
                      setState(() {
                        refreshing = false;
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
                        child: refreshing || data.foundTeam == null
                            ? data.failed
                                ? const Text("Failed to get user")
                                : placeholder
                            : confirming
                                ? placeholder
                                : confirmed
                                    ? Lottie.asset(
                                        "$dir/misc10.json",
                                        width: 170,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        repeat: true,
                                        filterQuality: FilterQuality.high,
                                        options: LottieOptions(
                                            enableMergePaths: true),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          surfaceTintColor:
                                              Globals.primaryColor,
                                          elevation: 15,
                                          shadowColor: Globals.primaryBackground
                                              .withOpacity(.1),
                                          child: InkWell(
                                            customBorder: Globals.radius(10),
                                            onTap: () {
                                              HapticFeedback.heavyImpact();
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
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
                                                        data.foundTeam!
                                                            .teamName,
                                                        style: Globals.title,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
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
                                                        data.foundTeam!
                                                            .username,
                                                        style: Globals.title,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
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
                                                                    FontWeight
                                                                        .w900,
                                                                color: Globals
                                                                    .primaryBackground,
                                                                fontSize: 20),
                                                          ),
                                                          Text(
                                                            " ${prettyNumber(data.foundTeam!.rank)}",
                                                            style:
                                                                Globals.title,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
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
                                                        prettyNumber(data
                                                            .foundTeam!.score),
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
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                                  color: Colors.white,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  margin: EdgeInsets.zero,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width * .55,
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
                                                        Icon(
                                                            data.foundTeam!
                                                                    .verified
                                                                ? FontAwesomeIcons
                                                                    .lock
                                                                : FontAwesomeIcons
                                                                    .lockOpen,
                                                            color: data
                                                                    .foundTeam!
                                                                    .verified
                                                                ? Globals.pink
                                                                : const Color(
                                                                    0xff00aa00)),
                                                        if (false)
                                                          CupertinoSwitch(
                                                            value: data
                                                                .foundTeam!
                                                                .verified,
                                                            activeColor:
                                                                const Color(
                                                                    0xff00aa00),
                                                            onChanged:
                                                                (value) {},
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
                      if (data.foundTeam == null)
                        const Text("")
                      else
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48.0),
                          child: Hero(
                            tag: "userFloatingButton",
                            child: MaterialButton(
                              color: data.foundTeam!.verified
                                  ? Globals.white
                                  : Globals.primaryBackground,
                              shape: Globals.radius(10),
                              elevation: data.foundTeam!.verified ? 10 : 0,
                              textColor: data.foundTeam!.verified
                                  ? Globals.primaryBackground
                                  : Globals.white,
                              onPressed: () async {
                                if (data.foundTeam!.verified) {
                                  String number =
                                      data.foundTeam!.phone.split("+")[1];
                                  debugPrint(number);
                                  bool? outcome = await showCupertinoDialog(
                                      context: context,
                                      builder: (_) {
                                        return CupertinoAlertDialog(
                                            content: const SelectableText(
                                              "In case you mistakenly type in the wrong number you might end up bumping into another user's management team which would only lead to confusion. \nWith This in min you need to be sure it's your team before raising disputes",
                                              textAlign: TextAlign.left,
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                textStyle: Globals.primaryText,
                                                child: const Text("I am Sure"),
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                isDefaultAction: false,
                                                isDestructiveAction: true,
                                                child: const Text("Nevermind"),
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                              ),
                                            ],
                                            title: const Text("Are you sure"));
                                      });

                                  if (outcome == true) {
                                    toast(
                                        message:
                                            "Okay we'll look into it asap");

                                    firestore.collection("disputes").add({
                                      "username": data.me!.username,
                                      "phone": data.me!.phone,
                                      "photo": data.me!.photo,
                                      "filerID": auth.currentUser!.uid,
                                      "team": data.foundTeam!.toMap(),
                                      "resolved": false
                                    });

                                    launchWhatsApp(
                                        phoneNumber: number,
                                        message:
                                            "Hey, I see you have my team in ${Globals.appName}: *${data.foundTeam!.teamName}*");
                                  }
                                  return;
                                }
                                setState(() {
                                  confirming = true;
                                });

                                firestore
                                    .collection("users")
                                    .doc(auth.currentUser!.uid)
                                    .set(data.foundTeam!.toMap(),
                                        SetOptions(merge: true))
                                    .then((value) {
                                  if (mounted) {
                                    setState(() {
                                      confirming = false;
                                      confirmed = true;
                                    });
                                  }
                                });
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool("verified", true);

                                // // data.searchManager(widget.teamID);
                                // data.searchManager(8513103);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.whatsapp,
                                        color: Color(0xff00aa00)),
                                    const SizedBox(
                                      width: 26,
                                    ),
                                    Text(data.foundTeam!.verified
                                        ? "Submit Dispute"
                                        : "Yes, I confirm that this is my Team"),
                                  ],
                                ),
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
