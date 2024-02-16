import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/pages/account/EditDetail.dart';
import 'package:hospital/pages/account/help_page.dart';
import 'package:hospital/pages/account/invite_friend.dart';
import 'package:hospital/pages/account/privacy_policy.dart';
import 'package:hospital/pages/account/terms_and_conditions.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:lottie/lottie.dart';

import '../../utils/globals.dart';
import 'add_car_details.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(.005),
        backgroundColor: Globals.backgroundColor,
        title: const Text("My Account"),
        foregroundColor: Globals.primaryColor,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 12.0, top: 18),
            child: Text(
              "N\$ 120.73",
              style: Globals.title,
            ),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            shadowColor: Colors.black.withOpacity(.09),
            child: SizedBox(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                          context, RightTransition(child: const HelpPage()));
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
                      Navigator.push(
                          context, RightTransition(child: InviteFriend()));
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
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            shadowColor: Colors.black.withOpacity(.09),
            child: SizedBox(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                          context,
                          LeftTransition(
                              child: const EditDetail(
                                  name: "Name",
                                  initial: "Ndoye Philip Ndula")));
                    },
                    leading: const Icon(FontAwesomeIcons.info,
                        color: Globals.primaryColor),
                    title: const Text(
                      "Name",
                      style: Globals.title,
                    ),
                    subtitle: const Text(
                      "Ndoye Philip Ndula",
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
                      Navigator.push(
                          context, LeftTransition(child: AddCarDetailsPage()));
                    },
                    leading: const Icon(FontAwesomeIcons.car,
                        color: Globals.primaryColor),
                    title: const Text(
                      "Cars",
                      style: Globals.title,
                    ),
                    subtitle: const Text(
                      "3 Cars associated with your account",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                    },
                    leading: const Icon(FontAwesomeIcons.info,
                        color: Globals.primaryColor),
                    title: const Text(
                      "Residential Address",
                      style: Globals.title,
                    ),
                    subtitle: const Text(
                      "Ndyoye Philip Ndula",
                      style: Globals.greySubtitle,
                    ),
                  ),
                  SwitchListTile(
                    value: true,
                    secondary: const Icon(FontAwesomeIcons.fingerprint),
                    onChanged: (bio) {},
                    title: const Text("Enable Biometrics"),
                  )
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
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            shadowColor: Colors.black.withOpacity(.09),
            child: SizedBox(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      HapticFeedback.heavyImpact();
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
                      Navigator.push(
                          context,
                          LeftTransition(
                              child: HubbleTermsAndConditionsPage()));
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
            child: MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26)),
              padding: const EdgeInsets.symmetric(vertical: 18),
              textColor: Globals.primaryColor,
              color: Colors.white,
              elevation: 0,
              child: const Text("I want to Close my Account"),
            ),
          ),
          const SizedBox(
            height: kToolbarHeight,
          )
        ],
      ),
    );
  }
}
