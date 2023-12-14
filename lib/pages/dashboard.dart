import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/pages/qr_page.dart';
import 'package:hospital/pages/recommendation/recommendation_map.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/balance_card.dart';
import 'package:hospital/widgets/main_bar.dart';
import 'package:hospital/widgets/my_code.dart';
import 'package:hospital/widgets/ripple_dot.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../widgets/parking_history.dart';
import '../widgets/scan_button.dart';

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

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200));
    _repeatController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

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

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      appBar: AppBar(
        backgroundColor: Globals.backgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bars))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedBuilder(
          animation: _repeatAnimation,
          builder: (context, child) {
            return AnimatedBuilder(
                animation: _animationController,
                builder: (_, __) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          if (false)
                            RawSlideCountdown(
                              streamDuration: StreamDuration(
                                  config: StreamDurationConfig(
                                      isCountUp: true,
                                      countUpConfig: CountUpConfig(
                                          initialDuration: Duration.zero))),
                              builder: (context, duration, isCountUp) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("${duration.inHours} : "),
                                    Text("${duration.inMinutes} : "),
                                    Text("${duration.inSeconds % 60}"),
                                  ],
                                );
                              },
                            ),
                          SizedBox(
                              height: kTextTabBarHeight, child: RippleDot()),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: _repeatAnimation.value,
                                surfaceTintColor: Globals.primaryColor,
                                color: Globals.backgroundColor,
                                borderOnForeground: true,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    35 + 290 * (1 - _animation.value),
                                  ),
                                ),
                                shadowColor:
                                    Globals.primaryColor.withOpacity(.085),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Padding(
                                  padding: EdgeInsets.all(6 -
                                      (8 * (1 - _animationController.value))),
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
                                    child: const Hero(
                                        tag: "qr_code", child: MyCode()),
                                  ),
                                ),
                              ),
                              SizedBox(
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
                              const SizedBox(
                                height: kToolbarHeight,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
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
                                                color: Globals.primaryColor,
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
                                          shadowColor:
                                              Colors.black.withOpacity(.09),
                                          child: InkWell(
                                            onTap: () {},
                                            customBorder: const CircleBorder(),
                                            child: const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Icon(
                                                FontAwesomeIcons.plus,
                                                color: Globals.primaryColor,
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
                                      borderRadius: BorderRadius.circular(26)),
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
                    ],
                  );
                });
          }),
    );
  }
}
