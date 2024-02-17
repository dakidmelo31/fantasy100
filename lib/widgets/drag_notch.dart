import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:hospital/utils/globals.dart';

class DragNotch extends StatefulWidget {
  const DragNotch({Key? key, required this.pullDown, required this.pullUp})
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
    final size = getSize(context);
    return DraggableCard(
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        height: 52.0,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.white)),
            Text("306",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      pullDown: widget.pullDown,
      pullUp: widget.pullUp,
      switchText: () {
        HapticFeedback.heavyImpact();
        setState(() {
          if (switchText) {
            text = "GW 25";
          }
          switchText = !switchText;
        });
      },
      switchBack: () {
        HapticFeedback.heavyImpact();
        setState(() {
          text = "GW 25";
          switchText = !switchText;
        });
      },
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({
    Key? key,
    required this.child,
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
            color: Color(0xff1A1423),
            shape: Globals.radius(10),
            child: InkWell(
              splashColor: Globals.black,
              highlightColor: Globals.black,
              onTap: () {},
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
