import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/models/current_user.dart';
import 'package:hospital/utils/globals.dart';
import 'package:provider/provider.dart';

import '../models/week_data.dart';
import '../providers/data_provider.dart';

class WeeklyParticipants extends StatefulWidget {
  const WeeklyParticipants({super.key, required this.weekID});
  final String weekID;

  @override
  State<WeeklyParticipants> createState() => _WeeklyParticipantsState();
}

class _WeeklyParticipantsState extends State<WeeklyParticipants> {
  final List<CurrentUser> users = [];

  Future<void> loadUsers() async {
    setState(() {
      loading = true;
    });
    for (var i = 1; i <= 38; i++) {
      await firestore.collection("weeks").doc("GW${i}").set({
        "highestPoint": Random().nextInt(80) + 50,
        "description":
            "This gameweek has teams with double games to play, watchout managers",
        "bonus": Random().nextBool()
            ? 3200
            : Random().nextBool()
                ? 5000
                : 2000,
      }).then((value) async {
        for (int j = 1; j < 7; j++) {
          await firestore
              .collection("weeks")
              .doc("GW${i}")
              .collection("weeklyCompetition")
              .doc("room${j}")
              .set(WeekData(
                weekID: '${Random().nextInt(999999999)}',
                maxPlayers: Random().nextInt(6000),
                isOpen: false,
                entryFee: [200, 500, 100, 50, 250, 600][Random().nextInt(5)],
                participantsID: [],
                completed: false,
                registeredPlayers: Random().nextInt(5000),
                endsAt: DateTime.now().subtract(const Duration(days: 200)).add(
                      Duration(
                          days: 7 * i,
                          hours: Random().nextInt(24),
                          minutes: Random().nextInt(60)),
                    ),
                description:
                    "The highest person of the gameweek wins a LaCost T-Shirt",
              ).toMap());
        }
      });
    }
    final snap1 = await firestore.collection("weeks").doc(widget.weekID).get();
    final snap2 = await firestore
        .collection("weeks")
        .doc(widget.weekID)
        .collection("weeklyCompetition")
        .doc(widget.weekID)
        .get();

    if (snap1.exists) {
      final data = snap1.data()!;
      week = Week.fromMap(data);

      if (snap2.exists) {
        final data = snap2.data()!;
        weekData = WeekData.fromMap(data);
        weekData!.weekID = snap2.id;
      }
    }
    final _users = await firestore
        .collection("users")
        .where("data", whereIn: weekData!.participantsID)
        .get();

    for (var item in _users.docs) {
      participants.add(CurrentUser.fromMap(item.data(), item.id));
    }

    setState(() {
      loading = true;
    });
  }

  bool loading = false;

  List<CurrentUser> participants = [];

  WeekData? weekData;
  Week? week;

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);
    final week = data.getWeek(widget.weekID);
    return Scaffold(
      body: week == null
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Not Available, please refresh and try again."),
            ))
          : CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  foregroundColor: Colors.white,
                  expandedHeight: size.height * .15,
                  backgroundColor: Colors.black,
                  elevation: 0,
                  forceElevated: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Participant Lists"),
                    background: Center(
                      child: Text(
                        week.description,
                        style: Globals.whiteText,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6, right: 8.0),
                      child: FloatingActionButton.small(
                        heroTag: "add_more",
                        onPressed: () {
                          HapticFeedback.heavyImpact();
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
                    delegate: SliverChildBuilderDelegate(
                        childCount: 60,
                        (context, index) => Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("See this details through"),
                            )))
              ],
            ),
    );
  }
}
