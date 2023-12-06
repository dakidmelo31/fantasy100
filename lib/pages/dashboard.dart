import 'package:flutter/material.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/widgets/balance_card.dart';
import 'package:hospital/widgets/main_bar.dart';

import '../widgets/parking_history.dart';
import '../widgets/scan_button.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static const routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ScanButton(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            backgroundColor: Globals.backgroundColor,
            expandedHeight: kToolbarHeight * 1.7,
            elevation: 0,
            forceElevated: false,
            pinned: true,
            floating: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: MainBar(),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: kToolbarHeight,
            ),
            BalanceCard(),
            ParkingHistory(),
          ]))
        ],
      ),
    );
  }
}
