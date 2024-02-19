import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/widgets/payment_tile.dart';
import 'package:hospital/widgets/transaction_tile.dart';

import '../../utils/globals.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    var size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.black,
      appBar: AppBar(
        title: Text("Transaction History"),
        backgroundColor: Globals.black,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(.1),
        foregroundColor: Globals.primaryColor,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: 50,
          itemBuilder: (context, index) {
            return Text("");
          },
        ),
      ),
    );
  }
}
