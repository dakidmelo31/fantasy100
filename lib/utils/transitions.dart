import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeftTransition extends PageRouteBuilder {
  final Widget child;
  LeftTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) => child,
            transitionDuration: Duration(milliseconds: 800),
            reverseTransitionDuration: Duration(milliseconds: 200),
            barrierColor: Colors.transparent,
            opaque: false,
            barrierDismissible: false,
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0,
                  child: child,
                ),
              );
            });
}
