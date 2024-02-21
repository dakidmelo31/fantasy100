import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/globals.dart';
import 'package:provider/provider.dart';

import '../models/manager.dart';

class DragNotch extends StatefulWidget {
  final VoidCallback flipCallback;

  const DragNotch(
      {Key? key,
      required this.flipCallback,
      required this.pullDown,
      required this.pullUp})
      : super(key: key);
  final VoidCallback pullDown, pullUp;

  @override
  State<DragNotch> createState() => _DragNotchState();
}

class _DragNotchState extends State<DragNotch> {
  bool switchText = false;
  String text = "Pull to Open";
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: false);
    final Manager? top = data.managers.isNotEmpty ? data.managers.first : null;
    final size = getSize(context);
    return DraggableCard(
      flipCallback: widget.flipCallback,
      pullDown: widget.pullDown,
      pullUp: widget.pullUp,
      switchText: () {
        HapticFeedback.heavyImpact();
        setState(() {
          if (switchText) {
            text = "Leaderboard";
          }
          switchText = !switchText;
        });
      },
      switchBack: () {
        HapticFeedback.heavyImpact();
        setState(() {
          text = data.managers.isEmpty ? data.currentGameWeek : top!.teamName;
          switchText = !switchText;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        height: 52.0,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(data.managers.isEmpty ? "-" : prettyNumber(top!.total),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(FontAwesomeIcons.crown,
                      size: 15,
                      color:
                          !data.isComplete ? Colors.amber : Color(0xffaaaaaa)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final VoidCallback flipCallback;

  const DraggableCard({
    Key? key,
    required this.child,
    required this.flipCallback,
    required this.pullUp,
    required this.pullDown,
    required this.switchText,
    required this.switchBack,
  }) : super(key: key);
  final Widget child;
  final VoidCallback pullUp, pullDown, switchText, switchBack;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  var _dragAlignment = Alignment.center;
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  final _spring =
      const SpringDescription(mass: 7, stiffness: 1500, damping: .94);

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity =
        Offset(velocity.dx / size.width, velocity.dy / size.height);
    return -normalizedVelocity.distance;
  }

  void runAnimation(Offset velocity, Size size) {
    _animation = _controller
        .drive(AlignmentTween(begin: _dragAlignment, end: Alignment.center));
    final simulation =
        SpringSimulation(_spring, 0.0, 1.0, _normalizeVelocity(velocity, size));
    _controller.animateWith(simulation);
  }

  double begin = 0;
  double end = 0;
  bool top = false;

  @override
  void initState() {
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() {
        setState(() {
          _dragAlignment = _animation.value;
        });
      });
    super.initState();
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
      onPanStart: (details) {
        begin = details.globalPosition.distance;
        _controller.stop(canceled: true);
      },
      onPanEnd: (details) {
        runAnimation(details.velocity.pixelsPerSecond, size);
      },
      onPanUpdate: (details) {
        if (details.delta.dy > 0) {
          setState(() {
            widget.switchBack();
            widget.pullDown();
          });
        } else if (details.delta.dy < 0) {
          setState(() {
            widget.switchText();
            widget.pullUp();
          });
        }

        setState(
          () {
            _dragAlignment += Alignment(details.delta.dx / (size.width / 2),
                details.delta.dy / ((size.height * .2) / 2));
          },
        );
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
            surfaceTintColor: Colors.white,
            elevation: 20,
            shadowColor: Colors.grey.withOpacity(.2),
            color: Globals.brown,
            shape: Globals.radius(10),
            child: InkWell(
              splashColor: Globals.black,
              highlightColor: Globals.black,
              onTap: widget.flipCallback,
              customBorder: Globals.radius(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: widget.child,
              ),
            )),
      ),
    );
  }
}
