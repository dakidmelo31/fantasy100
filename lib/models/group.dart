// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hospital/models/winning_position.dart';

import '../utils/globals.dart';

class Group {
  final String title;
  final String groupID;
  final int cashPrize;
  final bool closed;
  final int limit;
  final int entryFee;
  final List<String> playersID;
  bool iAmParticipating;
  final List<WinningPosition> winningPositions;
  Group({
    required this.title,
    required this.groupID,
    required this.cashPrize,
    required this.closed,
    required this.limit,
    required this.entryFee,
    required this.playersID,
    required this.iAmParticipating,
    required this.winningPositions,
    required this.endsAt,
  });
  final DateTime endsAt;

  Group copyWith({
    String? title,
    String? groupID,
    int? cashPrize,
    int? members,
    bool? closed,
    int? limit,
    int? entryFee,
    List<String>? playersID,
    bool? iAmParticipating,
    List<WinningPosition>? winningPositions,
  }) {
    return Group(
      title: title ?? this.title,
      endsAt: endsAt ?? this.endsAt,
      groupID: groupID ?? this.groupID,
      cashPrize: cashPrize ?? this.cashPrize,
      closed: closed ?? this.closed,
      limit: limit ?? this.limit,
      entryFee: entryFee ?? this.entryFee,
      playersID: playersID ?? this.playersID,
      iAmParticipating: iAmParticipating ?? this.iAmParticipating,
      winningPositions: winningPositions ?? this.winningPositions,
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> items = [];
    for (var item in winningPositions) {
      items.add(item.toMap());
    }
    return <String, dynamic>{
      'title': title,
      'cashPrize': cashPrize,
      'closed': closed,
      'limit': limit,
      'entryFee': entryFee,
      'playersID': playersID,
      'iAmParticipating': iAmParticipating,
      'winningPositions': items,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map, String id) {
    String myId = auth.currentUser?.uid ?? "-1-1-1";
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(map['winningPositions']);
    final List<WinningPosition> positions = [];
    for (var item in data) {
      // debugPrint(item.toString());
      positions.add(WinningPosition.fromMap(item));
    }

    return Group(
      title: map['title'] as String,
      cashPrize: map['cashPrize'] as int,
      closed: map['closed'] as bool,
      limit: map['limit'] as int,
      endsAt: DateTime.fromMillisecondsSinceEpoch(map['endsAt']),
      entryFee: map['entryFee'] as int,
      playersID: List<String>.from(map['playersID']),
      iAmParticipating: map['playersID'].contains(myId),
      groupID: id,
      winningPositions: positions,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Group(groupID: $groupID, title: $title, cashPrize: $cashPrize, closed: $closed, limit: $limit, entryFee: $entryFee, playersID: $playersID, iAmParticipating: $iAmParticipating, winningPositions: $winningPositions)';
  }

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.cashPrize == cashPrize &&
        other.groupID == groupID &&
        other.closed == closed &&
        other.limit == limit &&
        other.entryFee == entryFee &&
        listEquals(other.playersID, playersID) &&
        other.iAmParticipating == iAmParticipating &&
        listEquals(other.winningPositions, winningPositions);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        cashPrize.hashCode ^
        closed.hashCode ^
        limit.hashCode ^
        entryFee.hashCode ^
        playersID.hashCode ^
        iAmParticipating.hashCode ^
        winningPositions.hashCode;
  }
}
