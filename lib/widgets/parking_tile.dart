import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/models/player.dart';
import 'package:hospital/pages/transactions/parking_overlay.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:jiffy/jiffy.dart';

import '../utils/globals.dart';

class PlayerTile extends StatefulWidget {
  PlayerTile({super.key, required this.index, required this.player});
  final Player player;
  int index;

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  late final Player player;
  @override
  void initState() {
    player = widget.player;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Hero(
      tag: "${widget.index}",
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 1),
        child: MaterialButton(
          padding: const EdgeInsets.only(left: 1.5, bottom: 10, top: 10),
          enableFeedback: true,
          onPressed: () {
            // if (false)
            Navigator.push(context,
                LeftTransition(child: ParkingOverlay(index: widget.index)));
          },
          shape: Globals.radius(20),
          color: Globals.lightBlack.withOpacity(.5),
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                shape: const CircleBorder(),
                color: Globals.black,
                onPressed: () {
                  HapticFeedback.heavyImpact();
                },
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: 55,
                    height: 55,
                    child: Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: player.image,
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => errorWidget2,
                          placeholder: (context, url) => placeholder,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Mr Melo FC with higher levels of adrenaline",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Globals.greyTitle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: .0, right: 4),
                          child: Material(
                            shape: CircleBorder(),
                            color: Colors.black,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Center(
                                child: Text(
                                  widget.index.toString(),
                                  style: const TextStyle(
                                      color: Globals.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 0.0, right: 4),
                          child: Text(
                            "Ndoye Philip Ndula",
                            style: TextStyle(
                                color: Color(0xffaaaaaa),
                                fontWeight: FontWeight.w400),
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
                color: Globals.lightBlack,
                child: SizedBox(
                  width: 65,
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        player.rank,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: Globals.primaryColor,
                            fontFamily: "Lato"),
                      ),
                      Text(
                        "POINTS",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: Globals.white.withOpacity(.66),
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
