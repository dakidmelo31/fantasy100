import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/pages/transactions/parking_overlay.dart';
import 'package:hospital/utils/transitions.dart';

import '../models/manager.dart';
import '../utils/globals.dart';

class PlayerTile extends StatefulWidget {
  PlayerTile({super.key, required this.index, required this.manager});
  final Manager manager;
  int index;

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  late final Manager manager;
  @override
  void initState() {
    manager = widget.manager;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Hero(
      tag: "${widget.index}",
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
        child: MaterialButton(
          padding: const EdgeInsets.only(left: 1.5, bottom: 5, top: 5),
          enableFeedback: true,
          onPressed: () {
            // if (false)
            Navigator.push(context,
                LeftTransition(child: ManagerOverlay(index: widget.index)));
          },
          shape: Globals.radius(20),
          color: Globals.white,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                shape: const CircleBorder(),
                color: Colors.grey.withOpacity(.25),
                onPressed: () {
                  HapticFeedback.heavyImpact();
                },
                elevation: 0,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 45,
                        height: 45,
                        child: Center(
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: manager.image,
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  errorWidget2,
                              placeholder: (context, url) => placeholder,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: .0, right: 4),
                        child: Material(
                          shape: Globals.radius(16),
                          color: Colors.black,
                          child: SizedBox(
                            width: 35,
                            height: 25,
                            child: Center(
                              child: Text(
                                (widget.index + 1).toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        manager.teamName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Globals.title,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 4),
                          child: SizedBox(
                            width: size.width * .4,
                            child: Text(
                              manager.username,
                              style: const TextStyle(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Card(
                shape: Globals.radius(20),
                elevation: 20,
                shadowColor: Colors.black.withOpacity(.09),
                color: Globals.white,
                surfaceTintColor: Colors.white,
                child: SizedBox(
                  width: 65,
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        prettyNumber(manager.total),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: "Lato"),
                      ),
                      Text(
                        "POINTS",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: Globals.primaryColor.withOpacity(.66),
                            fontFamily: "Lato"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
