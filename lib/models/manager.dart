// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Manager {
  final int id;
  final String teamName;
  final int score;
  final int lastRank;
  final int rank;
  final int total;
  final String username;
  final int rankSort;
  bool isWaiting;
  final int entry;
  String image, phone;

  bool verified;
  Manager({
    required this.id,
    this.isWaiting = false,
    this.verified = false,
    this.phone = '',
    required this.teamName,
    required this.score,
    required this.lastRank,
    required this.rank,
    required this.total,
    required this.username,
    required this.rankSort,
    required this.entry,
    required this.image,
  });

  Manager copyWith({
    int? id,
    String? name,
    int? score,
    int? lastRank,
    int? rank,
    int? total,
    String? username,
    int? rankSort,
    int? entry,
    String? image,
  }) {
    return Manager(
      id: id ?? this.id,
      teamName: name ?? this.teamName,
      score: score ?? this.score,
      lastRank: lastRank ?? this.lastRank,
      rank: rank ?? this.rank,
      total: total ?? this.total,
      username: username ?? this.username,
      rankSort: rankSort ?? this.rankSort,
      entry: entry ?? this.entry,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teamID': id,
      'name': teamName,
      'score': score,
      'lastRank': lastRank,
      'rank': rank,
      'total': total,
      'username': username,
      'teamName': username,
      "verified": verified,
      "isWaiting": isWaiting,
      'rankSort': rankSort,
      'entry': entry,
      'image': image,
    };
  }

  factory Manager.fromMap(Map<String, dynamic> map) {
    return Manager(
      id: map['id'] as int,
      teamName: map['name'] as String,
      score: map['score'] as int,
      lastRank: map['lastRank'] as int,
      rank: map['rank'] as int,
      total: map['total'] as int,
      username: map['username'] as String,
      rankSort: map['rankSort'] as int,
      entry: map['entry'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Manager.fromJson(String source) =>
      Manager.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Manager(id: $id, name: $teamName, score: $score, lastRank: $lastRank, rank: $rank, total: $total, username: $username, rankSort: $rankSort, entry: $entry, image: $image)';
  }

  @override
  bool operator ==(covariant Manager other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.teamName == teamName &&
        other.score == score &&
        other.lastRank == lastRank &&
        other.rank == rank &&
        other.total == total &&
        other.username == username &&
        other.rankSort == rankSort &&
        other.entry == entry &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        teamName.hashCode ^
        score.hashCode ^
        lastRank.hashCode ^
        rank.hashCode ^
        total.hashCode ^
        username.hashCode ^
        rankSort.hashCode ^
        entry.hashCode ^
        image.hashCode;
  }
}
