import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:provider/provider.dart';

class ConfirmTeam extends StatefulWidget {
  const ConfirmTeam({super.key, required this.userID});
  final int userID;

  @override
  State<ConfirmTeam> createState() => _ConfirmTeamState();
}

class _ConfirmTeamState extends State<ConfirmTeam> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: true);
    final result = data.searchManager(widget.userID);
    final size = getSize(context);
    return Scaffold(
        backgroundColor: Globals.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Not Seeing your team?"),
                      content: const Column(
                        children: [
                          Text(
                              "If you are not getting a team on this page even after correctly enterring your team code then get help from us")
                        ],
                      ),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            toast(message: "launching whatsapp");
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Color(0xff00aa00),
                          ),
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: false,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: Globals.greySubtitle,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(FontAwesomeIcons.circleInfo)),
            const SizedBox(width: 10)
          ],
          elevation: 0,
          surfaceTintColor: Colors.white,
          foregroundColor: Globals.black,
          backgroundColor: Globals.white,
          title: const Text("Confirm your Squad"),
          forceMaterialTransparency: false,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: size.height - kToolbarHeight * 2,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      "This is what we found",
                      style: Globals.greySubtitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      surfaceTintColor: Globals.primaryColor,
                      elevation: 15,
                      shadowColor: Globals.black.withOpacity(.1),
                      child: InkWell(
                        customBorder: Globals.radius(10),
                        onTap: () {
                          HapticFeedback.heavyImpact();
                        },
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Team Name",
                                    style: Globals.subtitle,
                                  ),
                                  Text(
                                    "Mr Melo FC",
                                    style: Globals.title,
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Username",
                                    style: Globals.subtitle,
                                  ),
                                  Text(
                                    "Ndoye Philip Ndula",
                                    style: Globals.title,
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Current Ranking",
                                    style: Globals.subtitle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "#",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Globals.black,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        " 205",
                                        style: Globals.title,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GW 25 Points",
                                    style: Globals.subtitle,
                                  ),
                                  Text(
                                    "65",
                                    style: Globals.heading,
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                topRight: Radius.zero,
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * .55,
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Team just joined FPL group",
                                            style: Globals.title,
                                          ),
                                          Text(
                                              "Stats available from next gameweek")
                                        ],
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      value: true,
                                      activeColor: const Color(0xff00aa00),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Hero(
                      tag: "userFloatingButton",
                      child: MaterialButton(
                        color: Globals.black,
                        shape: Globals.radius(10),
                        elevation: 0,
                        textColor: Globals.white,
                        onPressed: () {
                          toast(message: "confirmed");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text("Yes, I confirm that this is my Team"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
