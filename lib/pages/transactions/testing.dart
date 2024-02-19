import 'package:flutter/material.dart';

class BulgingEdgeCard extends StatelessWidget {
  final Widget child;

  BulgingEdgeCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 100.0,
          ),
          Positioned(
            top: -10.0,
            right: -10.0,
            child: ClipPath(
              clipper: BulgingEdgeClipper(),
              child: Container(
                color: Colors.black,
                width: 50.0,
                height: 50.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: child,
          ),
        ],
      ),
    );
  }
}

class BulgingEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.8, size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
