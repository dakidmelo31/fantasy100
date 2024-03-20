import 'dart:ui';

import 'package:date_count_down/date_count_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/confirm_team.dart';
import 'package:hospital/pages/startup/SignupPage.dart';
import 'package:hospital/pages/startup/wave_screen.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/pages/transactions/transaction_history.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/drag_notch.dart';
import 'package:hospital/widgets/group_gamelist.dart';
import 'package:hospital/widgets/honeypot.dart';
import 'package:hospital/widgets/parking_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late final AnimationController _animation2Controller, _repeatController;

  late final Animation<double> _animation;
  late Animation _repeatAnimation;

  final _drawerKey = GlobalKey<ScaffoldState>();

  bool _opened = false;

  late final DateTime _mainDuration;
  @override
  void initState() {
    _mainDuration = DateTime.now().add(const Duration(days: 16));
    // scoreTiles.sort((a, b) => a.,)
    _animation2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _repeatController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation = CurvedAnimation(
        parent: _animation2Controller, curve: Curves.fastLinearToSlowEaseIn);

    _repeatController.repeat(reverse: true);
    _repeatAnimation = Tween(begin: 10.0, end: 20.0).animate(_repeatController)
      ..addListener(() {
        setState(() {});
      });

    _animation2Controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _repeatController.dispose();
    _animation2Controller.dispose();
    _animation.isDismissed;
    if (_controller != null) _controller!.dispose();
    _repeatAnimation.isDismissed;
    super.dispose();
  }

  bool _showSignup = false;
  bool opened = false;
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);
    final players = data.managers;
    return PopScope(
      canPop: !_opened && !_showSignup,
      onPopInvoked: (pop) async {
        debugPrint("$_showSignup || $opened");
        if (_showSignup || _opened) {
          setState(() {
            opened = false;
            _opened = false;
            _showSignup = false;
          });
          // return false;
        }
        // return false;
      },
      child: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          return Stack(
            children: [
              Scaffold(
                  backgroundColor: Globals.primaryBackground,
                  body: CustomScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        stretch: false,
                        snap: false,
                        expandedHeight: 100,
                        flexibleSpace: FlexibleSpaceBar(
                          title: data.me != null
                              ? Text("${prettyNumber(data.me!.balance)}CFA")
                              : const Text(Globals.appName),
                          stretchModes: const [
                            StretchMode.blurBackground,
                          ],
                        ),
                        automaticallyImplyLeading: false,
                        backgroundColor: Globals.primaryBackground,
                        elevation: 0,
                        foregroundColor: Colors.black,
                        actions: [
                          IconButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt(
                                    "finale",
                                    DateTime.now()
                                        .add(const Duration(days: 94))
                                        .millisecondsSinceEpoch);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.upload,
                                color: Colors.white,
                              )),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => ConfirmTeam(
                                //             teamID: data.me!.teamID)));
                                // return;

                                if (auth.currentUser != null) {
                                  Navigator.push(context,
                                      LeftTransition(child: const TopUp()));
                                } else {
                                  _showSignup = true;
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    if (false)
                                      const Text(
                                        "Top Up",
                                        style: Globals.whiteText,
                                      ),
                                    if (false)
                                      Lottie.asset("$dir/add1.json",
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.contain),
                                    const SizedBox(width: 8),
                                    Icon(
                                      auth.currentUser != null
                                          ? FontAwesomeIcons.plus
                                          : FontAwesomeIcons
                                              .arrowRightToBracket,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    if (false)
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            Globals.primaryBackground,
                                        shape: const CircleBorder(),
                                        onPressed: () {
                                          _launchUrl(data);
                                        },
                                        child: const Icon(
                                            FontAwesomeIcons.signIn,
                                            size: 15),
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
                              Navigator.push(context,
                                  LeftTransition(child: const WaveScreen()));
                            }
                          },
                          customBorder: Globals.radius(16),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Card(
                                      shape: CircleBorder(),
                                      child: SizedBox(
                                        height: 8,
                                        width: 8,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Card(
                                      shape: CircleBorder(),
                                      child: SizedBox(
                                        height: 8,
                                        width: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Card(
                                      shape: CircleBorder(),
                                      child: SizedBox(
                                        height: 8,
                                        width: 8,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Card(
                                      shape: Globals.radius(4),
                                      child: const SizedBox(
                                        height: 8,
                                        width: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        forceElevated: false,
                        scrolledUnderElevation: 0,
                        // title: const Text(
                        //   Globals.appName,
                        //   style: Globals.whiteText,
                        // ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          height: size.height * .85,
                          width: size.width,
                          child: AnimatedBuilder(
                              animation: _repeatAnimation,
                              builder: (context, child) {
                                return AnimatedBuilder(
                                    animation: _animation2Controller,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6),
                                                        child: SizedBox(
                                                            height: size.width,
                                                            width: size.width,
                                                            child: Stack(
                                                              children: [
                                                                HoneyPot(),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child: CountDownText(
                                                                      due: _mainDuration,
                                                                      longDateName: true,
                                                                      finishedText: "No more Entries",
                                                                      style: GoogleFonts.jost(
                                                                        fontSize:
                                                                            30,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                )
                                                              ],
                                                            ))),
                                                    GestureDetector(
                                                      onTap: () {
                                                        HapticFeedback
                                                            .heavyImpact();
                                                        Navigator.push(
                                                            context,
                                                            LeftTransition(
                                                                child:
                                                                    TransactionHistory()));
                                                      },
                                                      child: SizedBox(
                                                        width: size.width * .8,
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 18.0),
                                                          child: Text(
                                                            "Tap to view transaction history.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Roboto",
                                                                color: Color(
                                                                    0xff666666),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: kToolbarHeight,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 18.0),
                                                      child: SizedBox(
                                                        height: kToolbarHeight,
                                                        width: size.width,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showCupertinoDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              CupertinoAlertDialog(
                                                                                title: const Text("HoneyPot Contest"),
                                                                                content: const Column(
                                                                                  children: [
                                                                                    Text(
                                                                                      "Here everyone has a chance at the honeypot, Nobody is favored and we calculate points from the beginning of the season.\nThis Contest is the longest and has to do will Shear will and analyses of participants in order to win.\nParticipants can enter at anytime right up to GameWeek 10, after which we no longer accept new participants.\nThere will be a total of 30 winners at the end of the PL season",
                                                                                      textAlign: TextAlign.left,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                actions: [
                                                                                  CupertinoDialogAction(
                                                                                    child: const Text("Okay"),
                                                                                    isDefaultAction: true,
                                                                                    textStyle: Globals.primaryText,
                                                                                    onPressed: () => Navigator.pop(context),
                                                                                  )
                                                                                ],
                                                                              ));
                                                                },
                                                                child:
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
                                                                      "  Entry Fee:",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "OpenSans",
                                                                        fontSize:
                                                                            14,
                                                                        color: Globals
                                                                            .primaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 25.0,
                                                              ),
                                                              const Text(
                                                                "2,000 CFA",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Globals
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 25.0),
                                                              Material(
                                                                shape:
                                                                    const CircleBorder(),
                                                                elevation: 10,
                                                                color: Colors
                                                                    .white,
                                                                surfaceTintColor:
                                                                    Globals
                                                                        .primaryColor,
                                                                shadowColor: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .09),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    showCupertinoDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              CupertinoAlertDialog(
                                                                        content:
                                                                            const Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(" - 1st Place: 20% of the total Jackpot"),
                                                                            Text("   - 2nd Place: 15% of the total Jackpot"),
                                                                            Text(" - 3rd Place: 10% of the total Jackpot"),
                                                                            Text(" - 4th - 10th Place: Equal share of 20% of the total Jackpot"),
                                                                            Text("- 11th - 20th Place: Equal share of 15% of the total Jackpot"),
                                                                            Text("- 21st - 30th Place: Equal share of 10% of the total Jackpot"),
                                                                            Text("You can join right up to Game Week 26"),
                                                                            SizedBox(height: 5),
                                                                            Text("Note: The people eligible for the HoneyPot money are the ones who put in their money before the gameweek starts"),
                                                                          ],
                                                                        ),
                                                                        actions: [
                                                                          CupertinoDialogAction(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, true),
                                                                            isDefaultAction:
                                                                                true,
                                                                            isDestructiveAction:
                                                                                false,
                                                                            child:
                                                                                const Text(
                                                                              "Join Now",
                                                                              style: Globals.primaryText,
                                                                            ),
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, false),
                                                                            isDefaultAction:
                                                                                false,
                                                                            isDestructiveAction:
                                                                                true,
                                                                            child:
                                                                                const Text(
                                                                              "Cancel",
                                                                              style: Globals.subtitle,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                        title: const Text(
                                                                            "Number of Winners and Prizes"),
                                                                      ),
                                                                    ).then(
                                                                        (value) {
                                                                      if (value ==
                                                                          true) {
                                                                        data.joinJackpot();
                                                                      }
                                                                    });

                                                                    // Navigator.push(
                                                                    //     context,
                                                                    //     LeftTransition(
                                                                    //         child:
                                                                    //             const TopUp()));
                                                                  },
                                                                  customBorder:
                                                                      const CircleBorder(),
                                                                  child:
                                                                      const Padding(
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
                      ])),
                      SliverList(
                          delegate:
                              SliverChildListDelegate([const GroupGamelist()]))
                    ],
                  )),
              AnimatedPositioned(
                bottom: 0,
                height: _opened ? size.height * .85 : kToolbarHeight * 2,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 1200),
                child: ClipRRect(
                  child: DecoratedBox(
                    decoration: BoxDecoration(boxShadow: [
                      if (_opened)
                        BoxShadow(
                            blurRadius: 200,
                            spreadRadius: 60,
                            color: Globals.primaryColor.withOpacity(.15))
                    ]),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Material(
                        shadowColor: Globals.primaryColor.withOpacity(.7),
                        elevation: 20,
                        shape: Globals.radius(36),
                        color: Globals.primaryBackground.withOpacity(.42),
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
                                  child: DragNotch(flipCallback: () {
                                    setState(() {
                                      _opened = !_opened;
                                    });
                                  }, pullDown: () {
                                    setState(() {
                                      _opened = false;
                                    });
                                  }, pullUp: () {
                                    setState(() {
                                      _opened = true;
                                    });
                                  }),
                                ),
                              ),
                              players.isEmpty
                                  ? AnimatedContainer(
                                      duration: Globals.mainDuration,
                                      curve: Curves.fastEaseInToSlowEaseOut,
                                      height: _opened ? 170 : 0,
                                      child: ListView(
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(top: 108.0),
                                        children: [
                                          SizedBox(
                                            child: MaterialButton(
                                                height: 50,
                                                shape: Globals.radius(18),
                                                color:
                                                    Globals.primaryBackground,
                                                elevation: 0,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  toast(
                                                      message:
                                                          "procedure for joining");
                                                },
                                                child: const Text(
                                                    "No players in leage yet")),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: NotificationListener<
                                          ScrollNotification>(
                                        onNotification: (scrollNotification) {
                                          if (scrollNotification
                                                  is ScrollEndNotification &&
                                              scrollNotification
                                                      .metrics.extentAfter ==
                                                  0) {
                                            HapticFeedback.heavyImpact();
                                            data.loadFantasyGroup(more: true);
                                          }
                                          return false;
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Globals.mainDurationLonger,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: players.length,
                                                  physics:
                                                      const BouncingScrollPhysics(
                                                          parent:
                                                              AlwaysScrollableScrollPhysics()),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 1,
                                                      vertical: 10),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final player =
                                                        players[index];
                                                    return PlayerTile(
                                                        index: index,
                                                        manager: player);

                                                    // return TransactionTile(
                                                    //     onPressed: () {},
                                                    //     title: "Mr Melo FC",
                                                    //     fees: Random().nextInt(120).toString(),
                                                    //     subtitle: "${index + 1}",
                                                    //     icon: FontAwesomeIcons.shieldHeart);
                                                  },
                                                ),
                                              ),
                                              AnimatedContainer(
                                                  duration:
                                                      Globals.mainDuration,
                                                  color:
                                                      Globals.primaryBackground,
                                                  curve: Curves
                                                      .fastEaseInToSlowEaseOut,
                                                  width: size.width,
                                                  height: data.loadingManagers
                                                      ? 90
                                                      : 0,
                                                  child: Lottie.asset(
                                                      "$dir/loading5.json"))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
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
                                  data.loadTransactions();
                                  Navigator.push(
                                      context,
                                      LeftTransition(
                                          child: TransactionHistory()));
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
                                auth
                                    .signOut()
                                    .then((value) =>
                                        toast(message: "Signout Complete"))
                                    .catchError((onError) {
                                  toast(message: "Error logging out");
                                });
                              },
                              title: const Text(
                                "Signout",
                                style: Globals.primaryText,
                              ),
                              trailing: const Icon(FontAwesomeIcons.signOutAlt,
                                  size: 15),
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
                                            foregroundColor:
                                                Globals.primaryBackground,
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
                                          const SizedBox(height: 20),
                                          const Text(
                                            "Signup with Phone",
                                            style: TextStyle(
                                                color: Color(0xff999999)),
                                          )
                                        ],
                                      ),
                                      if (false)
                                        Column(
                                          children: [
                                            FloatingActionButton(
                                              heroTag: "Google",
                                              backgroundColor:
                                                  Globals.primaryBackground,
                                              foregroundColor:
                                                  Globals.primaryColor,
                                              onPressed: () async {
                                                await Globals.googleSignup();
                                              },
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
              ),
              AnimatedPositioned(
                  curve: Curves.fastEaseInToSlowEaseOut,
                  left: 0,
                  right: 0,
                  top: 0,
                  height: !data.showLoader ? 0 : size.height,
                  duration: Globals.mainDuration,
                  child: Material(
                    elevation: 0,
                    color: Colors.transparent,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black.withOpacity(.7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset("$dir/loading5.json",
                                  width: 80, height: 80),
                              const Text(
                                "Checking details, please wait",
                                style: Globals.whiteText,
                              )
                            ],
                          ),
                        ).animate(target: data.showLoader ? 1 : 0, effects: [
                          const FadeEffect(
                              begin: 0,
                              end: 1,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Globals.mainDurationLonger),
                          const ScaleEffect(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.bottomCenter)
                        ]),
                      ],
                    ),
                  )),
              if (auth.currentUser != null)
                AnimatedPositioned(
                    duration: Globals.mainDurationLonger,
                    curve: Curves.fastLinearToSlowEaseIn,
                    left: 0,
                    top: 0,
                    width: size.width,
                    height: size.height,
                    child: AnimatedSwitcher(
                      duration: Globals.mainDuration,
                      switchInCurve: Curves.fastEaseInToSlowEaseOut,
                      switchOutCurve: Curves.fastLinearToSlowEaseIn,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: Globals.verified
                          ? const SizedBox.shrink()
                          : Material(
                              elevation: 0,
                              color: Globals.white,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 9,
                                  sigmaY: 9,
                                ),
                                child: SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      YoutubePlayer(
                                        onReady: () {
                                          // _controller.addListener();
                                          // _controller.toggleFullScreenMode();
                                          _controller!.play();
                                        },
                                        controller: _controller!,
                                        showVideoProgressIndicator: true,
                                      ),
                                      const Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Text(
                                              "Connect your team",
                                              textAlign: TextAlign.center,
                                              style: Globals.heading,
                                            ),
                                          ),
                                          space,
                                          ListTile(
                                            title: Text(
                                              "Login to your FPL account",
                                              style: Globals.title,
                                            ),
                                            subtitle: Text(
                                              "You can create a new one or reset your password",
                                              style: Globals.greySubtitle,
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "What to note",
                                              style: Globals.title,
                                            ),
                                            subtitle: Text(
                                              "You can only associate your Team to one account",
                                              style: Globals.greySubtitle,
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Limitations",
                                              style: Globals.title,
                                            ),
                                            subtitle: Text(
                                              "You can only get your ID by using logging into a web browser and not the FPL App",
                                              style: Globals.greySubtitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 58.0),
                                        child: MaterialButton(
                                          onPressed: () {
                                            _launchUrl(data);
                                          },
                                          height: 55,
                                          color: Globals.primaryColor,
                                          minWidth: size.width * .8,
                                          textColor: Globals.white,
                                          elevation: 20,
                                          child: const Text("Get your Team ID"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ))
            ],
          );
        },
      ),
    );
  }

  final YoutubePlayerController? _controller = Globals.verified
      ? null
      : YoutubePlayerController(
          initialVideoId: '5vXiVHdyxuY',
          flags: const YoutubePlayerFlags(
            forceHD: true,
            loop: false,
            autoPlay: false,
            mute: true,
          ),
        );

  final Uri _url = Uri.parse('https://users.premierleague.com/');

  final TextEditingController _userIDController = TextEditingController();

  Future<void> _launchUrl(DataProvider data) async {
    _controller!.pause();
    await launchUrl(_url).then((value) {
      if (value) {
        showCupertinoDialog(
            context: context,
            builder: (_) {
              return CupertinoAlertDialog(
                title: const Text("Enter your account ID"),
                content: Column(
                  children: [
                    const Text(
                        "Your account id helps us associate your account with us with your actual TEAM."),
                    space,
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shadowColor: Globals.primaryBackground.withOpacity(.2),
                      margin: EdgeInsets.zero,
                      child: TextField(
                        controller: _userIDController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.jost(
                          color: Globals.primaryBackground,
                        ),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            hintText: "Enter ID Number",
                            label: const Text("Manager ID"),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Globals.primaryColor, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            suffix: FloatingActionButton.small(
                              heroTag: "dfklajdkl",
                              shape: const CircleBorder(),
                              backgroundColor: Globals.primaryBackground,
                              onPressed: () async {
                                int res = int.tryParse(
                                        _userIDController.text.trim()) ??
                                    0;
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt("userID", res).then(
                                    (value) => {
                                          _userIDController.text = '',
                                          Navigator.pop(context, res)
                                        });
                              },
                              child: const Icon(FontAwesomeIcons.arrowRight,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      textStyle: const TextStyle(color: Color(0xff000000)),
                      isDefaultAction: false,
                      child: const Text("Try again")),
                  CupertinoDialogAction(
                    textStyle: const TextStyle(color: Color(0xff999999)),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    isDefaultAction: false,
                    child: const Text("Cancel"),
                  ),
                ],
              );
            }).then((value) {
          if (value.runtimeType == int) {
            // toast(message: "Done");
            data.searchManager(value);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ConfirmTeam(teamID: value)));
          } else if (value == true) {
            Future.delayed(Duration.zero, () {
              _launchUrl(data);
            });
          }
        });
      }
    });
  }
}
