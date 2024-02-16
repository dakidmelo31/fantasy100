import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/pages/transactions/parking_overlay.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:jiffy/jiffy.dart';

import '../utils/globals.dart';

class ParkingTile extends StatefulWidget {
  ParkingTile({super.key, required this.index, required this.callback});
  final VoidCallback callback;
  int index;

  @override
  State<ParkingTile> createState() => _ParkingTileState();
}

class _ParkingTileState extends State<ParkingTile> {
  late bool test;
  @override
  void initState() {
    test = widget.index % 3 == 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Hero(
      tag: "${widget.index}",
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: MaterialButton(
          padding: EdgeInsets.only(left: 1.5, bottom: 10, top: 10),
          enableFeedback: true,
          onPressed: () {
            widget.callback();
            // if (false)
            Navigator.push(context,
                LeftTransition(child: ParkingOverlay(index: widget.index)));
          },
          shape: Globals.radius(20),
          color: Globals.white,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                shape: const CircleBorder(),
                color: Colors.white,
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
                          imageUrl:
                              "https://unsplash.com/photos/mEZ3PoFGs_k/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzAyODQ3ODM1fA&force=true&w=640",
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
                        "Marounie Local Mall",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Globals.title,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 4),
                          child: Text(
                            test ? "N\$ 50.0" : 'Free',
                            style: TextStyle(
                                color: !test
                                    ? Color(0xff00aa00)
                                    : Globals.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 4),
                          child: Text(
                            Jiffy.parseFromDateTime(
                                    DateTime.now().subtract(Duration(days: 65)))
                                .yMEd
                                .toString(),
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
              Spacer(),
              Card(
                shape: Globals.radius(20),
                elevation: 20,
                shadowColor: Colors.black.withOpacity(.09),
                color: Globals.white,
                child: SizedBox(
                  width: 45,
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "2h",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Globals.primaryColor,
                            fontFamily: "Lato"),
                      ),
                      Text(
                        "49 mins",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: Color(0xff000000),
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