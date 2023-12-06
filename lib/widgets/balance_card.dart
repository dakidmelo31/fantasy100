import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/globals.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _openCard = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1200),
        () => setState(() => _openCard = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Globals.primaryColor.withOpacity(.2),
      color: Globals.primaryColor,
      elevation: 15,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: AnimatedContainer(
        duration: Globals.mainDuration,
        height: _openCard ? 220 : 45,
        curve: Curves.fastLinearToSlowEaseIn,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 22.0),
              child: Text(
                "Account Balance",
                style: Globals.whiteText,
              ),
            ),
            Divider(
              color: Globals.transparent,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\$ 12",
                style: Globals.whiteTextBigger,
              ),
            )
          ],
        ),
      ),
    );
  }
}
