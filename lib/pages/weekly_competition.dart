import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/week_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WeeklyCompetition extends StatefulWidget {
  const WeeklyCompetition({super.key});

  @override
  State<WeeklyCompetition> createState() => _WeeklyCompetitionState();
}

class _WeeklyCompetitionState extends State<WeeklyCompetition> {
  late final CarouselController _carouselController;

  int _index = 0;
  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);
    final weeklyCompetition = data.weeklyCompetition;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: Stack(
          children: [
            // if (false)
            Image.asset("assets/4.jpg",
                fit: BoxFit.cover, width: size.width, height: size.height),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                width: size.width,
                height: size.height,
              ),
            ),
            Opacity(
              opacity: .6,
              child: Lottie.asset("$dir/bg2.json",
                  fit: BoxFit.cover, width: size.width, height: size.height),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: size.height * .5,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: kToolbarHeight),
                            child: Text(
                              "15,300 CFA",
                              style: GoogleFonts.cabin(
                                  fontSize: 35, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 26, right: 8.0),
                                  child: FloatingActionButton.small(
                                    heroTag: "add_more",
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.push(context,
                                          SizeTransition22(const TopUp()));
                                    },
                                    backgroundColor: Colors.black,
                                    shape: const CircleBorder(),
                                    elevation: 0,
                                    child: const Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        strokeAlign: 1,
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Invite Friends"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        strokeAlign: 1,
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Create Room"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8.0),
                                  child: FloatingActionButton.small(
                                    heroTag: "add_more2",
                                    onPressed: () {},
                                    backgroundColor: Colors.transparent,
                                    shape: const CircleBorder(),
                                    elevation: 0,
                                    child: const Icon(
                                      FontAwesomeIcons.info,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 250,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              pageSnapping: true,
                              scrollPhysics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              enlargeFactor: 1.9,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _index = index;
                                });
                              },
                              autoPlay: true,
                            ),
                            items: weeklyCompetition
                                .map((e) => WeeklyWidget(weekly: e))
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < weeklyCompetition.length;
                                    i++)
                                  Row(
                                    children: [
                                      if (i != 0)
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: .5, color: Colors.black),
                                          color: _index == i
                                              ? Colors.black
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
