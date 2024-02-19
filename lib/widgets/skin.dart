import 'package:flutter/material.dart';

class Skin extends StatelessWidget {
  const Skin({super.key, required this.child, required this.tag});
  final Widget child;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: child,
      ),
    );
  }
}
