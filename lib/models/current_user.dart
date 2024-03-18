// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hospital/main.dart';
import 'package:hospital/models/manager.dart';

class CurrentUser {
  final String phone;
  final String referralCode;
  final int balance;
  final String photo;
  final int teamID;
  final bool verified;
  final String userID;
  final String referrer;
  final bool referralSettled;
  final String location;
  final String teamName;
  int score;
  int lastRank;
  int rank;
  int total;
  final String username;
  int rankSort;
  CurrentUser({
    required this.phone,
    required this.referralCode,
    required this.balance,
    required this.photo,
    required this.teamID,
    required this.verified,
    required this.userID,
    required this.referrer,
    required this.referralSettled,
    required this.location,
    required this.teamName,
    required this.score,
    required this.lastRank,
    required this.rank,
    required this.total,
    required this.username,
    required this.rankSort,
  });

  late Manager manager = Manager(
      id: teamID,
      teamName: teamName,
      score: score,
      lastRank: lastRank,
      rank: rank,
      total: total,
      username: username,
      rankSort: rankSort,
      entry: teamID,
      image: photo);

  CurrentUser copyWith({
    String? phone,
    String? referralCode,
    int? balance,
    String? photo,
    int? teamID,
    bool? verified,
    String? userID,
    String? referrer,
    bool? referralSettled,
    String? location,
    String? teamName,
    int? score,
    int? lastRank,
    int? rank,
    int? total,
    String? username,
    int? rankSort,
  }) {
    return CurrentUser(
      phone: phone ?? this.phone,
      referralCode: referralCode ?? this.referralCode,
      balance: balance ?? this.balance,
      photo: photo ?? this.photo,
      teamID: teamID ?? this.teamID,
      verified: verified ?? this.verified,
      userID: userID ?? this.userID,
      referrer: referrer ?? this.referrer,
      referralSettled: referralSettled ?? this.referralSettled,
      location: location ?? this.location,
      teamName: teamName ?? this.teamName,
      score: score ?? this.score,
      lastRank: lastRank ?? this.lastRank,
      rank: rank ?? this.rank,
      total: total ?? this.total,
      username: username ?? this.username,
      rankSort: rankSort ?? this.rankSort,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'referralCode': referralCode,
      'balance': balance,
      'photo': photo,
      'teamID': teamID,
      'verified': verified,
      'referrer': referrer,
      'referralSettled': referralSettled,
      'location': location,
      'teamName': teamName,
      'score': score,
      'lastRank': lastRank,
      'rank': rank,
      'total': total,
      'username': username,
      "userID": userID,
      'rankSort': rankSort,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map, String id) {
    return CurrentUser(
      phone: map['phone'] as String,
      referralCode: map['referralCode'] as String,
      balance: map['balance'] as int,
      photo: map['photo'] as String,
      teamID: map['teamID'] as int,
      verified: map['verified'] as bool,
      userID: id,
      referrer: map['referrer'] as String,
      referralSettled: map['referralSettled'] as bool,
      location: map['location'] as String,
      teamName: map['teamName'] as String,
      score: map['score'] as int,
      lastRank: map['lastRank'] as int,
      rank: map['rank'] as int,
      total: map['total'] as int,
      username: map['username'] as String,
      rankSort: map['rankSort'] as int,
    );
  }

  @override
  String toString() {
    return 'CurrentUser(phone: $phone, referralCode: $referralCode, balance: $balance, photo: $photo, teamID: $teamID, verified: $verified, userID: $userID, referrer: $referrer, referralSettled: $referralSettled, location: $location, teamName: $teamName, score: $score, lastRank: $lastRank, rank: $rank, total: $total, username: $username, rankSort: $rankSort)';
  }

  @override
  bool operator ==(covariant CurrentUser other) {
    if (identical(this, other)) return true;

    return other.phone == phone &&
        other.referralCode == referralCode &&
        other.balance == balance &&
        other.photo == photo &&
        other.teamID == teamID &&
        other.verified == verified &&
        other.userID == userID &&
        other.referrer == referrer &&
        other.referralSettled == referralSettled &&
        other.location == location &&
        other.teamName == teamName &&
        other.score == score &&
        other.lastRank == lastRank &&
        other.rank == rank &&
        other.total == total &&
        other.username == username &&
        other.rankSort == rankSort;
  }

  @override
  int get hashCode {
    return phone.hashCode ^
        referralCode.hashCode ^
        balance.hashCode ^
        photo.hashCode ^
        teamID.hashCode ^
        verified.hashCode ^
        userID.hashCode ^
        referrer.hashCode ^
        referralSettled.hashCode ^
        location.hashCode ^
        teamName.hashCode ^
        score.hashCode ^
        lastRank.hashCode ^
        rank.hashCode ^
        total.hashCode ^
        username.hashCode ^
        rankSort.hashCode;
  }
}
