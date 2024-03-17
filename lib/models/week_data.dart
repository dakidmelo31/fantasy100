// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

class RoomModel {
  String weekID;
  final int maxPlayers;
  final bool isOpen;
  final int entryFee;
  final bool completed;
  final DateTime endsAt;
  final int registeredPlayers;
  final List<String> participantsID;

  final String description;

  final String info;
  RoomModel({
    required this.weekID,
    required this.maxPlayers,
    required this.isOpen,
    required this.entryFee,
    required this.completed,
    required this.endsAt,
    required this.registeredPlayers,
    required this.participantsID,
    required this.description,
    required this.info,
  });

  RoomModel copyWith({
    String? weekID,
    int? maxPlayers,
    bool? isOpen,
    int? entryFee,
    bool? completed,
    DateTime? endsAt,
    int? registeredPlayers,
    List<String>? participantsID,
    String? description,
    String? info,
  }) {
    return RoomModel(
      weekID: weekID ?? this.weekID,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      isOpen: isOpen ?? this.isOpen,
      entryFee: entryFee ?? this.entryFee,
      completed: completed ?? this.completed,
      endsAt: endsAt ?? this.endsAt,
      registeredPlayers: registeredPlayers ?? this.registeredPlayers,
      participantsID: participantsID ?? this.participantsID,
      description: description ?? this.description,
      info: info ?? this.info,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weekID': weekID,
      'maxPlayers': maxPlayers,
      'isOpen': isOpen,
      'entryFee': entryFee,
      'completed': completed,
      'endsAt': endsAt.millisecondsSinceEpoch,
      'registeredPlayers': registeredPlayers,
      'participantsID': participantsID,
      'description': description,
      'info': info,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    debugPrint("*******  ${map['participantsID']}  ****************");
    return RoomModel(
      weekID: map['weekID'] as String,
      maxPlayers: map['maxPlayers'] as int,
      isOpen: map['isOpen'] as bool,
      entryFee: map['entryFee'] as int,
      completed: map['completed'] as bool,
      endsAt: DateTime.fromMillisecondsSinceEpoch(map['endsAt'] as int),
      registeredPlayers: map['registeredPlayers'] as int,
      participantsID: List<String>.from((map['participantsID'])),
      description: map['description'] as String,
      info: map['info'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeekData(weekID: $weekID, maxPlayers: $maxPlayers, isOpen: $isOpen, entryFee: $entryFee, completed: $completed, endsAt: $endsAt, registeredPlayers: $registeredPlayers, participantsID: $participantsID, description: $description, info: $info)';
  }

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;

    return other.weekID == weekID &&
        other.maxPlayers == maxPlayers &&
        other.isOpen == isOpen &&
        other.entryFee == entryFee &&
        other.completed == completed &&
        other.endsAt == endsAt &&
        other.registeredPlayers == registeredPlayers &&
        listEquals(other.participantsID, participantsID) &&
        other.description == description &&
        other.info == info;
  }

  @override
  int get hashCode {
    return weekID.hashCode ^
        maxPlayers.hashCode ^
        isOpen.hashCode ^
        entryFee.hashCode ^
        completed.hashCode ^
        endsAt.hashCode ^
        registeredPlayers.hashCode ^
        participantsID.hashCode ^
        description.hashCode ^
        info.hashCode;
  }
}

class Week {
  final String description;
  final int highestPoint;
  final int bonus;
  final List<Map<String, dynamic>> participants;
  Week({
    required this.description,
    required this.highestPoint,
    required this.bonus,
    required this.participants,
  });

  Week copyWith({
    String? description,
    int? highestPoint,
    int? bonus,
    List<Map<String, dynamic>>? participants,
  }) {
    return Week(
      description: description ?? this.description,
      highestPoint: highestPoint ?? this.highestPoint,
      bonus: bonus ?? this.bonus,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'highestPoint': highestPoint,
      'bonus': bonus,
      'participants': participants,
    };
  }

  factory Week.fromMap(Map<String, dynamic> map) {
    return Week(
      description: map['description'] as String,
      highestPoint: map['highestPoint'] as int,
      bonus: map['bonus'] as int,
      participants: List<Map<String, dynamic>>.from(map['participants']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Week.fromJson(String source) =>
      Week.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Week(description: $description, highestPoint: $highestPoint, bonus: $bonus, participants: $participants)';
  }

  @override
  bool operator ==(covariant Week other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.highestPoint == highestPoint &&
        other.bonus == bonus &&
        listEquals(other.participants, participants);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        highestPoint.hashCode ^
        bonus.hashCode ^
        participants.hashCode;
  }
}
