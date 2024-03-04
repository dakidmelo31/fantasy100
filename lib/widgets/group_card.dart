import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/group.dart';
import 'package:hospital/pages/group_details.dart';
import 'package:hospital/pages/transactions/testing.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/skin.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';

class GroupCard extends StatefulWidget {
  const GroupCard({super.key, required this.card});
  final Group card;

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  late final Group card;

  @override
  void initState() {
    card = widget.card;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Card(
        color: Globals.primaryColor,
        elevation: 0,
        shadowColor: Globals.primaryColor,
        surfaceTintColor: Globals.primaryColor,
        child: InkWell(
          customBorder: Globals.radius(20),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GroupDetails(groupID: card.groupID)));
          },
          child: SizedBox(
            width: size.width * .95,
            child: Stack(
              children: [
                if (false)
                  CachedNetworkImage(
                      imageUrl:
                          'https://technext24.com/wp-content/uploads/2021/06/22-Mar-fixture-amendments.png',
                      placeholder: (context, url) => placeholder,
                      errorWidget: (context, url, error) => errorWidget2,
                      fit: BoxFit.cover),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Globals.primaryColor.withOpacity(.7),
                    width: double.infinity,
                    height: 260,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (false)
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    FontAwesomeIcons.crown,
                                    size: 20,
                                    color: Globals.primaryColor,
                                  ),
                                ),
                              Hero(
                                  tag: card.title,
                                  child: Card(
                                    color: Globals.primaryBackground,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(card.title,
                                          style: Globals.whiteText),
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Skin(
                              tag:
                                  card.playersID.length.toString() + card.title,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    card.playersID.isNotEmpty
                                        ? "Enter now"
                                        : "${prettyNumber(card.playersID.length + 1694967)} playing",
                                    style: Globals.lightText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Globals.primaryColor.withOpacity(.5),
                      endIndent: 20,
                      height: 1,
                    ),
                  ],
                ),
                Positioned(
                  top: 108,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skin(
                            tag: prettyNumber(card.cashPrize) + card.title,
                            child: Text(
                              "${prettyNumber(card.cashPrize)} CFA",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFFffffff), fontSize: 26),
                            ),
                          ),
                          const Text(
                            "Tap for more info",
                            style: Globals.lightWhiteText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CircleClipper(),
                  child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 10,
                      color: Globals.primaryBackground,
                      surfaceTintColor: Globals.blacker,
                      shadowColor: Colors.black,
                      child: SizedBox(
                          width: double.infinity,
                          height: 260,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, bottom: 18.0),
                              child: card.iAmParticipating
                                  ? Material(
                                      color: Globals.primaryColor,
                                      shape: const CircleBorder(),
                                      child: GestureDetector(
                                        onTap: () {
                                          toast(
                                              message:
                                                  "You're already playing");
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Icon(
                                            FontAwesomeIcons.checkDouble,
                                            color: Globals.primaryBackground,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Card(
                                      color: const Color.fromARGB(
                                          255, 203, 204, 184),
                                      elevation: 10,
                                      surfaceTintColor: Colors.amber,
                                      shape: Globals.radius(26),
                                      child: InkWell(
                                        customBorder: Globals.radius(26),
                                        onTap: () {
                                          data.loadScreen();
                                          data.play(card);
                                        },
                                        child: const SizedBox(
                                          width: 66,
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(""),
                                              Icon(
                                                FontAwesomeIcons.add,
                                                size: 15,
                                              ),
                                              Text("Play"),
                                              Text("")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.8, size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
