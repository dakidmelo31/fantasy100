import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../utils/globals.dart';

class HoneyPot extends StatefulWidget {
  @override
  _HoneyPotState createState() => _HoneyPotState();
}

class _HoneyPotState extends State<HoneyPot> {
  @override
  Widget build(BuildContext context) {
    return DraggableCard(
      child: Card(
        elevation: 30,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: Globals.radius(10),
        shadowColor: Globals.primaryColor.withOpacity(.85),
        color: Globals.primaryColor,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
          height: 150,
          width: 300,
          decoration: const BoxDecoration(
            color: Globals.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const Center(
            child: Text(
              '5,000 CFA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({required this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _dragAlignment = Alignment.center;

  late Animation<Alignment> _animation;

  final _spring = const SpringDescription(
    mass: 7,
    stiffness: 1200,
    damping: 0.7,
  );

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0.0, 1.0, _normalizeVelocity(velocity, size));

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanStart: (details) => _controller.stop(canceled: true),
      onPanUpdate: (details) => setState(
        () => _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2),
        ),
      ),
      onPanEnd: (details) =>
          _runAnimation(details.velocity.pixelsPerSecond, size),
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
