// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

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
    this.image =
        'https://images.unsplash.com/photo-1565514020179-026b92b84bb6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTV8fHJpY2h8ZW58MHx8MHx8fDA%3D',
  });
  final DateTime endsAt;
  final String image;

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
      image: [
        'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Zm9vdGJhbGx8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1459865264687-595d652de67e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vdGJhbGx8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1606925797300-0b35e9d1794e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGZvb3RiYWxsfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1552318965-6e6be7484ada?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGZvb3RiYWxsfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1570498839593-e565b39455fc?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjJ8fGZvb3RiYWxsfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1517747614396-d21a78b850e8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjh8fGZvb3RiYWxsfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1661868926397-0083f0503c07?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzd8fGZvb3RiYWxsfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1565308674684-1d8c0b4433d2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fGZvb3RiYWxsfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1554356871-37514f300eb9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fGNoYW1waW9ucyUyMGxlYWd1ZXxlbnwwfHwwfHx8MA%3D%3D',
        'https://images.unsplash.com/photo-1520473378652-85d9c4aee6cf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z29sZHxlbnwwfHwwfHx8MA%3D%3D',
        'https://media.istockphoto.com/id/1443157897/photo/gold-soccer-ball-or-football-isolated-on-white-3d-illustration-background.jpg?b=1&s=612x612&w=0&k=20&c=o-yttULPd0_b2przS5C579XDuVBNA4VTrv6cPrG-Nik=',
        'https://images.unsplash.com/photo-1508862842963-67ae79d4eded?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cmljaHxlbnwwfHwwfHx8MA%3D%3D',
        'https://images.unsplash.com/photo-1581560293218-ab0a42752a4b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDB8fHJpY2h8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1565514020179-026b92b84bb6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTV8fHJpY2h8ZW58MHx8MHx8fDA%3D',
        'https://plus.unsplash.com/premium_photo-1680721443514-dc4a45bd89f9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjV8fHJpY2h8ZW58MHx8MHx8fDA%3D',
      ][Random().nextInt(10)],
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
