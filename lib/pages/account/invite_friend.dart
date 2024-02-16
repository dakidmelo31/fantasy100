import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/globals.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 128.0),
                child: Text("Invite Friends"),
              ),
              SizedBox(
                height: 120,
                child: Lottie.asset("$dir/friends4.json",
                    width: size.width,
                    height: size.height * .6,
                    alignment: Alignment.center,
                    repeat: true,
                    reverse: true),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 88.0),
                child: MaterialButton(
                  shape: Globals.radius(26),
                  onPressed: () {},
                  color: Globals.primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 80),
                  child: Text("Share Link with Friends"),
                ),
              )
            ]),
      ),
    );
  }
}
