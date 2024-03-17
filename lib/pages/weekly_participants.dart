import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/current_user.dart';
import 'package:hospital/models/manager.dart';
import 'package:hospital/pages/startup/SignupPage.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:provider/provider.dart';

import '../models/week_data.dart';
import '../providers/data_provider.dart';
import '../widgets/parking_tile.dart';

class WeeklyParticipants extends StatefulWidget {
  const WeeklyParticipants(
      {super.key, required this.weekID, this.roomID = 'room1'});
  final String roomID;
  final String weekID;

  @override
  State<WeeklyParticipants> createState() => _WeeklyParticipantsState();
}

class _WeeklyParticipantsState extends State<WeeklyParticipants> {
  final List<CurrentUser> users = [];

  Future<void> loadUsers() async {
    Future.delayed(Duration.zero, () {
      setState(() {
        loading = true;
      });
    });

    // for (var i = 1; i <= 38; i++) {
    //   debugPrint("Running: $i");
    //   int bonus = Random().nextBool()
    //       ? 3200
    //       : Random().nextBool()
    //           ? 5000
    //           : 2000;
    //   int highest = Random().nextInt(80) + 40;
    //   await firestore
    //       .collection("seasons")
    //       .doc("2024")
    //       .collection("weeks")
    //       .doc("GW$i")
    //       .set({
    //     "highestPoint": highest,
    //     "description":
    //         "This gameweek has teams with double games to play, watchout managers",
    //     "bonus": bonus,
    //   }, SetOptions(merge: true)).then((value) async {
    //     for (int j = 1; j < 7; j++) {
    //       await firestore
    //           .collection("seasons")
    //           .doc("2024")
    //           .collection("weeks")
    //           .doc("GW$i")
    //           .collection("weeklyCompetition")
    //           .doc("room$j")
    //           .set(WeekData(
    //             weekID: '${Random().nextInt(999999999)}',
    //             maxPlayers: Random().nextInt(6000),
    //             isOpen: false,
    //             entryFee: [200, 500, 100, 50, 250, 600][Random().nextInt(5)],
    //             participantsID: [],
    //             completed: false,
    //             registeredPlayers: Random().nextInt(5000),
    //             endsAt: DateTime.now().subtract(const Duration(days: 200)).add(
    //                   Duration(
    //                       days: 7 * i,
    //                       hours: Random().nextInt(24),
    //                       minutes: Random().nextInt(60)),
    //                 ),
    //             description:
    //                 "The highest person of the gameweek wins a LaCost T-Shirt",
    //           ).toMap());
    //     }
    //   });
    // }

    participants.clear();
    userIDs.clear();

    final snap1 = await firestore
        .collection("seasons")
        .doc(Globals.season)
        .collection("weeks")
        .doc(Globals.gameweek)
        .collection(Globals.competitionTitle)
        .doc(widget.roomID)
        .get();

    if (snap1.exists) {
      final data = snap1.data()!;
      weekData = RoomModel.fromMap(data);
      weekData!.weekID = snap1.id;
      debugPrint("Data Exists");
    } else {
      toast(message: "Error loading, Drag to refresh");
    }

    if (weekData!.participantsID.isNotEmpty) {
      try {
        userIDs = weekData!.participantsID;
        final users = await firestore
            .collection("users")
            .where("verified", isEqualTo: true)
            .where("userID", whereIn: userIDs)
            .get();

        debugPrint(" List: $userIDs \n--- ${users.docs.length}");
        for (var item in users.docs) {
          participants.add(Manager.fromMap(item.data()));
        }
      } catch (e) {
        debugPrint("Exception: $e");
        toast(message: "Failed to load players");
      }
    } else {
      toast(message: "Join the room");
    }

    Future.delayed(Duration.zero, () {
      setState(() {
        loading = false;
      });
    });
  }

  bool loading = false;

  List<Manager> participants = [];
  List<String> userIDs = [];

  RoomModel? weekData;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);
    final week = data.getWeek(widget.weekID);
    final managers = participants;

    debugPrint("IDs: $userIDs");

    return Scaffold(
        body: TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 1)),
      duration: Globals.mainDurationLonger,
      builder: (context, value, child) => week == null
          ? const Center(
              child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text("Not Available, please refresh and try again."),
            ))
          : loading
              ? Center(child: placeholder)
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      stretch: true,
                      foregroundColor: Colors.white,
                      expandedHeight: size.height * .225,
                      backgroundColor: Colors.black,
                      elevation: 0,
                      stretchTriggerOffset: size.height * .125,
                      onStretchTrigger: () async {
                        HapticFeedback.heavyImpact();
                        Globals.vibrate();
                        await loadUsers().then((value) {
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              loading = false;
                            });
                          });
                        });
                      },
                      forceElevated: false,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [
                          StretchMode.blurBackground,
                          StretchMode.fadeTitle,
                          StretchMode.zoomBackground
                        ],
                        expandedTitleScale: 1.1,
                        title: Text(
                            "${prettyNumber(participants.length)} Participants playing"),
                        background: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(55.0),
                            child: Text(
                              week.description,
                              style: Globals.whiteText,
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6, right: 8.0),
                          child: auth.currentUser == null
                              ? FloatingActionButton.small(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.orange,
                                  onPressed: () {
                                    Navigator.push(context,
                                        SizeTransition2(const SignupPage()));
                                  },
                                  child: const Icon(FontAwesomeIcons.signIn,
                                      size: 15))
                              : userIDs.contains(auth.currentUser?.uid)
                                  ? DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.check,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  : FloatingActionButton.small(
                                      heroTag: "add_more",
                                      onPressed: () async {
                                        HapticFeedback.heavyImpact();
// xYiOGwmqW0gLlZDvuCua7pkGGSB2
                                        // await firestore
                                        //     .collection("seasons")
                                        //     .doc(data.system.season)
                                        //     .collection("weeks")
                                        //     .doc("GW27")
                                        //     .collection(Globals.competitionTitle)
                                        //     .doc("room1")
                                        //     .update({
                                        //   "participants": FieldValue.arrayUnion(
                                        //       ['7mI9AobcVrZVxKuUWryKjHHttkV2 '])
                                        // });
                                      },
                                      backgroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                      elevation: 0,
                                      child: const Icon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    ),
                        ),
                      ],
                      floating: true,
                      pinned: true,
                    ),
                    SliverList(
                        delegate: managers.isEmpty
                            ? SliverChildListDelegate([
                                SizedBox(
                                  width: size.width,
                                  height: size.height * .75,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Be first to join",
                                        style: Globals.heading,
                                      ),
                                      Text("No manager joined yet"),
                                    ],
                                  ),
                                )
                              ])
                            : SliverChildBuilderDelegate(
                                childCount: managers.length, (context, index) {
                                final manager = managers[index];
                                return PlayerTile(
                                    index: index, manager: manager);
                              }))
                  ],
                ),
    ));
  }
}
