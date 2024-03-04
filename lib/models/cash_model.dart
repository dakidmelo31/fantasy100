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

  factory CashModel.fromMap(Map<String, dynamic> map, id) {
    return CashModel(
      agent: map['agent'] ?? '',
      date: DateFormat('yyyy-MM').format(map['createdAt'] == null
          ? DateTime.now()
          : map['createdAt'].toDate()),
      deposit: map['deposit'] ?? false,
      amount: map['amount']?.toInt() ?? 0,
      transactionId: id,
      sent: map['sent'] ?? false,
      createdAt:
          map['createdAt'] == null ? DateTime.now() : map['createdAt'].toDate(),
      image: map['image'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
