// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

class WeekData {
  final String weekID;
  final int maxPlayers;
  final bool isOpen;
  final int entryFee;
  final bool completed;
  final DateTime endsAt;
  final int registeredPlayers;

  final String description;
  WeekData({
    required this.weekID,
    required this.maxPlayers,
    required this.isOpen,
    required this.entryFee,
    required this.completed,
    required this.endsAt,
    required this.registeredPlayers,
    this.description = "The highest person of the GameWeek wins",
  });

  WeekData copyWith({
    String? weekID,
    int? maxPlayers,
    bool? isOpen,
    int? entryFee,
    bool? completed,
    DateTime? endsAt,
    int? registeredPlayers,
    String? description,
  }) {
    return WeekData(
      weekID: weekID ?? this.weekID,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      isOpen: isOpen ?? this.isOpen,
      entryFee: entryFee ?? this.entryFee,
      completed: completed ?? this.completed,
      endsAt: endsAt ?? this.endsAt,
      registeredPlayers: registeredPlayers ?? this.registeredPlayers,
      description: description ?? this.description,
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
      'description': description,
    };
  }

  factory WeekData.fromMap(Map<String, dynamic> map) {
    return WeekData(
      weekID: map['weekID'] as String,
      maxPlayers: map['maxPlayers'] as int,
      isOpen: map['isOpen'] as bool,
      entryFee: map['entryFee'] as int,
      completed: map['completed'] as bool,
      endsAt: DateTime.fromMillisecondsSinceEpoch(map['endsAt'] as int),
      registeredPlayers: map['registeredPlayers'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeekData.fromJson(String source) =>
      WeekData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeekData(weekID: $weekID, maxPlayers: $maxPlayers, isOpen: $isOpen, entryFee: $entryFee, completed: $completed, endsAt: $endsAt, registeredPlayers: $registeredPlayers, description: $description)';
  }

  @override
  bool operator ==(covariant WeekData other) {
    if (identical(this, other)) return true;

    return other.weekID == weekID &&
        other.maxPlayers == maxPlayers &&
        other.isOpen == isOpen &&
        other.entryFee == entryFee &&
        other.completed == completed &&
        other.endsAt == endsAt &&
        other.registeredPlayers == registeredPlayers &&
        other.description == description;
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
        description.hashCode;
  }
}