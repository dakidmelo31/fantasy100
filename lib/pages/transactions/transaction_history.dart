import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/pages/dashboard.dart';
import 'package:hospital/pages/transactions/WithdrawalPage.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cash_model.dart';
import '../../utils/globals.dart';
import '../../widgets/cash_tile.dart';

class TransactionHistory extends StatefulWidget {
  static const routeName = "/transactionHistory";

  TransactionHistory({super.key, this.fromPush = false});
  bool fromPush;

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> hides = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactions0 = Provider.of<DataProvider>(context, listen: true);

    final transactions = transactions0.transactions;
    transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    // transactions.sort((a, b)=> a.date == b.date?1 :0);
    // debugPrint("Length of transactions: ${transactions.length}");
    final size = getSize(context);
    return WillPopScope(
      onWillPop: () async {
        if (widget.fromPush == true) {
          Navigator.pushReplacement(
              context, LeftTransition(child: const Dashboard()));
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Globals.backgroundColor,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                leading: const BackButton(
                  color: Globals.primaryColor,
                ),
                backgroundColor: Globals.backgroundColor,
                elevation: 15,
                shadowColor: Globals.primaryBackground.withOpacity(.4),
                flexibleSpace: const FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.fadeTitle,
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground
                  ],
                  collapseMode: CollapseMode.parallax,
                  title: Text(
                    "Transactions",
                    style: Globals.title,
                  ),
                ),
                scrolledUnderElevation: 0,
                actions: [
                  Card(
                    shape: const CircleBorder(),
                    elevation: 7,
                    color: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.black.withOpacity(.25),
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(context,
                              LeftTransition(child: const WithdrawalPage()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Icon(FontAwesomeIcons.arrowCircleUp,
                                  color: Globals.primaryColor2, size: 20)),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: const CircleBorder(),
                    shadowColor: Colors.black.withOpacity(.25),
                    elevation: 7,
                    color: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                              context, LeftTransition(child: const TopUp()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Icon(FontAwesomeIcons.arrowCircleDown,
                                  color: Color(0xff00aa00), size: 20)),
                        ),
                      ),
                    ),
                  )
                ],
                floating: true,
                pinned: true,
              ),
              SliverAnimatedList(
                initialItemCount: transactions.length,
                itemBuilder: (context, index, animation) {
                  final CashModel cash = transactions[index];
                  bool showDate = index == 0
                      ? true
                      : transactions[index - 1].date != cash.date;
                  // debugPrint(cash.date);
                  return hides.contains(cash.date)
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            if (showDate)
                              GestureDetector(
                                onTap: () {
                                  if (hides.contains(cash.date)) {
                                    setState(() {
                                      hides.remove(cash.date);
                                    });
                                  } else {
                                    setState(() {
                                      hides.add(cash.date);
                                    });
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 50.0, bottom: 20.0),
                                    child: Text(
                                      timeAgo.format(
                                        cash.createdAt,
                                      ),
                                      style: const TextStyle(
                                          color: Globals.primaryBackground,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            if (showDate && hides.contains(cash.date))
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, top: 50.0, bottom: 20.0),
                                child: ListTile(
                                  onTap: () {
                                    if (hides.contains(cash.date)) {
                                      setState(() {
                                        hides.remove(cash.date);
                                      });
                                    } else {
                                      setState(() {
                                        hides.add(cash.date);
                                      });
                                    }
                                  },
                                  leading: const Icon(Icons.history_rounded),
                                  title: Text(
                                    timeAgo.format(
                                      cash.createdAt,
                                    ),
                                    style: const TextStyle(
                                        color: Globals.primaryBackground,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            Transform.scale(
                              alignment: Alignment.center,
                              filterQuality: FilterQuality.high,
                              scale: CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.fastLinearToSlowEaseIn)
                                  .value,
                              // child: Text("should be cash here")
                              child: CashTile(
                                index: index,
                                cash: cash,
                              ),
                            ),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
