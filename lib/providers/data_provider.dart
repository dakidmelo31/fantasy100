import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital/models/manager.dart';
import 'package:hospital/models/player.dart';
import 'package:hospital/models/system_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/cash_model.dart';
import '../models/current_user.dart';
import '../models/group.dart';
import '../models/overview.dart';
import '../models/week_data.dart';
import '../utils/globals.dart';

class DataProvider extends ChangeNotifier {
  final List<Overview> overviews = [];

  List<Group> groups = [];

  List<Manager> managers = [];
  List<Player> players = [];

  bool failed = false;

  List<CashModel> transactions = [];

  List<RoomModel> weeklyCompetition = [];

  Future<void> refreshGameweek() async {
    weeklyCompetition.clear();

    final snap = await firestore
        .collection("seasons")
        .doc(Globals.season)
        .collection("weeks")
        .doc(Globals.gameweek)
        .collection(Globals.competitionTitle)
        .get();

    if (snap.docs.isEmpty) {
      debugPrint("((((( Season is Empty )))))");
      toast(message: "Season is Empty");
    } else {
      debugPrint("((((( * Weeks: ${snap.docs.length} * )))))");
      toast(message: "Season is Weeks: ${snap.docs.length}");
    }
    for (var item in snap.docs) {
      // await firestore
      //     .collection("seasons")
      //     .doc(Globals.season)
      //     .collection("weeks")
      //     .doc(Globals.gameweek)
      //     .collection(Globals.competitionTitle)
      //     .doc(item.id)
      //     .update({
      //   "info":
      //       "To encourage ongoing participation and fair play, the winner of each GameWeek will be required to participate in 10 additional rounds. This means their winnings will be credited as usual, but they will be automatically enrolled in the next 10 GameWeeks."
      //   // "endsAt": DateTime.now().add(Duration(days: 9)).millisecondsSinceEpoch
      // });

      final week = RoomModel.fromMap(item.data());
      week.weekID = item.id;

      weeklyCompetition.add(week);
    }
    // toast(message: "done loading");
    for (var e in weeklyCompetition) {
      debugPrint(e.registeredPlayers.toString());
    }
    notifyListeners();
  }

  Future<void> loadTransactions() async {
    if (auth.currentUser == null) {
      return;
    }
    //debugPrint(auth.currentUser!.uid);
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("cashHistory")
        .snapshots()
        .listen((event) {
      transactions.clear();
      debugPrint("Loading CashHistory*******************");
      if (event.docs.isNotEmpty) {
        //debugPrint(
        //     "transactions *********************************** ${event.docs.length}");
        for (var item in event.docs) {
          // //debugPrint(item.id.toString());
          late final cash;
          try {
            cash = CashModel.fromMap(item.data(), item.id);
            transactions.add(cash);
          } catch (e) {
            debugPrint("Cash failed: $e");
          }
          // //debugPrint(cash.toString());
          // //debugPrint(transactions.length.toString());
        }
      } else {
        //debugPrint("No transactions ***********************************");
      }
      notifyListeners();
    });
  }

  DataProvider() {
    init();
  }
  init() async {
    await loadSystem();
    await loadUser();
    await loadOverviews();
    await loadGroups();
    await loadFantasyGroup();
    await loadTransactions();
    await check();
  }

  Future<void> check() async {
    // await firestore.collection("system").doc("information").set({
    //   "finale": DateTime.now().add(Duration(days: 120)).millisecondsSinceEpoch
    // }).then((value) => toast(message: "Updating system"));
    if (Globals.finale.isBefore(DateTime.now())) {
      firestore
          .collection("system")
          .doc("information")
          .get()
          .then((value) async {
        final prefs = await SharedPreferences.getInstance();
        if (value.exists) {
          prefs.setInt("finale", value.data()!['finale']);
          Globals.finale =
              DateTime.fromMillisecondsSinceEpoch(value.data()!['finale']);

          debugPrint("Just updating now");
          notifyListeners();
        }
        // else {
        //   firestore.collection("system").doc("information").set({
        //     "finale": DateTime.now()
        //         .add(const Duration(days: 96))
        //         .millisecondsSinceEpoch
        //   });
        // }
      });
    }
  }

  Future<void> loadChats(String overviewID) async {
    // firestore
    //     .collection("overviews")
    //     .doc(overviewID)
    //     .collection("message")
    //     .orderBy("sentAt", descending: true);
  }

  Future<void> updatingGroups() async {
    await firestore.collection("groups").get().then((value) async {
      for (var item in value.docs) {
        await firestore
            .collection("groups")
            .doc(item.id)
            .set({"playersID": []}, SetOptions(merge: true));
      }
    });
  }

  Future<void> loadOverviews() async {
    int count = 0;
    // if (false)
    // for (var element in dummyGroups) {
    //   ++count;
    //   debugPrint("Counts: $count");
    //   await firestore.collection("groups").add(element);
    // }

    // firestore
    //     .collection("overviews")
    //     .where("participants", arrayContains: auth.currentUser!.uid)
    //     .snapshots()
    //     .listen((event) {
    //   notifyListeners();
    // });
  }

  Future<void> loadGroups() async {
    firestore.collection("groups").snapshots().listen((event) {
      for (var item in event.docs) {
        if (item.exists) {
          groups.add(Group.fromMap(item.data(), item.id));
        }
      }

      notifyListeners();
    });
  }

  int currentPage = 1;
  String currentGameWeek = 'GW 30';
  bool isComplete = false;

  bool hasNext = false;
  bool loadingManagers = false;
  Future<bool> loadFantasyGroup({bool more = false}) async {
    loadingManagers = true;
    var dio = Dio();
    String requestUrl =
        'https://fantasy.premierleague.com/api/leagues-classic/${Globals.classicLeague}/standings/';
    // 'https://fantasy.premierleague.com/api/leagues-classic/1942089/standings/';
    if (hasNext) {
      currentPage += 1;
      requestUrl += "?page_standings=$currentPage";
    }
    var response = await dio.request(
      requestUrl,
      options: Options(
        method: 'GET',
      ),
    );

    if (more && !hasNext) {
      toast(message: "You've reached the end");
      loadingManagers = false;
      notifyListeners();
    } else if (response.statusCode == 200) {
      // debugPrint(json.encode(response.data));
      currentPage = response.data['standings']['page'];
      hasNext = response.data['standings']['has_next'];
      List<dynamic> league = response.data['standings']['results'];
      for (var item in league) {
        final player = Manager(
            id: item['id'],
            teamName: item['entry_name'],
            score: item['event_total'],
            image:
                'https://firebasestorage.googleapis.com/v0/b/fantasy100.appspot.com/o/male.jpg?alt=media&token=c05f83d4-b3d3-4930-9c94-6ef6220698d1',
            lastRank: item['last_rank'],
            rank: item['rank'],
            total: item['total'],
            username: item['player_name'],
            rankSort: item['rank_sort'],
            entry: item['entry']);
        managers.add(player);
      }
      loadingManagers = false;
      notifyListeners();

      return true;
    } else {
      print(response.statusMessage);
    }
    return false;
  }

  Group getGroup(String groupId) {
    return groups.firstWhere((element) => element.groupID == groupId);
  }

  Manager? foundTeam;
  searchManager(int userID) async {
    debugPrint("userID: $userID");
    failed = false;
    var dio = Dio();
    String requestUrl = 'https://fantasy.premierleague.com/api/entry/$userID/';
    debugPrint(requestUrl);
    var response = await dio.request(
      requestUrl,
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      // debugPrint(response.data.toString());
      final data = response.data;
      final leagues =
          List<Map<String, dynamic>>.from(data['leagues']['classic']);
      Map<String, dynamic>? league;
      for (Map<String, dynamic> item in leagues) {
        if (item['id'] == Globals.classicLeague) {
          // toast(message: "Found Group");
          league = item;
        }
      }
      final snap = await firestore
          .collection("users")
          .where("teamID", isEqualTo: data['id'])
          .get();
      bool isVerified = snap.docs.isNotEmpty;
      debugPrint(snap.docs.length.toString());
      foundTeam = Manager(
        phone: !isVerified ? "" : snap.docs.first.data()['phone'],
        image: !isVerified
            ? Globals.photoPlaceholder
            : snap.docs.first.data()['photo'],
        id: data['id'],
        teamName: data['name'],
        score: data['summary_event_points'],
        lastRank: league != null ? league['entry_last_rank'] : 0,
        rank: league != null ? league['entry_rank'] : 0,
        total: data['summary_overall_points'],
        username: data['player_first_name'] + " " + data['player_last_name'],
        rankSort: data['summary_overall_rank'],
        entry: data['id'],
        isWaiting: false,
        verified: isVerified,
      );
      notifyListeners();
    } else {
      failed = true;
      notifyListeners();
    }
  }

  bool showLoader = false;
  void loadScreen() {
    showLoader = true;
    notifyListeners();
  }

  void hideLoadScreen() {
    showLoader = false;
    notifyListeners();
  }

  void play(Group card) {
    Future.delayed(const Duration(seconds: 5), () {
      showLoader = false;
      notifyListeners();
    });
  }

  getManager(int index) {
    return managers[index];
  }

  late final SystemData system;

  Future<void> loadSystem() async {
    // await firestore.collection("systemData").doc("info").set({
    //   "endsAt": DateTime.now()
    //       .add(const Duration(days: 6, minutes: 28))
    //       .millisecondsSinceEpoch,
    //   "currentGameweek": "GW27",
    //   "season": "2024",
    //   "gameweekTitle": "Gameweek 27",
    //   "ended": false,
    //   "winBonus": 2000
    // });
    await firestore.collection("systemData").doc("info").get().then((value) {
      if (value.exists) {
        final data = value.data()!;
        system = SystemData(
            currentGameweek: data['currentGameweek'],
            highest: data['highest'],
            endsAt: DateTime.fromMillisecondsSinceEpoch(data['endsAt']),
            season: data['season'],
            ended: data['ended'],
            winBonus: data['winBonus'],
            gameweekTitle: data['gameweekTitle']);

        Globals.season = system.season;
        Globals.gameweek = system.currentGameweek;
      }
    }).then((value) async {
      await refreshGameweek();
    });
  }

  loadUser() async {
    // await firestore.collection('users').doc(auth.currentUser!.uid).delete();
    if (auth.currentUser != null) {
      debugPrint("Can load user");
      firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .snapshots()
          .listen((snap) async {
        if (snap.exists) {
          me = CurrentUser.fromMap(snap.data()!, snap.id);

          if (me!.teamID > 0) {
            debugPrint("teamID: ${me!.teamID}");

            await searchManager(me!.teamID);
            if (foundTeam != null) {
              me!.score = foundTeam!.score;
              me!.rank = foundTeam!.rank;
              me!.lastRank = foundTeam!.lastRank;
              me!.total = foundTeam!.total;
            }
          }
          // toast(message: "I've been loaded");

          notifyListeners();
        } else {
          await auth.signOut();
          toast(message: "Not recognized, Please sign in again");
        }
      });
    } else {
      toast(message: "Signup or Login to continue");
    }
  }

  joinJackpot() async {
    showLoader = true;
    notifyListeners();

    if (me!.balance > 2000) {
      await firestore.collection("jackpot").doc(auth.currentUser!.uid).set({
        "photo": me!.photo,
        "phone": me!.phone,
        "teamID": me!.teamID,
        "paid": true,
      }, SetOptions(merge: true));
    } else {
      await Future.delayed(const Duration(seconds: 2));
      toast(message: "Insufficient account balance");
    }

    showLoader = false;
    notifyListeners();
  }

  CurrentUser? me;

  RoomModel? getWeek(String weekID) {
    List<RoomModel?> data = [...weeklyCompetition];
    return data.firstWhere((element) => element!.weekID == weekID,
        orElse: () => null);
  }

  enterRoom(String weekID) async {
    debugPrint("Now working in Room");
    final room = weeklyCompetition.firstWhere((e) => e.weekID == weekID);
    debugPrint("Room: $room");
    debugPrint("Me: $me");
    if (me != null) {
      if (me!.balance < room.entryFee) {
        toast(
            length: Toast.LENGTH_LONG,
            message:
                "You don't have enough funds to join yet. You need ${prettyNumber(room.entryFee)} CFA to participate");
        return;
      }
      debugPrint("WEEK ID: $weekID");

      if (weeklyCompetition[weeklyCompetition
              .indexWhere((element) => element.weekID == weekID)]
          .participantsID
          .contains(auth.currentUser!.uid)) {
        debugPrint("Not Entering room");
        toast(message: "You already Joined");
        return;
      }
      debugPrint("Now adding to Room");

      final DocumentReference documentReference = firestore
          .collection("seasons")
          .doc(Globals.season)
          .collection("weeks")
          .doc(Globals.gameweek)
          .collection(Globals.competitionTitle)
          .doc(weekID);
      await firestore.runTransaction((transaction) async {
        final snap = await transaction.get(documentReference);
        if (!snap.exists) {
          toast(message: "Room does not exist, try again");
          return;
        }
        transaction.update(documentReference, {
          "participantsID": FieldValue.arrayUnion([auth.currentUser!.uid])
        });
      }).then((value) async {
        DocumentReference documentReference =
            firestore.collection("users").doc(auth.currentUser!.uid);
        await firestore.runTransaction((transaction) async {
          final snap = await transaction.get(documentReference);
          if (!snap.exists) {
            toast(message: "Room does not exist, try again");
            return;
          }
          transaction.update(documentReference,
              {"balance": FieldValue.increment(-room.entryFee)});
        }).then((value) {
          // toast(message: "Joined Successfully");
          weeklyCompetition[weeklyCompetition
                  .indexWhere((element) => element.weekID == weekID)]
              .participantsID
              .add(auth.currentUser!.uid);
          final transactionID = const Uuid().v4();
          final cash = CashModel(
              agent: "${room.weekID} Entry Fee",
              status: "COMPLETE",
              amount: room.entryFee,
              date: DateTime.now().toString(),
              deposit: true,
              transactionId: transactionID,
              sent: true,
              createdAt: DateTime.now(),
              image: Globals.photoPlaceholder);
          firestore
              .collection("users")
              .doc(auth.currentUser!.uid)
              .collection("cashHistory")
              .doc(transactionID)
              .set(cash.toMap())
              .then((value) {
            Globals.localNotification(
                title: "You joined successfully",
                body: room.description,
                image: Globals.photoPlaceholder);
            toast(message: "Joined successfully");
          });
          notifyListeners();
        });
      });
    }
  }
}
