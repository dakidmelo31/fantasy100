import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/winning_position.dart';
import 'package:jiffy/jiffy.dart';

import '../utils/globals.dart';

class TransactionTile extends StatefulWidget {
  const TransactionTile(
      {super.key, required this.person, required this.cashPrize});
  final WinningPosition person;
  final int cashPrize;

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  bool open = false;
  late final WinningPosition person;
  @override
  void initState() {
    person = widget.person;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: open ? .95 : 1.0,
      alignment: Alignment.bottomCenter,
      curve: Curves.easeInOut,
      filterQuality: FilterQuality.high,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.only(
          bottom: open ? 25 : 4,
        ),
        child: Card(
          elevation: open ? 10 : 0,
          shadowColor: Colors.black.withOpacity(.29),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            onTap: () {
              setState(() {
                open = !open;
              });
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Card(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(0),
                                  topRight: Radius.circular(0))),
                          elevation: 0,
                          color: Globals.primaryBackground,
                          child: SizedBox(
                            height: 60,
                            width: 45,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.trophy,
                                color: Globals.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .59,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 6.0, bottom: 2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 6.0, bottom: 2.0),
                                  child: Text(
                                    person.title,
                                    style: Globals.title,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 6.0, bottom: 2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Prize: ",
                                            style: Globals.subtitle,
                                          ),
                                          Text(
                                            "${prettyNumber(((person.prize / 100) * widget.cashPrize))} CFA",
                                            style: const TextStyle(
                                                color: Color(0xff505050),
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 46),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.medal,
                                color: Globals.primaryBackground,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    color: const Color(0xffF3F1F5),
                    height: open ? 60 : 0,
                    width: double.infinity,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Card(
                                  margin: EdgeInsets.only(right: 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(0),
                                          topRight: Radius.circular(0))),
                                  elevation: 0,
                                  color: Color(0xffF3F1F5),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 18.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "Settled: ",
                                        style: Globals.title,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 6.0, bottom: 2.0),
                                          child: Text(
                                            person.winnerID != null
                                                ? "Yes"
                                                : "Not yet",
                                            style: Globals.title,
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 6, left: 26.0),
                                            child: Text(
                                              "Mandatory games",
                                              style: TextStyle(
                                                  color: Color(0xffaaaaaa),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Card(
                              surfaceTintColor: Globals.primaryColor,
                              shape: const CircleBorder(),
                              color: Globals.white,
                              elevation: 6,
                              shadowColor:
                                  Globals.primaryColor.withOpacity(.09),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  prettyNumber(person.mandatoryGames),
                                  style: GoogleFonts.poppins(
                                      color: Globals.primaryBackground),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
