// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SystemData {
  final String currentGameweek;
  final DateTime endsAt;
  final String gameweekTitle;
  final int winBonus;
  final bool ended;
  final String season;

  int highest;
  SystemData({
    required this.currentGameweek,
    required this.endsAt,
    required this.gameweekTitle,
    required this.highest,
    required this.winBonus,
    required this.ended,
    required this.season,
  });

  SystemData copyWith({
    String? currentGameweek,
    DateTime? endsAt,
    String? gameweekTitle,
    int? winBonus,
    bool? ended,
    String? season,
  }) {
    return SystemData(
      currentGameweek: currentGameweek ?? this.currentGameweek,
      endsAt: endsAt ?? this.endsAt,
      gameweekTitle: gameweekTitle ?? this.gameweekTitle,
      winBonus: winBonus ?? this.winBonus,
      ended: ended ?? this.ended,
      season: season ?? this.season,
      highest: highest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentGameweek': currentGameweek,
      'endsAt': endsAt.millisecondsSinceEpoch,
      'gameweekTitle': gameweekTitle,
      'winBonus': winBonus,
      'ended': ended,
      'season': season,
      'highest': highest,
    };
  }

  factory SystemData.fromMap(Map<String, dynamic> map) {
    return SystemData(
      currentGameweek: map['currentGameweek'] as String,
      endsAt: DateTime.fromMillisecondsSinceEpoch(map['endsAt'] as int),
      gameweekTitle: map['gameweekTitle'] as String,
      winBonus: map['winBonus'] as int,
      ended: map['ended'] as bool,
      season: map['season'] as String,
      highest: map['highest'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SystemData.fromJson(String source) =>
      SystemData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SystemData(highest: $highest, currentGameweek: $currentGameweek, endsAt: $endsAt, gameweekTitle: $gameweekTitle, winBonus: $winBonus, ended: $ended, season: $season)';
  }

  @override
  bool operator ==(covariant SystemData other) {
    if (identical(this, other)) return true;

    return other.currentGameweek == currentGameweek &&
        other.endsAt == endsAt &&
        other.gameweekTitle == gameweekTitle &&
        other.winBonus == winBonus &&
        other.ended == ended &&
        other.season == season;
  }

  @override
  int get hashCode {
    return currentGameweek.hashCode ^
        endsAt.hashCode ^
        gameweekTitle.hashCode ^
        winBonus.hashCode ^
        ended.hashCode ^
        season.hashCode;
  }
}
