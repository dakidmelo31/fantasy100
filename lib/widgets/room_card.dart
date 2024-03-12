import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hospital/models/group.dart';
import 'package:hospital/pages/transactions/group_overview.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/utils/transitions.dart';

class RoomCard extends StatefulWidget {
  const RoomCard({super.key, required this.card});
  final Group card;

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  late final Group card;

  @override
  void initState() {
    card = widget.card;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              LeftTransition(
                  child: GroupOverview(
                manager: widget.card,
              )));
        },
        child: Hero(
          tag: widget.card.image + widget.card.title,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: CachedNetworkImage(
              imageUrl: widget.card.image,
              placeholder: (context, url) => placeholder,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => errorWidget2,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.8, size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
