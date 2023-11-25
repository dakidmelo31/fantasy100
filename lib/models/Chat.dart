// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chat {
  final String senderID;
  final String message;
  final DateTime sentAt;
  final String type;

  final String caption;
  final Map<String, dynamic> replying;
  Chat({
    required this.senderID,
    required this.message,
    required this.sentAt,
    required this.type,
    required this.caption,
    required this.replying,
  });

  Chat copyWith({
    String? senderID,
    String? message,
    DateTime? sentAt,
    String? type,
    String? caption,
    Map<String, dynamic>? replying,
  }) {
    return Chat(
      senderID: senderID ?? this.senderID,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      type: type ?? this.type,
      caption: caption ?? this.caption,
      replying: replying ?? this.replying,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderID': senderID,
      'message': message,
      'sentAt': sentAt.millisecondsSinceEpoch,
      'type': type,
      'caption': caption,
      'replying': replying,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      senderID: map['senderID'] as String,
      message: map['message'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'] as int),
      type: map['type'] as String,
      caption: map['caption'] as String,
      replying:
          Map<String, dynamic>.from((map['replying']) as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(senderID: $senderID, message: $message, sentAt: $sentAt, type: $type, caption: $caption, replying: $replying)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.senderID == senderID &&
        other.message == message &&
        other.sentAt == sentAt &&
        other.type == type &&
        other.caption == caption &&
        mapEquals(other.replying, replying);
  }

  @override
  int get hashCode {
    return senderID.hashCode ^
        message.hashCode ^
        sentAt.hashCode ^
        type.hashCode ^
        caption.hashCode ^
        replying.hashCode;
  }
}
