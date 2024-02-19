// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class WinningPosition {
  final String title;
  final int prize;
  final int bonus;
  final int mandatoryGames;
  final String? winnerID;
  WinningPosition({
    required this.title,
    required this.prize,
    required this.bonus,
    required this.mandatoryGames,
    this.winnerID,
  });

  WinningPosition copyWith({
    String? title,
    int? prize,
    int? bonus,
    int? mandatoryGames,
    String? winnerID,
  }) {
    return WinningPosition(
      title: title ?? this.title,
      prize: prize ?? this.prize,
      bonus: bonus ?? this.bonus,
      mandatoryGames: mandatoryGames ?? this.mandatoryGames,
      winnerID: winnerID ?? this.winnerID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'prize': prize,
      'bonus': bonus,
      'mandatoryGames': mandatoryGames,
      'winnerID': winnerID,
    };
  }

  factory WinningPosition.fromMap(Map<String, dynamic> map) {
    debugPrint(map.toString());
    return WinningPosition(
      title: map['title'] as String,
      prize: map['prize'] ?? 0,
      bonus: map['bonus'] ?? 10,
      mandatoryGames: map['mandatoryGames'] ?? 0,
      winnerID: map['winnerID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WinningPosition.fromJson(String source) =>
      WinningPosition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WinningPosition(title: $title, prize: $prize, bonus: $bonus, mandatoryGames: $mandatoryGames, winnerID: $winnerID)';
  }

  @override
  bool operator ==(covariant WinningPosition other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.prize == prize &&
        other.bonus == bonus &&
        other.mandatoryGames == mandatoryGames &&
        other.winnerID == winnerID;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        prize.hashCode ^
        bonus.hashCode ^
        mandatoryGames.hashCode ^
        winnerID.hashCode;
  }
}
