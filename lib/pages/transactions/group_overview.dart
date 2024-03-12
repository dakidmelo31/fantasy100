import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/group.dart';
import 'package:hospital/pages/group_details.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/widgets/skin.dart';

class GroupOverview extends StatefulWidget {
  const GroupOverview({super.key, required this.manager});
  final Group manager;

  @override
  State<GroupOverview> createState() => _GroupOverviewState();
}

class _GroupOverviewState extends State<GroupOverview>
    with TickerProviderStateMixin {
  late final AnimationController _animationController,
      _secondAnimationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200));
    _secondAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 200));
    _animationController.addListener(myListener);
    _animationController.forward();

    super.initState();
  }

  void myListener() {
    if (_animationController.isCompleted) {
      _secondAnimationController.forward();
    } else {
      _secondAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: lerpDouble(0, 15, _animationController.value)!,
                  sigmaY: lerpDouble(0, 15, _animationController.value)!),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  switchInCurve: Curves.linearToEaseOut,
                  transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child)),
                  child: _animationController.value < .9
                      ? null
                      : Material(
                          elevation: 0,
                          surfaceTintColor: Colors.white,
                          shape: Globals.radius(46),
                          color: Colors.white,
                          child: SizedBox(
                              height: lerpDouble(0, size.height * .8,
                                  _animationController.value)!,
                              width: size.width * .9,
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: widget.manager.image +
                                        widget.manager.title,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(36),
                                        topRight: Radius.circular(36),
                                      ),
                                      child: CachedNetworkImage(
                                          imageUrl: widget.manager.image,
                                          height: size.height * .35,
                                          width: size.width,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: AnimatedBuilder(
                                        animation: _secondAnimationController,
                                        builder: (context, child) {
                                          return Material(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                BorderRadius.circular(36),
                                            color: Colors.white,
                                            surfaceTintColor: Colors.white,
                                            child: SizedBox(
                                              height: lerpDouble(
                                                  size.height * .27,
                                                  size.height * .65,
                                                  CurvedAnimation(
                                                          parent:
                                                              _secondAnimationController,
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut)
                                                      .value)!,
                                              child: CustomScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(
                                                        parent:
                                                            AlwaysScrollableScrollPhysics()),
                                                slivers: [
                                                  SliverAppBar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    elevation: 0,
                                                    expandedHeight: 35,
                                                    stretchTriggerOffset: 100,
                                                    onStretchTrigger: () async {
                                                      HapticFeedback
                                                          .heavyImpact();
                                                      Navigator.pop(context);
                                                    },
                                                    stretch: true,
                                                    floating: true,
                                                    pinned: true,
                                                    automaticallyImplyLeading:
                                                        false,
                                                    flexibleSpace:
                                                        FlexibleSpaceBar(
                                                      stretchModes: const [
                                                        StretchMode
                                                            .blurBackground,
                                                        StretchMode
                                                            .zoomBackground,
                                                      ],
                                                      background: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Column(
                                                          children: [
                                                            const Text(
                                                              "Winning Prizes",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Lato",
                                                                  color: Globals
                                                                      .primaryColor,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            CountDownText(
                                                                due: widget
                                                                    .manager
                                                                    .endsAt,
                                                                finishedText:
                                                                    "Competition Ended")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SliverList(
                                                      delegate:
                                                          SliverChildListDelegate([
                                                    GroupDetails(
                                                        groupID: widget
                                                            .manager.groupID),
                                                  ]))
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Positioned(
                                      left: 20,
                                      top: 40,
                                      child: Material(
                                        shape: Globals.radius(36),
                                        child: InkWell(
                                          customBorder: Globals.radius(36),
                                          onTap: () {
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CupertinoAlertDialog(
                                                title: const Text(
                                                    "Our Competition Rules"),
                                                content: const Text(
                                                    "Our Competition prizes are subjected to changes usually depending on when new managers join the competition. the number of winners can grow as well as the amount they are going to win may also increase.\nAs long as the competition is still open for entry then No fixed amount is predetermined."),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    textStyle:
                                                        Globals.primaryText,
                                                    isDefaultAction: true,
                                                    child: const Text(
                                                        "I Understand"),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Text(
                                              widget.manager.title,
                                              style: Globals.title,
                                            ),
                                          ),
                                        ),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: TweenAnimationBuilder(
                                      key: Key(widget.manager.title +
                                          widget.manager.image),
                                      tween: Tween<double>(begin: 25.0, end: 0),
                                      curve: Curves.fastEaseInToSlowEaseOut,
                                      duration:
                                          const Duration(milliseconds: 1700),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(0, value),
                                          child: child,
                                        );
                                      },
                                      child: Material(
                                        color: Colors.black,
                                        shape: Globals.radius(36),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Hero(
                                                tag:
                                                    "${widget.manager.title}pay_now",
                                                child: Card(
                                                    color:
                                                        const Color(0xff334333),
                                                    shape: const CircleBorder(),
                                                    elevation: 0,
                                                    child: InkWell(
                                                      customBorder:
                                                          const CircleBorder(),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .arrowLeft,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              Skin(
                                                  tag:
                                                      "${widget.manager.title + widget.manager.title}pay_now",
                                                  child: const Text(
                                                    "Go Back ",
                                                    style: Globals.whiteText,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                ),
              ),
            );
          }),
    );
  }
}
