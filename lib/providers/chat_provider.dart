import 'package:flutter/material.dart';

import '../models/overview.dart';
import '../utils/globals.dart';

class ChatProvider extends ChangeNotifier {
  final List<Overview> overviews = [];

  ChatProvider() {
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
}
