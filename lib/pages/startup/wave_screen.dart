import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/globals.dart';

class WaveScreen extends StatefulWidget {
  const WaveScreen({super.key});

  @override
  State<WaveScreen> createState() => _WaveScreenState();
}

class _WaveScreenState extends State<WaveScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _flip = false;
  bool _flip2 = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          _flip = true;
        });
      },
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          _flip2 = true;
        });
      },
    );

    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.decelerate);
    super.initState();
  }

  late final Animation<double> _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.primaryColor,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  color: Colors.white,
                  width: _flip
                      ? size.width
                      : _flip2
                          ? 100
                          : 20 + size.width * (1 - _animation.value),
                  duration: Duration(
                    milliseconds: _flip ? 1000 : 300,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _flip
                      ? size.height
                      : 1 + size.height * (1 - _animation.value),
                ),
              ),
              Center(
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  padding: !_flip
                      ? EdgeInsets.only(top: size.width * .8)
                      : EdgeInsets.zero,
                  child: AnimatedOpacity(
                    opacity: !_flip ? 0 : 1.0,
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Text(
                      Globals.appName,
                      style: GoogleFonts.acme(
                          fontWeight: FontWeight.w300,
                          fontSize: 40,
                          color: Globals.primaryColor),
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
