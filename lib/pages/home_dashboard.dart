import 'dart:math';
import 'dart:ui';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/weekly_competition.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/widgets/profile_section.dart';
import 'package:hospital/widgets/room_card.dart';
import 'package:hospital/widgets/skin.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/data_provider.dart';
import '../utils/transitions.dart';
import '../widgets/profiler.dart';
import '../widgets/scale_animation.dart';
import 'confirm_team.dart';
import 'startup/SignupPage.dart';

class HomeBoard extends StatefulWidget {
  const HomeBoard({super.key});
  static const routeName = "/";

  @override
  State<HomeBoard> createState() => _HomeBoardState();
}

const _heightSocial = 150.0;
const _heightLastConsume = 100.0;

class _HomeBoardState extends State<HomeBoard> with TickerProviderStateMixin {
  final PageController _pageController =
      PageController(viewportFraction: .9, initialPage: 1);
  double page = 1;
  double pageClamp = 1;
  late final AnimationController _animationController;

  double radius = 56;

  double padding = 15;
  void pageListener() {
    setState(() {
      page = _pageController.page!;
      pageClamp = page.clamp(0, 1);
    });
  }

  late bool _isTogglePage;

  ValueNotifier<double> transition = ValueNotifier<double>(1);
  ValueNotifier<double> transitionSlider = ValueNotifier<double>(1);
  ValueNotifier<double> currentPage = ValueNotifier<double>(_heightSocial);
  late final AnimationController _animation2Controller;

  late final Animation<double> _animation;
  late Animation _repeatAnimation;

  final _drawerKey = GlobalKey<ScaffoldState>();

  bool _opened = false;

  late final DateTime _mainDuration;

  @override
  void initState() {
    _isTogglePage = false;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _pageController.addListener(pageListener);

    // _pageController.addListener(() { })
    _mainDuration = DateTime.now().add(const Duration(days: 16));
    // scoreTiles.sort((a, b) => a.,)
    _animation2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animation = CurvedAnimation(
        parent: _animation2Controller, curve: Curves.fastLinearToSlowEaseIn);

    // _repeatController.repeat(reverse: true);

    _animation2Controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(pageListener);
    _pageController.dispose();
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
    final groups = [null, ...data.groups];
    final flipCondition = pageClamp < .9;

    final maxHeight = size.height;
    final maxWidth = size.width;
    final maxHeightListBack =
        (maxHeight) - (_heightSocial + _heightLastConsume);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Stack(
        children: [
          PopScope(
            canPop: page != 0 && !_opened && !_showSignup,
            onPopInvoked: (pop) async {
              debugPrint("$_showSignup || $opened");
              if (page == 0) {
                debugPrint("Back to list");
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastEaseInToSlowEaseOut);
              }
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
            child: Scaffold(
              body: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, child) {
                    final value =
                        lerpDouble(0, maxHeight, _animationController.value)!
                            .clamp(_heightSocial, maxHeight)
                            .toDouble();

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          alignment: Alignment.bottomCenter,
                          child: child),
                      child: groups.length <= 1
                          ? Center(
                              child: placeholder,
                            )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  top: size.height * .5,
                                  width: size.width,
                                  left: 100,
                                  child: Lottie.asset("$dir/ripple3.json",
                                      alignment: Alignment.bottomRight,
                                      fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: pageClamp * size.height * .275,
                                  bottom: pageClamp * size.height * .225,
                                  left: pageClamp * size.width * .1,
                                  right: pageClamp * size.width * .2,
                                  child: Transform.translate(
                                    offset: Offset(
                                      page < 1
                                          ? 0
                                          : (-1 * page * size.width +
                                              size.width),
                                      0,
                                    ),
                                    child: Opacity(
                                      opacity: page < 1 ? 1 : 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Globals.white,
                                            borderRadius: BorderRadius.circular(
                                              pageClamp * radius,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: value,
                                  bottom: page == 0 ? 0 : size.height * .2,
                                  left: 0,
                                  right: 0,
                                  child: PageView(
                                    controller: _pageController,
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    children: groups
                                        .map(((e) => e == null
                                            ? const Row(
                                                children: [
                                                  Text(""),
                                                ],
                                              )
                                            : GestureDetector(
                                                onVerticalDragUpdate:
                                                    (details) {
                                                  final newCps =
                                                      currentPage.value +
                                                          details.delta.dy;

                                                  _animationController.value =
                                                      currentPage.value /
                                                          maxHeight;

                                                  currentPage.value =
                                                      newCps.clamp(
                                                          _heightSocial,
                                                          maxHeight);

                                                  final range = maxWidth -
                                                      (maxHeight * .40);
                                                  if (details
                                                          .globalPosition.dy >
                                                      range) {
                                                    _isTogglePage = true;
                                                  } else {
                                                    _isTogglePage = false;
                                                  }
                                                },
                                                onVerticalDragEnd: (details) {
                                                  if (_isTogglePage) {
                                                    _animationController
                                                        .forward();
                                                    currentPage.value =
                                                        maxHeight;
                                                  } else {
                                                    _animationController
                                                        .reverse();
                                                    currentPage.value =
                                                        _heightSocial;
                                                  }
                                                },
                                                child: Transform.translate(
                                                  offset: Offset(
                                                      page < 1
                                                          ? (1 - pageClamp) *
                                                              150
                                                          : 0,
                                                      0),
                                                  child: RoomCard(
                                                    card: e,
                                                  ),
                                                ),
                                              )))
                                        .toList(),
                                  ),
                                ),
                                AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: page < .3
                                        ? const WeeklyCompetition()
                                        : null),
                                Positioned(
                                  top: 0,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    transitionBuilder: (child, animation) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                    child: flipCondition
                                        ? null
                                        : ProfileSection(
                                            toggleSignup: () {
                                              setState(() {
                                                _showSignup = !_showSignup;
                                              });
                                            },
                                            value: _animationController.value,
                                            // maxheight: value,
                                            maxHeight: value,
                                            maxWidth: maxWidth,

                                            closeCallback: () {
                                              _animationController.reverse();
                                            },
                                            // onTapBtnClose: () {
                                            //   _animationController.reverse();
                                            // },
                                          ),
                                  ),
                                ),
                                // if (data.loadingManagers)
                                //   AnimatedPositioned(
                                //     duration: Globals.mainDurationLonger,
                                //     curve: Curves.fastLinearToSlowEaseIn,
                                //     top: 0,
                                //     left: 0,
                                //     child: AnimatedContainer(
                                //         duration: Globals.mainDuration,
                                //         color: Globals.white,
                                //         curve: Curves.fastEaseInToSlowEaseOut,
                                //         width: double.infinity,
                                //         height: data.loadingManagers ? 90 : 90,
                                //         child: Lottie.asset("$dir/loading5.json")),
                                //   ),
                                if (_animationController.value < .7)
                                  Positioned(
                                    top: size.height * .85,
                                    left: size.height * .03,
                                    right: size.height * .03,
                                    child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        transitionBuilder: (child, animation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        child: flipCondition
                                            ? const SizedBox.shrink()
                                            : TweenAnimationBuilder(
                                                key: Key(groups[page.round()]!
                                                    .title),
                                                tween: Tween<double>(
                                                    begin: 25.0, end: 0),
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                builder:
                                                    (context, value, child) {
                                                  return Transform.translate(
                                                    offset: Offset(0, value),
                                                    child: ListTile(
                                                      leading: Hero(
                                                        tag:
                                                            "${groups[page.round()]!.title}pay_now",
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .medal,
                                                          size: 50,
                                                          color: Globals.blue,
                                                        ),
                                                      ),
                                                      title: Skin(
                                                        tag:
                                                            "${groups[page.round()]!.title + groups[page.round()]!.title}pay_now",
                                                        child: Text(groups[
                                                                page.round()]!
                                                            .title),
                                                      ),
                                                      subtitle: Text(
                                                          "${prettyNumber(groups[page.round()]!.playersID.length + Random().nextInt(1000000))} also playing"),
                                                      trailing: Card(
                                                          shadowColor: Colors
                                                              .black
                                                              .withOpacity(.3),
                                                          elevation: 15,
                                                          color: Colors.white,
                                                          surfaceTintColor:
                                                              Colors.white,
                                                          shape:
                                                              Globals.radius(8),
                                                          child: InkWell(
                                                            onTap: () {
                                                              HapticFeedback
                                                                  .heavyImpact();
                                                            },
                                                            customBorder:
                                                                Globals.radius(
                                                                    8),
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          18.0,
                                                                      vertical:
                                                                          12.0),
                                                              child:
                                                                  Text("Play"),
                                                            ),
                                                          )),
                                                    ),
                                                  );
                                                },
                                              )),
                                  ),
                              ],
                            ),
                    );
                  }),
            ),
          ),
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
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    debugPrint("${details.delta.dx}");
                    if (details.delta.dx > .3 && _showSignup) {
                      HapticFeedback.heavyImpact();
                      setState(() {
                        _showSignup = false;
                      });
                    }
                  },
                  child: Material(
                    elevation: 0,
                    color: Globals.transparent,
                    child: ListView(
                      scrollDirection: Axis.vertical,
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
                                          backgroundColor: Globals.primaryColor,
                                          foregroundColor:
                                              Globals.primaryBackground,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                LeftTransition(
                                                    child: const SignupPage()));
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
                  ).animate(target: _showSignup ? 1 : 0, effects: [
                    const BlurEffect(
                      begin: Offset(8, 9),
                      end: Offset(0, 0),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 500),
                    ),
                    const ScaleEffect(
                      begin: Offset(8, 9),
                      end: Offset(1, 1),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: Duration(milliseconds: 200),
                    )
                  ]),
                ),
              ),
            ),
          ),
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
