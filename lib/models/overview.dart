// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Overview {
  final List<String> participants;
  final String userID;
  final DateTime createdAt;
  final DateTime lastMessageTime;
  final String lastMessage;
  final String agencyName;
  final String agencyImage;
  final String userName;
  final String userImage;
  final bool userChat;
  Overview({
    required this.participants,
    required this.userID,
    required this.createdAt,
    required this.lastMessageTime,
    required this.lastMessage,
    required this.agencyName,
    required this.agencyImage,
    required this.userName,
    required this.userImage,
    required this.userChat,
  });

  Overview copyWith({
    List<String>? participants,
    String? userID,
    DateTime? createdAt,
    DateTime? lastMessageTime,
    String? lastMessage,
    String? agencyName,
    String? agencyImage,
    String? userName,
    String? userImage,
    bool? userChat,
  }) {
    return Overview(
      participants: participants ?? this.participants,
      userID: userID ?? this.userID,
      createdAt: createdAt ?? this.createdAt,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessage: lastMessage ?? this.lastMessage,
      agencyName: agencyName ?? this.agencyName,
      agencyImage: agencyImage ?? this.agencyImage,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      userChat: userChat ?? this.userChat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'participants': participants,
      'userID': userID,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastMessageTime': lastMessageTime.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'agencyName': agencyName,
      'agencyImage': agencyImage,
      'userName': userName,
      'userImage': userImage,
      'userChat': userChat,
    };
  }

  factory Overview.fromMap(Map<String, dynamic> map) {
    return Overview(
      participants: List<String>.from((map['participants']) as List<String>),
      userID: map['userID'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      lastMessageTime:
          DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'] as int),
      lastMessage: map['lastMessage'] as String,
      agencyName: map['agencyName'] as String,
      agencyImage: map['agencyImage'] as String,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      userChat: map['userChat'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Overview.fromJson(String source) =>
      Overview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Overview(participants: $participants, userID: $userID, createdAt: $createdAt, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, agencyName: $agencyName, agencyImage: $agencyImage, userName: $userName, userImage: $userImage, userChat: $userChat)';
  }

  @override
  bool operator ==(covariant Overview other) {
    if (identical(this, other)) return true;

    return listEquals(other.participants, participants) &&
        other.userID == userID &&
        other.createdAt == createdAt &&
        other.lastMessageTime == lastMessageTime &&
        other.lastMessage == lastMessage &&
        other.agencyName == agencyName &&
        other.agencyImage == agencyImage &&
        other.userName == userName &&
        other.userImage == userImage &&
        other.userChat == userChat;
  }

  @override
  int get hashCode {
    return participants.hashCode ^
        userID.hashCode ^
        createdAt.hashCode ^
        lastMessageTime.hashCode ^
        lastMessage.hashCode ^
        agencyName.hashCode ^
        agencyImage.hashCode ^
        userName.hashCode ^
        userImage.hashCode ^
        userChat.hashCode;
  }
}
