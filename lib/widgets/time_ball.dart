import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TimeBall extends StatelessWidget {
  final Widget child;
  const TimeBall({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(.2),
      shape: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: child,
      ),
    );
  }
}
