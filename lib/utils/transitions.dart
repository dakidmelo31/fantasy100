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

class VerticalSizeTransition extends PageRouteBuilder {
  VerticalSizeTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionsBuilder: (_, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionDuration: const Duration(
              milliseconds: 800,
            ),
            opaque: false,
            barrierColor: Colors.black.withOpacity(.6));

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  final Widget child;
}

class HorizontalSizeTransition extends PageRouteBuilder {
  HorizontalSizeTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionsBuilder: (_, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionDuration: const Duration(
              milliseconds: 800,
            ),
            opaque: false,
            barrierColor: Colors.black.withOpacity(.6));

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  final Widget child;
}

class CustomFadeTransition extends PageRouteBuilder {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  CustomFadeTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionsBuilder: (_, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionDuration: const Duration(
              milliseconds: 800,
            ),
            opaque: false,
            barrierColor: Colors.black.withOpacity(.6));

  final Widget child;
}

class SizeTransition1 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  SizeTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1400),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class TransLucentPush extends PageRouteBuilder {
  final Widget page;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  TransLucentPush(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          opaque: false,
          barrierColor: Colors.white.withOpacity(.8),
          barrierDismissible: true,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class SizeTransition2 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  SizeTransition2(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1400),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class SizeTransition22 extends PageRouteBuilder {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  final Widget page;

  SizeTransition22(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1400),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class TransparentSizeTransition2 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  TransparentSizeTransition2(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          opaque: false,
          barrierDismissible: true,
          reverseTransitionDuration: const Duration(milliseconds: 200),
          barrierColor: Colors.transparent,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.topCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class TransparentSizeTransition1 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  TransparentSizeTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          opaque: false,
          barrierDismissible: true,
          reverseTransitionDuration: const Duration(milliseconds: 200),
          barrierColor: Colors.transparent,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                axisAlignment: 16.0,
                child: page,
              ),
            );
          },
        );
}

class ScaleTransition1 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  ScaleTransition1(this.page)
      : super(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(.95),
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1400),
          reverseTransitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.elasticInOut,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                  scale: animation,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.high,
                  child: Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: MediaQuery.of(context).size.height / 22),
                      elevation: 60,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: page,
                      ))),
            );
          },
        );
}

class SizeTransition4 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  SizeTransition4(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerLeft,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class SizeTransition5 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  SizeTransition5(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class SizeTransition55 extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  SizeTransition55(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          opaque: false,
          barrierColor: Colors.transparent,
          barrierDismissible: false,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                axisAlignment: 100,
                child: page,
              ),
            );
          },
        );
}
