import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hospital/models/player.dart';
import 'package:hospital/pages/chat/gemini_chat.dart';
import 'package:hospital/pages/startup/SignupPage.dart';
import 'package:hospital/pages/startup/wave_screen.dart';
import 'package:hospital/pages/transactions/payment_history.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/drag_notch.dart';
import 'package:hospital/widgets/group_gamelist.dart';
import 'package:hospital/widgets/honeypot.dart';
import 'package:hospital/widgets/parking_tile.dart';
import 'package:hospital/widgets/transaction_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

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
  List<Player> players = [];

  late final DateTime _mainDuration;
  @override
  void initState() {
    final faker = Faker();
    _mainDuration = DateTime.now().add(const Duration(days: 16));
    players = List<Player>.generate(
        220,
        (index) => Player(
            userID: const Uuid().v4(),
            username: faker.person.firstName(),
            teamName: faker.company.name(),
            rank: "${Random().nextInt(200)}",
            createdAt: DateTime.now(),
            joinDate: DateTime.now(),
            playHistory: [],
            timesWon: Random().nextInt(30),
            amountPlayed: Random().nextInt(100),
            amountWon: Random().nextInt(50000),
            image: faker.image.image()))
      ..sort(
        (b, a) => int.parse(a.rank).compareTo(int.parse(b.rank)),
      );
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
          User? data;
          bool _alreadySignedUp = false;
          if (snapshot.hasData) {
            _alreadySignedUp = true;
            data = snapshot.data!;
            // debugPrint("Data: $data");
          }

          return Stack(
            children: [
              Scaffold(
                  backgroundColor: Globals.black,
                  body: CustomScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        stretch: false,
                        snap: true,
                        expandedHeight: 100,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text("Mr Melo FC"),
                          stretchModes: [
                            StretchMode.blurBackground,
                          ],
                        ),
                        automaticallyImplyLeading: false,
                        backgroundColor: Globals.black,
                        elevation: 0,
                        foregroundColor: Colors.black,
                        actions: [
                          IconButton(
                              onPressed: () async {
                                List<Message> messages = [
                                  Message(
                                      isCurrentUser: true, content: 'Hello!'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Hi there!'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'How are you?'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'I\'m doing well, thanks!'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'That\'s great to hear.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'What about you?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'I\'m doing well too.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'That\'s good.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'What are you up to today?'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'I\'m just relaxing at home.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Sounds nice.'),
                                  Message(
                                      isCurrentUser: false, content: 'It is.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'I\'m thinking about going for a walk later.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'That sounds like a good idea.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'It should be a nice day for it.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Yes, it should be.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Well, I should get going.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Okay, talk to you later.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Talk to you later.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Hi, how are you?'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'I\'m doing well, thanks. How are you?'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'I\'m doing well too.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'That\'s good to hear.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'What are you up to today?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'I\'m just relaxing at home.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Sounds nice.'),
                                  Message(
                                      isCurrentUser: true, content: 'It is.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'I\'m thinking about going for a walk later.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'That sounds like a good idea.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'It should be a nice day for it.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Yes, it should be.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Well, I should get going.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Okay, talk to you later.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Talk to you later.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Hey, what\'s up?'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Not much, just hanging out.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Cool. Me too.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'What are you up to?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Just browsing the web.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Nice. I\'m watching a movie.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'What movie?'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'It\'s called "The Shawshank Redemption."'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'I love that movie!'),
                                  Message(
                                      isCurrentUser: false, content: 'Me too.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Well, I should get back to work.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Okay, talk to you later.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Talk to you later.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Hey, what are you up to tonight?'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'I\'m not sure yet. Maybe just relaxing at home.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Sounds good. I might do the same.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Cool. Maybe we can watch a movie together.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'That sounds like a good idea.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'What movie do you want to watch?'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'I don\'t know. What do you want to watch?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'I\'m open to suggestions.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Okay, well I\'ll let you know if I think of anything.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Sounds good.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Hey, what are your plans for the weekend?'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'I\'m not sure yet. Maybe just hanging out with friends.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Sounds fun. I might do the same.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Cool. Maybe we can get together sometime.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'That sounds like a good idea.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Okay, well let me know if you\'re free.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Will do.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Hey, I was thinking about going to see a movie tonight. Are you interested?'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Sure, what movie do you want to see?'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'I don\'t know. What do you want to see?'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'I\'m open to suggestions.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Okay, well I\'ll let you know if I think of anything.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Sounds good.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Hey, what are you doing this weekend?'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'I\'m not sure yet. Maybe just hanging out with friends.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Sounds fun. I might do the same.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Cool. Maybe we can get together sometime.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'That sounds like a good idea.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Okay, well let me know if you\'re free.'),
                                  Message(
                                      isCurrentUser: true, content: 'Will do.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Hey, I was thinking about going to the park tomorrow. Are you interested?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Sure, what time?'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'How about 10am?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'That works for me.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Great! See you then.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'See you then.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Hey, I was thinking about going to see a movie tonight. Are you interested?'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Sure, what movie do you want to see?'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'I don\'t know. What do you want to see?'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'I\'m open to suggestions.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Okay, well I\'ll let you know if I think of anything.'),
                                  Message(
                                      isCurrentUser: true,
                                      content: 'Sounds good.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Hey, what are you doing this weekend?'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'I\'m not sure yet. Maybe just hanging out with friends.'),
                                  Message(
                                      isCurrentUser: false,
                                      content:
                                          'Sounds fun. I might do the same.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Cool. Maybe we can get together sometime.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'That sounds like a good idea.'),
                                  Message(
                                      isCurrentUser: true,
                                      content:
                                          'Okay, well let me know if you\'re free.'),
                                  Message(
                                      isCurrentUser: false,
                                      content: 'Will do.'),
                                ];

// Create a chat object
                                Chat chat = Chat(
                                  name: 'John Doe',
                                  profilePic: 'https://i.pravatar.cc/150',
                                  messages: messages,
                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => GeminiScreen(chat)));
                              },
                              color: Globals.primaryColor,
                              icon: Icon(FontAwesomeIcons.robot)),
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
                              Navigator.push(context,
                                  LeftTransition(child: const WaveScreen()));
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(6),
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
                                                                    const PaymentHistory()));
                                                      },
                                                      child: SizedBox(
                                                        width: size.width * .8,
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 18.0),
                                                          child: Text(
                                                            "Tap to view leaderboard.",
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
                                                              const SizedBox(
                                                                width: 25.0,
                                                              ),
                                                              const Text(
                                                                "15,000 CFA",
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
                                                                            Text("It costs 200 Frs to join the Game Week. The top 4 of participating users get the HoneyPot Split into a ratio of 60 20 10 10"),
                                                                            Text("Example:"),
                                                                            Text("If the HoneyPot is 100,000frs then the ratio would look like the following:"),
                                                                            Text("- 1st Place 60,000 cfa"),
                                                                            Text("- 2nd Place 20,000 cfa"),
                                                                            Text("- 3rd Place 10,000 cfa"),
                                                                            Text("- 4th Place 10,000 cfa"),
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
                                                                                Text(
                                                                              "Join Gameweek",
                                                                              style: GoogleFonts.poppins(color: const Color(0xff000000), fontWeight: FontWeight.w600),
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
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        snap: true,
                        backgroundColor: Globals.black,
                        expandedHeight: size.height * .3,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [
                            StretchMode.blurBackground,
                            StretchMode.zoomBackground,
                            StretchMode.fadeTitle,
                          ],
                          background: Stack(
                            children: [
                              CachedNetworkImage(
                                width: double.infinity,
                                height: double.infinity,
                                imageUrl:
                                    "https://z-p3-scontent.fdla2-1.fna.fbcdn.net/v/t39.30808-6/323635083_713393020285164_8359622157073999088_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeGVYG5gVwCBN9oUMPIDHnidQj3CTlGg1mBCPcJOUaDWYLgz0c6EYfGW2hTd8gOAjuHEZzCi22upIf9TwS0e7hag&_nc_ohc=U6TXRaDeuGIAX-Kxp0f&_nc_zt=23&_nc_ht=z-p3-scontent.fdla2-1.fna&oh=00_AfB8svYuVvbMdzaibj11ygudjy11FaHhrcK9MnxjNg0kJQ&oe=65D5EE22",
                                placeholder: (context, url) => placeholder,
                                errorWidget: (context, url, error) =>
                                    errorWidget2,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: Globals.black.withOpacity(.1),
                              )
                            ],
                          ),
                          title: const Text("Back your Team"),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([GroupGamelist()]))
                    ],
                  )),
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
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Material(
                        shadowColor: Globals.primaryColor.withOpacity(.7),
                        elevation: 20,
                        shape: Globals.radius(36),
                        color: Globals.black.withOpacity(.42),
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
                                  itemCount: players.length,
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 10),
                                  itemBuilder: (context, index) {
                                    final player = players[index];
                                    return PlayerTile(
                                        index: index, player: player);

                                    // return TransactionTile(
                                    //     onPressed: () {},
                                    //     title: "Mr Melo FC",
                                    //     fees: Random().nextInt(120).toString(),
                                    //     subtitle: "${index + 1}",
                                    //     icon: FontAwesomeIcons.shieldHeart);
                                  },
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
              )
            ],
          );
        },
      ),
    );
  }
}
