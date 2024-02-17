// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Player {
  final String userID;
  final String username;
  final String teamName;
  final String rank;
  final DateTime createdAt;
  final DateTime joinDate;
  final List<Map<String, dynamic>> playHistory;
  final int timesWon;
  final int amountPlayed;
  final int amountWon;
  final String image;
  Player({
    required this.userID,
    required this.username,
    required this.teamName,
    required this.rank,
    required this.createdAt,
    required this.joinDate,
    required this.playHistory,
    required this.timesWon,
    required this.amountPlayed,
    required this.amountWon,
    required this.image,
  });

  Player copyWith({
    String? userID,
    String? username,
    String? team_name,
    String? rank,
    DateTime? createdAt,
    DateTime? joinDate,
    List<Map<String, dynamic>>? playHistory,
    int? timesWon,
    int? amountPlayed,
    int? amountWon,
    String? image,
  }) {
    return Player(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      teamName: team_name ?? this.teamName,
      rank: rank ?? this.rank,
      createdAt: createdAt ?? this.createdAt,
      joinDate: joinDate ?? this.joinDate,
      playHistory: playHistory ?? this.playHistory,
      timesWon: timesWon ?? this.timesWon,
      amountPlayed: amountPlayed ?? this.amountPlayed,
      amountWon: amountWon ?? this.amountWon,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'username': username,
      'team_name': teamName,
      'rank': rank,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'joinDate': joinDate.millisecondsSinceEpoch,
      'playHistory': playHistory,
      'timesWon': timesWon,
      'amountPlayed': amountPlayed,
      'amountWon': amountWon,
      'image': image,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      userID: map['userID'] as String,
      username: map['username'] as String,
      teamName: map['team_name'] as String,
      rank: map['rank'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      joinDate: DateTime.fromMillisecondsSinceEpoch(map['joinDate'] as int),
      playHistory: List<Map<String, dynamic>>.from(map['playHistory']),
      timesWon: map['timesWon'] as int,
      amountPlayed: map['amountPlayed'] as int,
      amountWon: map['amountWon'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Player(userID: $userID, username: $username, team_name: $teamName, rank: $rank, createdAt: $createdAt, joinDate: $joinDate, playHistory: $playHistory, timesWon: $timesWon, amountPlayed: $amountPlayed, amountWon: $amountWon, image: $image)';
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.username == username &&
        other.teamName == teamName &&
        other.rank == rank &&
        other.createdAt == createdAt &&
        other.joinDate == joinDate &&
        listEquals(other.playHistory, playHistory) &&
        other.timesWon == timesWon &&
        other.amountPlayed == amountPlayed &&
        other.amountWon == amountWon &&
        other.image == image;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        username.hashCode ^
        teamName.hashCode ^
        rank.hashCode ^
        createdAt.hashCode ^
        joinDate.hashCode ^
        playHistory.hashCode ^
        timesWon.hashCode ^
        amountPlayed.hashCode ^
        amountWon.hashCode ^
        image.hashCode;
  }
}
