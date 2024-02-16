import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/globals.dart';
import '../../widgets/parking_tile.dart';

class ParkingHistory extends StatefulWidget {
  const ParkingHistory({super.key});

  @override
  State<ParkingHistory> createState() => _ParkingHistoryState();
}

class _ParkingHistoryState extends State<ParkingHistory>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn);
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Globals.backgroundColor,
          appBar: AppBar(
            leading: Hero(
                tag: "backbutton",
                child: const BackButton(color: Globals.primaryColor)),
            elevation: 10,
            shadowColor: Colors.black.withOpacity(.085),
            foregroundColor: Globals.primaryColor,
            title: const Text(
              "Parking History",
              style: Globals.heading,
            ),
            backgroundColor: Globals.backgroundColor,
          ),
          body: ListView.builder(
            itemCount: 50,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) {
              return ParkingTile(
                index: index,
                callback: () {
                  debugPrint("Here once more");
                  _animationController.forward();
                },
              );
            },
          ),
        ),
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: size.height,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 7 * _animation.value,
                    sigmaY: 7 * _animation.value,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                  ),
                ),
              );
            })
      ],
    );
  }
}
