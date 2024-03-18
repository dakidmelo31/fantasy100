// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CashModel {
  final int amount;
  final String agent;
  String status;
  final String date;
  final bool deposit;
  String transactionId;
  final bool sent;
  final DateTime createdAt;
  final String image;
  CashModel({
    required this.amount,
    required this.agent,
    required this.status,
    required this.date,
    required this.deposit,
    required this.transactionId,
    required this.sent,
    required this.createdAt,
    required this.image,
  });

  String getInitials() {
    String name = agent;
    String newName = '';
    List<String> split = name.split(" ");
    if (split.length > 1) {
      newName = split[0].split("")[0];
      newName += split[split.length - 1].split("")[0];
    }
    return newName;
  }

  CashModel copyWith({
    int? amount,
    String? agent,
    String? status,
    String? date,
    bool? deposit,
    String? transactionId,
    bool? sent,
    DateTime? createdAt,
    String? image,
  }) {
    return CashModel(
      amount: amount ?? this.amount,
      agent: agent ?? this.agent,
      status: status ?? this.status,
      date: date ?? this.date,
      deposit: deposit ?? this.deposit,
      transactionId: transactionId ?? this.transactionId,
      sent: sent ?? this.sent,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'agent': agent,
      'status': status,
      'date': date,
      'deposit': deposit,
      'transactionId': transactionId,
      'sent': sent,
      'createdAt': FieldValue.serverTimestamp(),
      'image': image,
    };
  }

  factory CashModel.fromMap(Map<String, dynamic> map, String id) {
    return CashModel(
      amount: map['amount'] as int,
      agent: map['agent'] as String,
      status: map['status'] as String,
      date: DateFormat.yMEd().format((map['createdAt']).toDate()),
      deposit: map['deposit'] as bool,
      transactionId: id,
      sent: map.containsKey("sent") ? map['sent'] as bool : true,
      createdAt: (map['createdAt']).toDate(),
      image: map['image'] as String,
    );
  }

  @override
  String toString() {
    return 'CashModel(amount: $amount, agent: $agent, status: $status, date: $date, deposit: $deposit, transactionId: $transactionId, sent: $sent, createdAt: $createdAt, image: $image)';
  }

  @override
  bool operator ==(covariant CashModel other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.agent == agent &&
        other.status == status &&
        other.date == date &&
        other.deposit == deposit &&
        other.transactionId == transactionId &&
        other.sent == sent &&
        other.createdAt == createdAt &&
        other.image == image;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        agent.hashCode ^
        status.hashCode ^
        date.hashCode ^
        deposit.hashCode ^
        transactionId.hashCode ^
        sent.hashCode ^
        createdAt.hashCode ^
        image.hashCode;
  }
}
