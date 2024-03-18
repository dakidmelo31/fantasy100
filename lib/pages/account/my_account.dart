import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/account/EditDetail.dart';
import 'package:hospital/pages/account/invite_friend.dart';
import 'package:hospital/pages/account/privacy_policy.dart';
import 'package:hospital/pages/account/terms_and_conditions.dart';
import 'package:hospital/providers/data_manager.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/globals.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  void _launchUrl() async {
    bool? outcome;

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text("Join ${Globals.appName} Today!"),
            content: const Text(
                "Download our BidWars237 app from playstore and sell your second-hand items you no longer use. There's a lot of money to be made, and our tool is just perfect for that"),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                textStyle: Globals.primaryText,
                onPressed: () async {
                  Clipboard.setData(
                      const ClipboardData(text: Globals.androidLink));
                  toast(message: "Link copied to clipboard😊");
                  const url = Globals.androidLink;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                  Navigator.pop(context, true);
                },
                child: const Text(
                  "Show Me",
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                isDefaultAction: false,
                isDestructiveAction: true,
                textStyle: Globals.title,
                child: const Text(
                  "Maybe Later",
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final data = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Globals.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withOpacity(.005),
        backgroundColor: Globals.backgroundColor,
        title: const Text("My Account"),
        foregroundColor: Globals.black,
        elevation: 0,
        forceMaterialTransparency: true,
        actions: [
          MaterialButton(
            onPressed: _launchUrl,
            padding: const EdgeInsets.all(9),
            shape: const CircleBorder(),
            color: Globals.primaryColor,
            elevation: 4,
            child: const Icon(
              FontAwesomeIcons.solidGem,
              color: Globals.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Lottie.asset("$dir/ripple3.json",
                  fit: BoxFit.fitWidth, alignment: Alignment.center)),
          Align(
              alignment: Alignment.topLeft,
              child: Lottie.asset("$dir/ripple3.json",
                  fit: BoxFit.fitWidth, alignment: Alignment.center)),
          Align(
              alignment: Alignment.centerRight,
              child: Lottie.asset("$dir/ripple6.json",
                  fit: BoxFit.fitWidth, alignment: Alignment.center)),
          Center(
              child: Lottie.asset("$dir/friends2.json",
                  alignment: Alignment.center)),
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: [
              Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                elevation: 18,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26)),
                shadowColor: Colors.black.withOpacity(.2),
                child: SizedBox(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          launchWhatsApp(
                              phoneNumber: "+237650981130",
                              message:
                                  "Hey, I need help from your app (${Globals.appName})");
                          // Navigator.push(
                          //     context, RightTransition(child: const HelpPage()));
                        },
                        leading: const Icon(FontAwesomeIcons.info,
                            color: Globals.primaryColor),
                        title: const Text("Help"),
                        trailing: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Globals.primaryColor,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(context,
                              RightTransition(child: const InviteFriend()));
                        },
                        leading: const Icon(FontAwesomeIcons.peopleGroup,
                            color: Globals.primaryColor),
                        title: const Text("Invite a friend"),
                        trailing: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Globals.primaryColor,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        trailing: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Globals.primaryColor,
                          size: 16,
                        ),
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          launchWhatsApp(
                              phoneNumber: "+237650981130",
                              message:
                                  "Hey, I need help from your app (${Globals.appName})");
                        },
                        leading: const Icon(FontAwesomeIcons.bug,
                            color: Globals.primaryColor),
                        title: const Text("Report a Bug"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: kToolbarHeight * .7,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "Settings",
                  style: Globals.heading,
                ),
              ),
              const SizedBox(
                height: kToolbarHeight * .7,
              ),
              Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                elevation: 18,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26)),
                shadowColor: Colors.black.withOpacity(.2),
                child: SizedBox(
                  child: Column(
                    children: [
                      if (data.me != null)
                        ListTile(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                                    context,
                                    LeftTransition(
                                        child: EditDetail(
                                            name: "Name",
                                            initial: data.me!.username)))
                                .then((value) => data.loadUser());
                          },
                          leading: const Icon(FontAwesomeIcons.info,
                              color: Globals.primaryColor),
                          title: const Text(
                            "Name",
                            style: Globals.title,
                          ),
                          subtitle: Text(
                            data.me!.username,
                            style: Globals.greySubtitle,
                          ),
                          trailing: const Icon(
                            FontAwesomeIcons.arrowRight,
                            color: Globals.primaryColor,
                            size: 16,
                          ),
                        ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          showCupertinoDialog(
                              context: context,
                              builder: (_) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                    "Are you Sure?",
                                    style: Globals.primaryTitle,
                                  ),
                                  content: const Text(
                                      "\nThis action is not reversible and you won't be able to get this data again.\nDo you still wish to delete?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      isDefaultAction: true,
                                      textStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Globals.primaryColor),
                                      child: const Text("Yes Delete"),
                                    ),
                                    CupertinoDialogAction(
                                      textStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          color: Globals.black),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      isDestructiveAction: true,
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              });
                        },
                        leading: const Icon(FontAwesomeIcons.signOut,
                            color: Globals.primaryColor),
                        title: const Text(
                          "Delete conversation History",
                          style: Globals.title,
                        ),
                        trailing: const Icon(
                          FontAwesomeIcons.trashArrowUp,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: kToolbarHeight * .7,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "About Us",
                  style: Globals.heading,
                ),
              ),
              const SizedBox(
                height: kToolbarHeight * .7,
              ),
              Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                elevation: 18,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26)),
                shadowColor: Colors.black.withOpacity(.2),
                child: SizedBox(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          showCupertinoDialog(
                              context: context,
                              builder: (_) {
                                return const CupertinoAlertDialog(
                                  title: Text("All you need to Know"),
                                  actions: [CloseButton()],
                                  content: Text(
                                      "Using our application is totally free and you can make unlimited amount of requests at anytime with our AI platform"),
                                );
                              });
                        },
                        leading: const Icon(FontAwesomeIcons.receipt,
                            color: Globals.primaryColor),
                        title: const Text(
                          "Fees",
                          style: Globals.title,
                        ),
                        trailing: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Globals.primaryColor,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(context,
                              LeftTransition(child: TermsAndConditionsPage()));
                        },
                        leading: const Icon(FontAwesomeIcons.fileSignature,
                            color: Globals.primaryColor),
                        title: const Text(
                          "Terms and Conditions",
                          style: Globals.title,
                        ),
                        trailing: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Globals.primaryColor,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                              context, LeftTransition(child: PrivacyPolicy()));
                        },
                        leading: const Icon(FontAwesomeIcons.userSecret,
                            color: Globals.primaryColor),
                        title: const Text(
                          "Privacy Policy",
                          style: Globals.title,
                        ),
                        subtitle: const Text(
                          "Read about our policy",
                          style: Globals.greySubtitle,
                        ),
                        trailing: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Globals.primaryColor,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          auth.signOut().then((value) => Restart.restartApp());
                        },
                        leading: const Icon(FontAwesomeIcons.signOut,
                            color: Globals.primaryColor),
                        title: const Text(
                          "Logout",
                          style: Globals.title,
                        ),
                        trailing: const Icon(
                          FontAwesomeIcons.powerOff,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: kToolbarHeight * .7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onLongPress: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) {
                          return CupertinoAlertDialog(
                            content: const Text(
                                "\nDeleting your account will prevent you from using ${Globals.appName} next time.\nWe use account for personalization and customization as we add new features. To ensure you don't lose your data with us you can simply uninstall the app and log back in at a later date."),
                            actions: [
                              CupertinoDialogAction(
                                  onPressed: () {
                                    firestore
                                        .collection("users")
                                        .doc(auth.currentUser!.uid)
                                        .delete()
                                        .then((value) => firestore
                                                .collection("users")
                                                .doc(auth.currentUser!.uid)
                                                .set({
                                              "deleted": auth.currentUser!.uid
                                            }))
                                        .then((value) => auth
                                                .signOut()
                                                .then((value) async {
                                              const secureStorage =
                                                  FlutterSecureStorage();
                                              secureStorage.deleteAll();
                                            }).then((value) =>
                                                    Restart.restartApp()));
                                  },
                                  isDestructiveAction: true,
                                  child: const Text("No, Delete")),
                              CupertinoDialogAction(
                                child: Text(
                                  "Logout",
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ),
                                onPressed: () {
                                  auth
                                      .signOut()
                                      .then((value) => Restart.restartApp());
                                },
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                isDefaultAction: true,
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.poppins(
                                      color: Globals.primaryColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: MaterialButton(
                    onPressed: () {
                      toast(message: "Long press to delete");
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26)),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textColor: Globals.primaryColor,
                    color: Colors.white,
                    elevation: 0,
                    child: const Text("I want to Close my Account"),
                  ),
                ),
              ),
              const SizedBox(
                height: kToolbarHeight,
              )
            ],
          ),
        ],
      ),
    );
  }
}
