import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/widgets/skin.dart';
import 'package:hospital/widgets/transaction_tile.dart';
import 'package:provider/provider.dart';

import '../utils/globals.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({super.key, required this.groupID});
  final String groupID;

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: true);
    final size = getSize(context);

    final card = data.getGroup(widget.groupID);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
            ),
            pinned: true,
            floating: true,
            forceElevated: false,
            scrolledUnderElevation: 0,
            title: Skin(tag: card.title, child: Text(card.title)),
            expandedHeight: kToolbarHeight,
            actions: [
              FloatingActionButton.small(
                heroTag: "extra",
                shape: const CircleBorder(),
                backgroundColor: card.iAmParticipating
                    ? Globals.primaryColor
                    : Globals.black,
                foregroundColor: !card.iAmParticipating
                    ? Globals.primaryColor
                    : Globals.black,
                onPressed: () {
                  if (card.iAmParticipating) {
                    toast(message: "Alraedy playing");
                  } else {
                    toast(message: "Join Game");
                  }
                },
                child: Icon(card.iAmParticipating
                    ? FontAwesomeIcons.checkDouble
                    : FontAwesomeIcons.plus),
              ),
              FloatingActionButton.small(
                heroTag: "notification",
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                foregroundColor: Globals.black,
                onPressed: () {
                  if (card.iAmParticipating) {
                    toast(message: "Notify Me");
                  } else {
                    toast(message: "Never mind");
                  }
                },
                child: Icon(FontAwesomeIcons.bell),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            forceMaterialTransparency: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Skin(
                              tag:
                                  card.playersID.length.toString() + card.title,
                              child: Text(
                                "${prettyNumber(card.cashPrize)} CFA",
                                style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    color: Globals.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Text("How much to be won")
                      ],
                    ),
                    space,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Prizes will be shared as follows:"),
                      ),
                    ),
                    Column(
                      children: card.winningPositions.map((person) {
                        return TransactionTile(
                          person: person,
                          cashPrize: card.cashPrize,
                        );
                      }).toList(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
