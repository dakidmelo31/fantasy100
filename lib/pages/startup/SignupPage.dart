import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/current_user.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/globals.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  Widget? _countdown;

  bool _nowOTP = false;

  bool privacyPolicy = false;
  bool terms = false;

  bool flipping = false;

  String _location = "";

  @override
  void initState() {
    _formState = LoginState.login;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    debugPrint((33).toString());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Globals.black,
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (false)
                    Positioned(
                      top: 0,
                      bottom: -10,
                      left: 0,
                      right: 0,
                      child: Lottie.asset(
                        "$dir/otp5.json",
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                  if (_formState == LoginState.login)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Lottie.asset("assets/lottie/walking3.json",
                          fit: BoxFit.cover),
                    ).animate(
                      target: _formState == LoginState.login ? 1 : 0,
                      autoPlay: true,
                      effects: const [
                        ScaleEffect(
                            delay: Duration(milliseconds: 30),
                            begin: Offset(
                              0,
                              0,
                            ),
                            end: Offset(1, 1))
                      ],
                    ),
                  if (_nowOTP)
                    Align(
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/lottie/swap2.json",
                          fit: BoxFit.cover,
                          width: size.width,
                          height: size.width),
                    ),
                  Positioned(
                    top: 0,
                    width: size.width,
                    left: 0,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * .1),
                        child: Column(
                          children: [
                            Text(
                              "Signup",
                              style: GoogleFonts.codystar(
                                fontWeight: FontWeight.w700,
                                fontSize: 45.0,
                                color: Globals.primaryColor,
                              ),
                            ),
                            Text(
                              "Signup is Fast & Free",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                        child: child,
                      );
                    },
                    child: _nowOTP
                        ? Align(
                            alignment: Alignment.center, //change animation
                            child: Lottie.asset('$dir/otp5.json',
                                fit: BoxFit.contain,
                                height: size.width * 1,
                                width: size.width * 1,
                                alignment: Alignment.center,
                                repeat: true,
                                options: LottieOptions(enableMergePaths: true)),
                          )
                        : null,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Globals.mainDurationLonger,
                            color: Colors.transparent,
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: size.width,
                            height: switchIt ? 70.0 : size.height * .56,
                            child: Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              elevation: 15.0,
                              shadowColor: Colors.black.withOpacity(.15),
                              surfaceTintColor: Globals.primaryColor,
                              color: Colors.white,
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  switchOutCurve: Curves.fastLinearToSlowEaseIn,
                                  transitionBuilder: (child, animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  child: switchIt
                                      ? TextField(
                                          maxLength: 6,
                                          controller: _otpController,
                                          onChanged: (val) {
                                            if (val.length == 6) {
                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                              debugPrint("valid now");
                                              // FocusManager().primaryFocus?.unfocus();
                                            } else {}
                                          },
                                          keyboardType: TextInputType.phone,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18.0,
                                              letterSpacing: 14.0),
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: "6 Numbers",
                                            label: Text("Request OTP",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14.0,
                                                    letterSpacing: 6.0)),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20.0),
                                            border: InputBorder.none,
                                          ),
                                        )
                                      : AbsorbPointer(
                                          absorbing:
                                              _formState == LoginState.otpSent,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                maxLength: 8,
                                                controller: _referralController,
                                                onChanged: (val) {
                                                  setState(() {
                                                    _referralController.text
                                                        .toUpperCase();
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                decoration: InputDecoration(
                                                  hintText: "8 characters",
                                                  label: Text('Referral Code',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 14.0,
                                                      )),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20.0),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              TextFormField(
                                                maxLength: 9,
                                                controller: _numberController,
                                                onChanged: (val) {
                                                  if (val.length == 9) {
                                                    FocusManager
                                                        .instance.primaryFocus!
                                                        .unfocus();
                                                    debugPrint("valid now");
                                                    // FocusManager().primaryFocus?.unfocus();
                                                  } else {}
                                                },
                                                validator: (val) {
                                                  if (val != null &&
                                                      val.length == 9) {
                                                    // FocusManager.instance.primaryFocus!.unfocus();
                                                    debugPrint("valid now");
                                                    FocusManager()
                                                        .primaryFocus
                                                        ?.unfocus();
                                                    setState(() {
                                                      // _inputState = SignupState.valid;
                                                    });

                                                    debugPrint(
                                                        "Verified phone");
                                                    return null;
                                                  } else {
                                                    debugPrint(
                                                        "Phone number invalid");
                                                    setState(() {
                                                      // _inputState = SignupState.invalid;
                                                    });
                                                  }
                                                  return "Enter phone number";
                                                },
                                                keyboardType:
                                                    TextInputType.phone,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18.0,
                                                    letterSpacing: 14.0),
                                                decoration: InputDecoration(
                                                  hintText: "(+237)",
                                                  label: Text("Phone",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  6.0)),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20.0),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Column(
                                                children: [
                                                  Text(
                                                      "By using this application:"),
                                                  ListTile(
                                                    enableFeedback: true,
                                                    dense: true,
                                                    trailing: Switch.adaptive(
                                                      value: privacyPolicy,
                                                      activeColor:
                                                          Globals.primaryColor,
                                                      onChanged: (va) {
                                                        setState(() {
                                                          privacyPolicy = va;
                                                        });
                                                      },
                                                    ),
                                                    title: Text(
                                                        "You accept our Privacy Policy"),
                                                    subtitle:
                                                        Text("Tap to read"),
                                                    onTap: () =>
                                                        Globals.toast("msg"),
                                                  ),
                                                  ListTile(
                                                      enableFeedback: true,
                                                      dense: true,
                                                      title: Text(
                                                          "Accept our term of use"),
                                                      subtitle:
                                                          Text("Tap to read"),
                                                      onTap: () =>
                                                          Globals.toast("msg"),
                                                      trailing: Switch.adaptive(
                                                        activeColor: Globals
                                                            .primaryColor,
                                                        value: terms,
                                                        onChanged: (va) {
                                                          setState(() {
                                                            terms = va;
                                                          });
                                                        },
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                                child: child,
                              );
                            },
                            child: _countdown,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: size.width,
                    child: Card(
                      margin: EdgeInsets.zero,
                      surfaceTintColor: Colors.white,
                      elevation: 25.0,
                      color: Globals.primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(160),
                              topRight: Radius.circular(160))),
                      child: SizedBox(
                        width: size.width,
                        height: 140.0,
                      ),
                    ).animate(
                      target: terms &&
                              privacyPolicy &&
                              (_numberController.text.trim().length == 9 ||
                                  _formState == LoginState.otpSent)
                          ? 1
                          : 0,
                      autoPlay: true,
                      effects: const [
                        ScaleEffect(
                            begin: Offset(0, -150),
                            end: Offset(1, 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.bottomCenter,
                            delay: Duration(milliseconds: 50))
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: size.width,
                    child: Card(
                      margin: EdgeInsets.zero,
                      surfaceTintColor: const Color(0xFF003926),
                      elevation: 25.0,
                      color: Globals.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(160),
                              topRight: Radius.circular(160))),
                      child: AbsorbPointer(
                        absorbing: _nowOTP,
                        child: InkWell(
                          customBorder: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(160),
                                  topRight: Radius.circular(160))),
                          onTap: () async {
                            HapticFeedback.heavyImpact();
                            if (_formState == LoginState.login) {
                              await requestCode().then((value) {});
                            }
                          },
                          child: SizedBox(
                            width: size.width,
                            height: 120.0,
                            child: Center(
                                child: Text("Send Code",
                                    style: GoogleFonts.robotoCondensed(
                                        fontSize: 20.0, color: Colors.white))),
                          ),
                        ),
                      ),
                    ).animate(
                      target: terms &&
                              privacyPolicy &&
                              (_numberController.text.trim().length == 9 ||
                                  _formState == LoginState.otpSent)
                          ? 1
                          : 0,
                      autoPlay: true,
                      effects: const [
                        ScaleEffect(
                            begin: Offset(0, -150),
                            end: Offset(1, 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 900),
                            alignment: Alignment.bottomCenter,
                            delay: Duration(milliseconds: 170))
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: size.width,
                    child: Card(
                      margin: EdgeInsets.zero,
                      surfaceTintColor: Globals.primaryColor,
                      elevation: 25.0,
                      color: Globals.primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(160),
                              topRight: Radius.circular(160))),
                      child: InkWell(
                        customBorder: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(160),
                                topRight: Radius.circular(160))),
                        onTap: () async {
                          HapticFeedback.heavyImpact();
                          await verifyCode().then((value) {});
                        },
                        child: SizedBox(
                          width: size.width,
                          height: 110.0,
                          child: Center(
                              child: Text("Verify Code",
                                  style: GoogleFonts.robotoCondensed(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400))),
                        ),
                      ),
                    ).animate(
                      target: _otpController.text.trim().length == 6 && switchIt
                          ? 1
                          : 0,
                      autoPlay: true,
                      effects: const [
                        ScaleEffect(
                            begin: Offset(0, -150),
                            end: Offset(1, 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 1300),
                            alignment: Alignment.bottomCenter,
                            delay: Duration(milliseconds: 80))
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: AnimatedContainer(
                      duration: Globals.mainDuration,
                      color: Colors.black.withOpacity(.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          mainLoader,
                          Text(
                            "Please Wait",
                            style: Globals.whiteText,
                          ),
                        ],
                      ),
                    ),
                  ).animate(
                    target: flipping ? 1 : 0,
                    effects: [
                      const FadeEffect(
                          duration: Globals.mainDuration,
                          curve: Curves.easeInSine),
                      const ScaleEffect(
                          duration: Globals.mainDuration,
                          alignment: Alignment.bottomCenter,
                          curve: Curves.fastLinearToSlowEaseIn),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  late LoginState _formState;
  String verificationCode = '';
  bool switchIt = false;
  Future<void> requestCode() async {
    debugPrint("+237${_numberController.text.trim()}");

    setState(() {
      flipping = true;
    });

    await auth.verifyPhoneNumber(
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          _formState = LoginState.login;
        });
      },
      forceResendingToken: 2,
      phoneNumber: "+237${_numberController.text.trim()}",
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          flipping = false;
          _nowOTP = true;
        });
        _countdown = CountDownText(
          finishedText: "",
          daysTextLong: "",
          hoursTextShort: "",
          minutesTextShort: " M : ",
          secondsTextShort: "S",
          showLabel: true,
          style: GoogleFonts.poppins(shadows: [
            BoxShadow(
                spreadRadius: 8,
                blurRadius: 10,
                color: Colors.black.withOpacity(.15)),
          ], fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.white),
          due: DateTime.now().add(const Duration(seconds: 70)),
        );
        debugPrint("OTP has been sent");
        Globals.toast("Verification code sent");
        setState(() {
          _formState = LoginState.otpSent;
          debugPrint("$_formState");
          verificationCode = verificationId;
          debugPrint("Verification Code: $verificationId");
          switchIt = true;
        });

        //Verify OTP
        Future.delayed(const Duration(seconds: 70), () {
          if (mounted) {
            setState(() {
              _nowOTP = false;
              _countdown = TextButton(
                  onPressed: () {
                    setState(() {
                      _formState = LoginState.login;
                      flipping = false;
                      switchIt = false;
                    });
                  },
                  child: Text(
                    "Change Number",
                    style: GoogleFonts.poppins(
                        color: Globals.primaryColor,
                        fontWeight: FontWeight.w600),
                  ));
            });
          }
        });
      },
      verificationCompleted: (phoneAuthCredential) {
        auth.signInWithCredential(phoneAuthCredential).then((value) async {
          //Now generate referral code

          String phone = _numberController.text.trim();
          List<String> rc0 = phone.substring(1, phone.length).split("");
          rc0 = rc0.reversed.toList();
          String rc = "";
          for (var item in rc0) {
            rc += item;
          }

          if (value.user != null) {
            Globals.flipSettings(field: "signedUp");

            await messaging.subscribeToTopic("${auth.currentUser!.uid}_msg");
            await messaging
                .subscribeToTopic("${auth.currentUser!.uid}_transfer");
            await messaging.subscribeToTopic("${auth.currentUser!.uid}_ticket");
            await messaging.subscribeToTopic("${auth.currentUser!.uid}_momo");

            final snap =
                await firestore.collection("users").doc(value.user!.uid).get();

            await messaging.subscribeToTopic("general");

            if (snap.exists) {
              if (snap.data()!.containsKey("deleted")) {
                toast(message: "Already Signed Up")
                    .then((value) => toast(message: "Contact Us"));
                return;
              }

              if (snap.data()!['teamID'] > 0) {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("verified", true);
              }

              Future.delayed(Duration.zero, () {
                debugPrint("Returning user coming");
                Globals.signup(phone);

                Restart.restartApp();
              });

              // Restart.restartApp();
            } else {
              String referrer = _referralController.text.trim();

              if (referrer.isNotEmpty) {
                final snap = await firestore
                    .collection("users")
                    .where("referralCode", isEqualTo: referrer)
                    .get();
                if (snap.docs.isNotEmpty) {
                  referrer = snap.docs.first.id;
                }
              }

              List<String> triedRcs = [];
              debugPrint("Testing for $rc");

              while (true) {
                if (triedRcs.contains(rc)) {
                  rc = Globals.referralCodeGen();
                  continue;
                }
                final snap = await firestore
                    .collection("users")
                    .where("referralCode", isEqualTo: rc)
                    .get();
                if (snap.docs.isNotEmpty) {
                  rc = Globals.referralCodeGen();
                  continue;
                } else {
                  break;
                }
              }

              final myData = CurrentUser(
                  phone: "+237${_numberController.text.trim()}",
                  referralCode: rc,
                  balance: 0,
                  photo: Globals.photoPlaceholder,
                  teamID: 0,
                  verified: false,
                  userID: '',
                  referrer: referrer,
                  referralSettled: false,
                  location: '',
                  teamName: '',
                  score: 0,
                  lastRank: 0,
                  rank: 0,
                  total: 0,
                  username: '',
                  rankSort: 0);

              await firestore
                  .collection("users")
                  .doc(value.user!.uid)
                  .set(myData.toMap(), SetOptions(merge: true))
                  .then((value) async {
                toast(message: "Almost there");

                String referer = _referralController.text.trim().toUpperCase();
                if (referer.isNotEmpty) {
                  final snap = await firestore
                      .collection("users")
                      .where("referralCode", isEqualTo: referer)
                      .get();

                  if (snap.docs.isNotEmpty) {
                    debugPrint("User was Referred");

                    var item = snap.docs.first;
                    firestore.collection("users").doc(item.id).update({
                      "points": FieldValue.arrayUnion([
                        {
                          "userID": auth.currentUser!.uid,
                          'redeemed': false,
                          "amount": 0
                        }
                      ]),
                    });
                    Globals.localNotification(
                      image: Globals.photoPlaceholder,
                      title: "Welcome to ${Globals.appName} 😊👌",
                      body:
                          "Join our Jackpot competition with 2,000 CFA and compete for the cash prize",
                    );
                    Globals.sendGeneralNotification(
                        ticketID: '',
                        receiverID: item.id,
                        type: "general",
                        title: "🤸🤳Great, you referred a new user",
                        message:
                            "👏Great job referring a new user, You stand a chance to earn a cut💵 of any winnings your friend makes",
                        image: Globals.photoPlaceholder);

                    Globals.signup(phone);

                    Future.delayed(Duration.zero, () {
                      Restart.restartApp();
                    });
                  } else {
                    debugPrint("Local Notification");
                    Globals.localNotification(
                        image:
                            'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg?w=740',
                        title: "Welcome to ${Globals.appName} 😊👌",
                        body:
                            "Registration complete, now you can top up and play");

                    Globals.signup(phone);

                    Future.delayed(Duration.zero, () {
                      Restart.restartApp();
                    });
                  }
                }
              });
            }
          } else {
            toast(message: "Failed to signup, try again later");
          }
        }).catchError((onError) async {
          debugPrint("Failed to login");
          await auth.signOut();
          setState(() {
            switchIt = false;
            _formState = LoginState.login;
          });
          toast(message: "Network problem, try again");
        });
      },
      verificationFailed: (error) {
        setState(() {
          flipping = false;
        });
        if (error.toString().contains("network")) {
          toast(message: "Network problem, try again");
        } else {
          toast(message: "Failed to login");
        }
        debugPrint("Error found creating account");
        debugPrint(error.toString());
        setState(() {
          // _formState = LoginState.login;
        });
      },
      timeout: const Duration(milliseconds: 70),
    );
  }

  Future<void> verifyCode() async {
    setState(() {
      flipping = true;
    });

    auth
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationCode,
        smsCode: _otpController.text.trim(),
      ),
    )
        .then((value) async {
      //Now generate referral code

      String phone = _numberController.text.trim();
      List<String> rc0 = phone.substring(1, phone.length).split("");
      String rc = '';
      rc0 = rc0.reversed.toList();

      for (var item in rc0) {
        rc += item;
      }

      if (value.user != null) {
        Globals.flipSettings(field: "signedUp");

        String topic = "${auth.currentUser!.uid}_msg";

        final snap =
            await firestore.collection("users").doc(value.user!.uid).get();

        await messaging.subscribeToTopic("general");

        if (snap.exists) {
          if (snap.data()!.containsKey("deleted")) {
            toast(message: "You deleted your account")
                .then((value) => toast(message: "Contact us for help"));
            return;
          }

          if (snap.data()!['teamID'] > 0) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("verified", true);
          }

          await messaging
              .subscribeToTopic(topic)
              .then((value) => debugPrint("${auth.currentUser!.uid}_msg"));
          await messaging
              .subscribeToTopic("${auth.currentUser!.uid}_momo")
              .then((value) => debugPrint("${auth.currentUser!.uid}_momo"));
          await messaging
              .subscribeToTopic("${auth.currentUser!.uid}_ticket")
              .then((value) => debugPrint("${auth.currentUser!.uid}_ticket"));
          await messaging
              .subscribeToTopic("${auth.currentUser!.uid}_transfer")
              .then((value) => debugPrint("${auth.currentUser!.uid}_transfer"));

          Future.delayed(Duration.zero, () {
            Globals.signup(phone);
            Restart.restartApp();
          });

          // Restart.restartApp();
        } else {
          String referrer = _referralController.text.trim();

          if (referrer.isNotEmpty) {
            final snap = await firestore
                .collection("users")
                .where("referralCode", isEqualTo: referrer)
                .get();
            if (snap.docs.isNotEmpty) {
              referrer = snap.docs.first.id;
            }
          }

          List<String> triedRcs = [];
          debugPrint("Testing for $rc");

          while (true) {
            if (triedRcs.contains(rc)) {
              rc = Globals.referralCodeGen();
              continue;
            }
            final snap = await firestore
                .collection("users")
                .where("referralCode", isEqualTo: rc)
                .get();
            if (snap.docs.isNotEmpty) {
              rc = Globals.referralCodeGen();
              continue;
            } else {
              break;
            }
          }
          final myData = CurrentUser(
              phone: "+237${_numberController.text.trim()}",
              referralCode: rc,
              balance: 0,
              photo: Globals.photoPlaceholder,
              teamID: 0,
              verified: false,
              userID: '',
              referrer: referrer,
              referralSettled: false,
              location: '',
              teamName: '',
              score: 0,
              lastRank: 0,
              rank: 0,
              total: 0,
              username: '',
              rankSort: 0);

          await firestore
              .collection("users")
              .doc(value.user!.uid)
              .set(myData.toMap(), SetOptions(merge: true))
              .then((value) async {
            toast(message: "Almost there");
            String topic = "${auth.currentUser!.uid}_msg";

            await messaging
                .subscribeToTopic(topic)
                .then((value) => debugPrint("${auth.currentUser!.uid}_msg"));
            await messaging
                .subscribeToTopic("${auth.currentUser!.uid}_momo")
                .then((value) => debugPrint("${auth.currentUser!.uid}_momo"));
            await messaging
                .subscribeToTopic("${auth.currentUser!.uid}_ticket")
                .then((value) => debugPrint("${auth.currentUser!.uid}_ticket"));
            await messaging
                .subscribeToTopic("${auth.currentUser!.uid}_transfer")
                .then(
                    (value) => debugPrint("${auth.currentUser!.uid}_transfer"));

            String referer = _referralController.text.trim().toUpperCase();
            debugPrint("is it here");
            if (referer.isNotEmpty) {
              debugPrint("now herereioeii");
              final snap = await firestore
                  .collection("users")
                  .where("referralCode", isEqualTo: referer)
                  .get();

              debugPrint("About to check it now");
              if (snap.docs.isNotEmpty) {
                debugPrint("User was Referred");

                var item = snap.docs.first;
                firestore
                    .collection("users")
                    .doc(item.id)
                    .update({
                      "points": FieldValue.arrayUnion([
                        {
                          "userID": auth.currentUser!.uid,
                          'redeemed': false,
                          "amount": 0
                        }
                      ]),
                    })
                    .then((value) {})
                    .then((value) {});
              } else {
                debugPrint("User was not referred");

                debugPrint("Now signing up on server");
                Globals.signup(phone);

                Future.delayed(Duration.zero, () {
                  Restart.restartApp();
                });
              }
            } else {
              debugPrint("Not going through the true");
              Globals.signup(phone);
              Restart.restartApp();
            }
          });
        }
      } else {
        toast(message: "Network problem, try again");
      }
    }).catchError((onError) async {
      debugPrint("Failed to login");
      await auth.signOut();
      setState(() {
        switchIt = false;
        _formState = LoginState.login;
      });

      toast(message: "Network problem, try again");
    });
  }
}

enum SignupState { invalid, valid }

enum LoginState { otpSent, complete, login }
