import 'dart:ui';

import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/pages/qr_page.dart';
import 'package:hospital/pages/recommendation/recommendation_map.dart';
import 'package:hospital/pages/startup/wave_screen.dart';
import 'package:hospital/pages/transactions/payment_history.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/my_code.dart';

import '../widgets/countdown_time.dart';
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

  @override
  void initState() {
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

  bool opened = false;
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Globals.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Globals.backgroundColor,
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
                  icon: const Icon(FontAwesomeIcons.bell)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      opened = !opened;
                    });

                    if (false)
                      Navigator.push(
                          context, LeftTransition(child: const WaveScreen()));
                  },
                  icon: const Icon(FontAwesomeIcons.bars))
            ],
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
                                    Card(
                                      elevation: Globals.parked
                                          ? 0
                                          : _repeatAnimation.value,
                                      surfaceTintColor: Globals.primaryColor,
                                      color: Globals.backgroundColor,
                                      borderOnForeground: true,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          35 + 290 * (1 - _animation.value),
                                        ),
                                      ),
                                      shadowColor: Globals.primaryColor
                                          .withOpacity(.085),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      child: Padding(
                                        padding: EdgeInsets.all(6 -
                                            (8 *
                                                (1 -
                                                    _animationController
                                                        .value))),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                LeftTransition(
                                                    child: const QRPage()));

                                            if (false)
                                              Navigator.push(
                                                  context,
                                                  ConcentricPageRoute(
                                                    builder: (context) =>
                                                        const QRPage(),
                                                  ));

                                            if (false)
                                              Navigator.pushNamed(
                                                  context, QRPage.routeName);
                                          },
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              35 + 290 * (1 - _animation.value),
                                            ),
                                          ),
                                          child: Hero(
                                            tag: "qr_code",
                                            child: AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 1200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              transitionBuilder:
                                                  (child, animation) {
                                                return FadeTransition(
                                                  opacity: CurvedAnimation(
                                                      parent: animation,
                                                      curve: Curves
                                                          .fastLinearToSlowEaseIn),
                                                  child: child,
                                                );
                                              },
                                              child: Globals.parked
                                                  ? AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 1100),
                                                      curve: Curves
                                                          .fastLinearToSlowEaseIn,
                                                      height: Globals.parked
                                                          ? size.width * .95
                                                          : 0,
                                                      child: const Center(
                                                          child:
                                                              CountdownTime()))
                                                  : const MyCode(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          Globals.parked = !Globals.parked;
                                        });
                                      },
                                      child: SizedBox(
                                        width: size.width * .8,
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 18.0),
                                          child: Text(
                                            "Scan, Park, and Pay effortlessly with our innovative Technology.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                color: Color(0xff666666),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: kToolbarHeight,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 18.0),
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
                                                    FontAwesomeIcons.wallet,
                                                    size: 35,
                                                    color: Globals.primaryColor,
                                                  ),
                                                  Text(
                                                    "  Balance:",
                                                    style: TextStyle(
                                                      fontFamily: "OpenSans",
                                                      fontSize: 14,
                                                      color:
                                                          Globals.primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              const Text(
                                                "N\$ 20.0",
                                                style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Globals.primaryColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 25.0,
                                              ),
                                              Material(
                                                shape: const CircleBorder(),
                                                elevation: 10,
                                                color: Colors.white,
                                                surfaceTintColor:
                                                    Globals.primaryColor,
                                                shadowColor: Colors.black
                                                    .withOpacity(.09),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        LeftTransition(
                                                            child:
                                                                const TopUp()));
                                                  },
                                                  customBorder:
                                                      const CircleBorder(),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(14.0),
                                                    child: Icon(
                                                      FontAwesomeIcons.plus,
                                                      color:
                                                          Globals.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 16),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const RecommendationMap()));
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
                highlightColor: Colors.white,
                splashColor: Colors.white,
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
              color: Globals.white,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Material(
                  elevation: 0,
                  color: Colors.white,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kToolbarHeight,
                      ),
                      const Text(
                        "Menu",
                        style: Globals.heading,
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
                          Future.delayed(const Duration(milliseconds: 60), () {
                            Navigator.push(context,
                                LeftTransition(child: const MyAccount()));
                          });
                        },
                        title: const Text(
                          "My Account",
                          style: Globals.title,
                        ),
                        trailing:
                            const Icon(FontAwesomeIcons.userLock, size: 15),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            opened = false;
                          });
                          HapticFeedback.heavyImpact();
                          Future.delayed(const Duration(milliseconds: 60), () {
                            Navigator.push(context,
                                LeftTransition(child: const ParkingHistory()));
                          });
                        },
                        title: const Text(
                          "Parking history",
                          style: Globals.title,
                        ),
                        trailing: const Icon(FontAwesomeIcons.clockRotateLeft,
                            size: 15),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            opened = false;
                          });
                          HapticFeedback.heavyImpact();
                          Future.delayed(const Duration(milliseconds: 60), () {
                            Navigator.push(context,
                                LeftTransition(child: const PaymentHistory()));
                          });
                        },
                        title: const Text(
                          "Transaction history",
                          style: Globals.title,
                        ),
                        trailing:
                            const Icon(FontAwesomeIcons.moneyBills, size: 15),
                      ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                        },
                        title: const Text(
                          "My Cards",
                          style: Globals.title,
                        ),
                        trailing:
                            const Icon(FontAwesomeIcons.creditCard, size: 15),
                      ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                        },
                        title: const Text(
                          "Recommendations",
                          style: Globals.title,
                        ),
                        trailing: const Icon(FontAwesomeIcons.globe, size: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
