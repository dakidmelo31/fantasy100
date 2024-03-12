import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/globals.dart';

class ScaleAnim extends StatefulWidget {
  @override
  _ScaleAnimState createState() => _ScaleAnimState();
}

class _ScaleAnimState extends State<ScaleAnim> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        width: 80,
        child: Animator<double>(
          duration: const Duration(milliseconds: 1500),
          cycles: 0,
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 0.0, end: 15.0),
          builder: (context, animatorState, child) => Container(
            margin: EdgeInsets.all(animatorState.value),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Globals.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Globals.primaryColor.withOpacity(0.25),
                  offset: const Offset(0, 5),
                  blurRadius: 30,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                FontAwesomeIcons.rightToBracket,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
