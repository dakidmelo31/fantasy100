import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/group.dart';
import 'package:intl/intl.dart';

import '../utils/globals.dart';
import '../utils/transitions.dart';
import 'skin.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.game});
  final Group game;

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Card(
      color: Globals.primaryBackground,
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(.15),
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: InkWell(
        onTap: () {},
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Stack(
          children: [
            if (false)
              Container(
                width: 6,
                height: 200,
                color: Globals.primaryColor,
              ),
            SizedBox(
              height: 200,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8.0, top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                color: Globals.primaryColor,
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(.35),
                                surfaceTintColor: Colors.orange,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    game.title,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  if (false)
                                    Text(
                                      "Ending: ",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                  CountDownText(
                                    finishedText: "Bid Up",
                                    daysTextLong: "Days : ",
                                    hoursTextShort: "H : ",
                                    minutesTextShort: " : ",
                                    secondsTextShort: "",
                                    showLabel: true,
                                    style: GoogleFonts.poppins(
                                        shadows: [
                                          BoxShadow(
                                              spreadRadius: 8,
                                              blurRadius: 10,
                                              color: Colors.black
                                                  .withOpacity(.15)),
                                        ],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                    due: game.endsAt,
                                  ),
                                  if (false)
                                    Text(
                                      DateFormat.yMEd().format(game.endsAt),
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey),
                                    ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            game.title,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${prettyNumber(game.cashPrize)} CFA",
                          style: Globals.whiteHeading,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      FontAwesomeIcons.solidGem,
                                      color: !game.iAmParticipating
                                          ? Globals.primaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${prettyNumber(game.entryFee)} CFA",
                                        style: Globals.primaryText,
                                      ),
                                      Skin(
                                        tag: game.playersID.length.toString() +
                                            game.title,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              game.playersID.isNotEmpty
                                                  ? "Enter now"
                                                  : "${prettyNumber(game.playersID.length + 1694967)} playing",
                                              style: Globals.lightText),
                                        ),
                                      ),
                                      if (false)
                                        Text(
                                          "Entry Fee",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xffbbbbbb),
                                              fontSize: 12),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Status",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    game.closed ? "Closed" : "Open",
                                    style: Globals.whiteText,
                                  ),
                                ],
                              ),
                              Hero(
                                tag: "game${game.groupID}",
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(26),
                                    child: SizedBox(
                                      width: 90,
                                      child: MaterialButton(
                                        padding: EdgeInsets.zero,
                                        color: Globals.primaryColor,
                                        onPressed: () {},
                                        shape: Globals.radius(16),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            children: [
                                              const Icon(FontAwesomeIcons.plus,
                                                  size: 15),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Enter",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
