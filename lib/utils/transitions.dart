import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeftTransition extends PageRouteBuilder {
  final Widget child;
  LeftTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) => FadeTransition(
                opacity: CurvedAnimation(
                    curve: Curves.easeInOut,
                    parent: animation,
                    reverseCurve: Curves.fastLinearToSlowEaseIn),
                child: child),
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            barrierColor: Colors.transparent,
            opaque: false,
            barrierDismissible: false,
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return Align(
                alignment: Alignment.topLeft,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 1,
                  child: child,
                ),
              );
            });
}

class RightTransition extends PageRouteBuilder {
  final Widget child;
  RightTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) => FadeTransition(
                opacity: CurvedAnimation(
                    curve: Curves.easeInOut,
                    parent: animation,
                    reverseCurve: Curves.fastLinearToSlowEaseIn),
                child: child),
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            barrierColor: Colors.transparent,
            opaque: false,
            barrierDismissible: false,
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return Align(
                alignment: Alignment.center,
                child: SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(1, 0), end: const Offset(0, 0))
                      .animate(animation),
                  child: child,
                ),
              );
            });
}
