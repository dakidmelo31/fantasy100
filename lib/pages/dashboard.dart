import 'dart:math';
import 'dart:ui';

import 'package:date_count_down/date_count_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/recommendation/recommendation_map.dart';
import 'package:hospital/pages/startup/SignupPage.dart';
import 'package:hospital/pages/startup/wave_screen.dart';
import 'package:hospital/pages/transactions/payment_history.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/drag_notch.dart';
import 'package:hospital/widgets/honeypot.dart';
import 'package:hospital/widgets/parking_tile.dart';
import 'package:hospital/widgets/transaction_tile.dart';
import 'package:lottie/lottie.dart';

import '../widgets/scale_animation.dart';
import 'account/my_account.dart';
import 'transactions/parking_history.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const routeName = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late final AnimationController _animationController, _repeatController;

  late final Animation<double> _animation;
  late Animation _repeatAnimation;

  final _drawerKey = GlobalKey<ScaffoldState>();

  bool _opened = false;
  List<Widget> scoreTiles = [];

  late final DateTime _mainDuration;
  @override
  void initState() {
    _mainDuration = DateTime.now().add(const Duration(days: 16));
    scoreTiles = List<Widget>.generate(
        120,
        (index) => PlayerTile(
              callback: () {},
              score: Random().nextInt(120).toString(),
              index: index + 1,
            ));
    // scoreTiles.sort((a, b) => a.,)
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _repeatController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn);

    _repeatController.repeat(reverse: true);
    _repeatAnimation = Tween(begin: 10.0, end: 20.0).animate(_repeatController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _repeatController.dispose();
    _animationController.dispose();
    _animation.isDismissed;
    _repeatAnimation.isDismissed;
    super.dispose();
  }

  bool _showSignup = false;
  bool opened = false;
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return PopScope(
      canPop: !_showSignup,
      onPopInvoked: (pop) async {
        debugPrint("$_showSignup || $opened");
        if (_showSignup) {
          setState(() {
            opened = false;
            _showSignup = false;
          });
          // return false;
        }
        // return false;
      },
      child: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return const Center(
              child: Text("User data available"),
            );
          }
          if (snapshot.hasData) {}

          return Stack(
            children: [
              Scaffold(
                backgroundColor: Globals.black,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Globals.black,
                  elevation: 0,
                  foregroundColor: Colors.black,
                  actions: [
                    IconButton(
                        onPressed: () {
                          debugPrint("Show Notification");
                          Globals.localNotification(
                              title: "title",
                              body: "body",
                              image:
                                  "https://cdn.hashnode.com/res/hashnode/image/upload/v1679892037999/8e415364-050a-497b-9f66-c096e80180d4.jpeg?w=400&h=400&fit=crop&crop=faces&auto=compress,format&format=webp");
                        },
                        icon: const Icon(
                          FontAwesomeIcons.bell,
                          color: Colors.white,
                        )),
                    Card(
                      shape: Globals.radius(16),
                      color: Globals.lightBlack,
                      child: InkWell(
                        customBorder: Globals.radius(16),
                        onTap: () {
                          if (auth.currentUser != null) {
                            Navigator.push(
                                context, LeftTransition(child: const TopUp()));
                          } else {
                            _showSignup = true;
                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Top Up",
                                style: Globals.whiteText,
                              ),
                              if (false)
                                Lottie.asset("$dir/add1.json",
                                    width: 40, height: 40, fit: BoxFit.contain),
                              const SizedBox(width: 8),
                              const Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                  leading: InkWell(
                    onTap: () {
                      setState(() {
                        opened = !opened;
                      });

                      if (false) {
                        Navigator.push(
                            context, LeftTransition(child: const WaveScreen()));
                      }
                    },
                    customBorder: Globals.radius(16),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Card(
                              shape: CircleBorder(),
                              child: SizedBox(
                                height: 10,
                                width: 10,
                              ),
                            ),
                            SizedBox(width: 5),
                            Card(
                              shape: CircleBorder(),
                              child: SizedBox(
                                height: 10,
                                width: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Card(
                              shape: CircleBorder(),
                              child: SizedBox(
                                height: 10,
                                width: 10,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Card(
                              shape: Globals.radius(4),
                              child: const SizedBox(
                                height: 10,
                                width: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  title: const Text(
                    "Mr Melo FC",
                    style: Globals.whiteText,
                  ),
                ),
                body: AnimatedBuilder(
                    animation: _repeatAnimation,
                    builder: (context, child) {
                      return AnimatedBuilder(
                          animation: _animationController,
                          builder: (_, __) {
                            return Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  width: size.width,
                                  height: size.height,
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(6 -
                                                  (8 *
                                                      (1 -
                                                          _animationController
                                                              .value))),
                                              child: SizedBox(
                                                  height: size.width,
                                                  width: size.width,
                                                  child: Stack(
                                                    children: [
                                                      HoneyPot(),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: CountDownText(
                                                            due: _mainDuration,
                                                            longDateName: true,
                                                            finishedText:
                                                                "No more Entries",
                                                            style: GoogleFonts
                                                                .jost(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      )
                                                    ],
                                                  ))),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                Globals.parked =
                                                    !Globals.parked;
                                              });
                                            },
                                            child: SizedBox(
                                              width: size.width * .8,
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 18.0),
                                                child: Text(
                                                  "Tap to view leaderboard.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      color: Color(0xff666666),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kToolbarHeight,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 18.0),
                                            child: SizedBox(
                                              height: kToolbarHeight,
                                              width: size.width,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .wallet,
                                                          size: 35,
                                                          color: Globals
                                                              .primaryColor,
                                                        ),
                                                        Text(
                                                          "  Balance:",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "OpenSans",
                                                            fontSize: 14,
                                                            color: Globals
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 25.0,
                                                    ),
                                                    const Text(
                                                      "15,000 CFA",
                                                      style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Globals
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 25.0),
                                                    Material(
                                                      shape:
                                                          const CircleBorder(),
                                                      elevation: 10,
                                                      color: Colors.white,
                                                      surfaceTintColor:
                                                          Globals.primaryColor,
                                                      shadowColor: Colors.black
                                                          .withOpacity(.09),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          showCupertinoDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                CupertinoAlertDialog(
                                                              content:
                                                                  const Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "It costs 200 Frs to join the Game Week. The top 4 of participating users get the HoneyPot Split into a ratio of 60 20 10 10"),
                                                                  Text(
                                                                      "Example:"),
                                                                  Text(
                                                                      "If the HoneyPot is 100,000frs then the ratio would look like the following:"),
                                                                  Text(
                                                                      "- 1st Place 60,000 cfa"),
                                                                  Text(
                                                                      "- 2nd Place 20,000 cfa"),
                                                                  Text(
                                                                      "- 3rd Place 10,000 cfa"),
                                                                  Text(
                                                                      "- 4th Place 10,000 cfa"),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Text(
                                                                      "Note: The people eligible for the HoneyPot money are the ones who put in their money before the gameweek starts"),
                                                                ],
                                                              ),
                                                              actions: [
                                                                CupertinoDialogAction(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          true),
                                                                  isDefaultAction:
                                                                      true,
                                                                  isDestructiveAction:
                                                                      false,
                                                                  child: Text(
                                                                    "Join Gameweek",
                                                                    style: GoogleFonts.poppins(
                                                                        color: const Color(
                                                                            0xff000000),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                                CupertinoDialogAction(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          false),
                                                                  isDefaultAction:
                                                                      false,
                                                                  isDestructiveAction:
                                                                      true,
                                                                  child:
                                                                      const Text(
                                                                    "Cancel",
                                                                    style: Globals
                                                                        .subtitle,
                                                                  ),
                                                                ),
                                                              ],
                                                              title: const Text(
                                                                  "Joing Gameweek 26"),
                                                            ),
                                                          );

                                                          // Navigator.push(
                                                          //     context,
                                                          //     LeftTransition(
                                                          //         child:
                                                          //             const TopUp()));
                                                        },
                                                        customBorder:
                                                            const CircleBorder(),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  14.0),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .plus,
                                                            color: Globals
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                          if (false)
                                            Card(
                                              color: Globals.primaryColor,
                                              child: SizedBox(
                                                width: size.width,
                                                height: 100,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "GameWeek 25",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Globals
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "425",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Globals
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (false)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 16),
                                                onPressed: () {
                                                  if (false) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const RecommendationMap()));
                                                  }
                                                },
                                                elevation: 10,
                                                color: Globals.primaryColor,
                                                textColor: Colors.white,
                                                child: SizedBox(
                                                  width: size.width * .8,
                                                  child: const Center(
                                                    child: Text(
                                                      "Recommendations",
                                                      style: TextStyle(
                                                        fontFamily: "Lato",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    }),
              ),
              AnimatedPositioned(
                bottom: 0,
                height: _opened ? size.height * .85 : kToolbarHeight * 2,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 1200),
                child: DecoratedBox(
                  decoration: BoxDecoration(boxShadow: [
                    if (_opened)
                      BoxShadow(
                          blurRadius: 200,
                          spreadRadius: 60,
                          color: Globals.primaryColor.withOpacity(.25))
                  ]),
                  child: Material(
                    shadowColor: Globals.primaryColor.withOpacity(.7),
                    elevation: 20,
                    shape: Globals.radius(36),
                    color: const Color(0xff1A1423),
                    child: SizedBox(
                      width: size.width,
                      height: size.height * .95,
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: kToolbarHeight * 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, top: 26, right: 18),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _opened = !_opened;
                                    });
                                  },
                                  child: DragNotch(pullDown: () {
                                    setState(() {
                                      _opened = false;
                                    });
                                  }, pullUp: () {
                                    setState(() {
                                      _opened = true;
                                    });
                                  })),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 100,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 10),
                              itemBuilder: (context, index) {
                                final scoreTile = scoreTiles[index];
                                return scoreTile;
                                return TransactionTile(
                                    onPressed: () {},
                                    title: "Mr Melo FC",
                                    fees: Random().nextInt(120).toString(),
                                    subtitle: "${index + 1}",
                                    icon: FontAwesomeIcons.shieldHeart);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastLinearToSlowEaseIn,
                left: opened ? 0 : -size.width,
                width: size.width * 1,
                height: size.height,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                      highlightColor: Globals.primaryColor,
                      splashColor: Globals.primaryColor,
                      onTap: () {
                        debugPrint("clicked");
                        setState(() {
                          opened = false;
                        });
                      },
                      child: SizedBox(
                        width: size.width,
                        height: size.height,
                      )),
                ),
              ),
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastLinearToSlowEaseIn,
                  left: opened ? 0 : -size.width,
                  width: size.width * .68,
                  height: size.height,
                  child: Material(
                    clipBehavior: opened ? Clip.none : Clip.antiAlias,
                    elevation: 70,
                    shadowColor: Colors.black.withOpacity(.5),
                    color: Globals.lightBlack,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Material(
                        elevation: 0,
                        color: Globals.lightBlack,
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                            const Text(
                              "Menu",
                              style: Globals.whiteHeading,
                            ),
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  opened = false;
                                });
                                HapticFeedback.heavyImpact();
                                Future.delayed(const Duration(milliseconds: 60),
                                    () {
                                  Navigator.push(context,
                                      LeftTransition(child: const MyAccount()));
                                });
                              },
                              title: const Text(
                                "My Account",
                                style: Globals.whiteTile,
                              ),
                              trailing: const Icon(FontAwesomeIcons.userLock,
                                  size: 15),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  opened = false;
                                });
                                HapticFeedback.heavyImpact();
                                Future.delayed(const Duration(milliseconds: 60),
                                    () {
                                  Navigator.push(
                                      context,
                                      LeftTransition(
                                          child: const ParkingHistory()));
                                });
                              },
                              title: const Text(
                                "Parking history",
                                style: Globals.whiteTile,
                              ),
                              trailing: const Icon(
                                  FontAwesomeIcons.clockRotateLeft,
                                  size: 15),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  opened = false;
                                });
                                HapticFeedback.heavyImpact();
                                Future.delayed(const Duration(milliseconds: 60),
                                    () {
                                  Navigator.push(
                                      context,
                                      LeftTransition(
                                          child: const PaymentHistory()));
                                });
                              },
                              title: const Text(
                                "Transaction history",
                                style: Globals.whiteTile,
                              ),
                              trailing: const Icon(FontAwesomeIcons.moneyBills,
                                  size: 15),
                            ),
                            ListTile(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                              },
                              title: const Text(
                                "My Cards",
                                style: Globals.whiteTile,
                              ),
                              trailing: const Icon(FontAwesomeIcons.creditCard,
                                  size: 15),
                            ),
                            ListTile(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                              },
                              title: const Text(
                                "Recommendations",
                                style: Globals.whiteTile,
                              ),
                              trailing:
                                  const Icon(FontAwesomeIcons.globe, size: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                curve: Curves.fastLinearToSlowEaseIn,
                bottom: 0,
                height: size.height,
                width: size.width,
                left: _showSignup ? 0 : size.width,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Material(
                      elevation: 0,
                      color: Globals.transparent,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 68.0),
                                  child: ScaleAnim(),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 108.0),
                                  child: Text(
                                    "Signup to Continue",
                                    style: Globals.whiteHeading,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 88.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          FloatingActionButton(
                                            elevation: 10,
                                            heroTag: "phoneAuth",
                                            backgroundColor:
                                                Globals.primaryColor,
                                            foregroundColor: Globals.black,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  LeftTransition(
                                                      child:
                                                          const SignupPage()));
                                            },
                                            shape: const CircleBorder(),
                                            child: const Icon(
                                                FontAwesomeIcons.phone),
                                          ),
                                          const Text(
                                            "Phone",
                                            style: TextStyle(
                                                color: Color(0xff999999)),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          FloatingActionButton(
                                            heroTag: "Google",
                                            backgroundColor: Globals.black,
                                            foregroundColor:
                                                Globals.primaryColor,
                                            onPressed: () {},
                                            shape: const CircleBorder(),
                                            child: const Icon(
                                                FontAwesomeIcons.google),
                                          ),
                                          const Text(
                                            "Google",
                                            style: TextStyle(
                                                color: Color(0xff999999)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
