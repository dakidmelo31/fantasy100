import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hospital/models/manager.dart';
import 'package:hospital/models/player.dart';

import '../main.dart';
import '../models/current_user.dart';
import '../models/group.dart';
import '../models/overview.dart';
import '../utils/globals.dart';

class DataProvider extends ChangeNotifier {
  final List<Overview> overviews = [];

  List<Group> groups = [];

  List<Manager> managers = [];
  List<Player> players = [];

  DataProvider() {
    loadUser();
    loadOverviews();
    loadGroups();
    loadFantasyGroup();
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
        'https://fantasy.premierleague.com/api/leagues-classic/619605/standings/';
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

  searchManager(int userID) {}
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

  loadUser() async {
    // await firestore.collection('users').doc(auth.currentUser!.uid).delete();
    if (auth.currentUser != null) {
      debugPrint("Can load user");
      final snap =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      if (snap.exists) {
        me = CurrentUser.fromMap(snap.data()!, snap.id);
        toast(message: "I've been loaded");
        notifyListeners();
      } else {
        await auth.signOut();
        toast(message: "Not recognized, Please sign in again");
      }
    } else {
      toast(message: "Signup or Login to continue");
    }
  }

  CurrentUser? me;
}
