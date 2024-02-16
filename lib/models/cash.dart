import 'package:intl/intl.dart';

class Cash {
  final double amount;
  final String agent;
  final String status;
  final String date;
  final bool deposit;
  String transactionId;
  final bool sent;
  final DateTime createdAt;
  final String image;
  Cash({
    required this.agent,
    required this.status,
    required this.amount,
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

  Cash copyWith({
    String? agent,
    double? amount,
    bool? deposit,
    String? transactionId,
    bool? sent,
    String? status,
    DateTime? createdAt,
    String? image,
  }) {
    return Cash(
      date: date,
      agent: agent ?? this.agent,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      deposit: deposit ?? this.deposit,
      transactionId: transactionId ?? this.transactionId,
      sent: sent ?? this.sent,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  factory Cash.fromMap(Map<String, dynamic> map, id) {
    return Cash(
      agent: map['agent'] ?? '',
      date: DateFormat('yyyy-MM').format(map['createdAt']),
      deposit: map['deposit'] ?? false,
      amount: map['amount']?.toDouble() ?? 0.0,
      transactionId: id,
      sent: map['sent'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      image: map['image'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
