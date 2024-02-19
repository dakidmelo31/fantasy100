import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/group.dart';
import '../models/overview.dart';
import '../utils/globals.dart';

class DataProvider extends ChangeNotifier {
  final List<Overview> overviews = [];

  List<Group> groups = [];

  DataProvider() {
    loadOverviews();
    loadGroups();
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

  Future<bool> loadFantasyGroup() async {
    var dio = Dio();
    var response = await dio.request(
      'https://fantasy.premierleague.com/api/leagues-classic/1942089/standings/',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      return true;
    } else {
      print(response.statusMessage);
    }
    return false;
  }

  Group getGroup(String groupId) {
    return groups.firstWhere((element) => element.groupID == groupId);
  }
}
