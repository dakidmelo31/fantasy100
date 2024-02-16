import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/overview.dart';
import '../utils/globals.dart';

class DataProvider extends ChangeNotifier {
  final List<Overview> overviews = [];

  DataProvider() {
    loadOverviews();
  }

  Future<void> loadChats(String overviewID) async {
    // firestore
    //     .collection("overviews")
    //     .doc(overviewID)
    //     .collection("message")
    //     .orderBy("sentAt", descending: true);
  }

  Future<void> loadOverviews() async {
    // firestore
    //     .collection("overviews")
    //     .where("participants", arrayContains: auth.currentUser!.uid)
    //     .snapshots()
    //     .listen((event) {
    //   notifyListeners();
    // });
  }

  Future<bool> loadGroups() async {
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
}
