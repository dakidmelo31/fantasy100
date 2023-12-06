import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/widgets/park_tile.dart';

class ParkingHistory extends StatefulWidget {
  const ParkingHistory({super.key});

  @override
  State<ParkingHistory> createState() => _ParkingHistoryState();
}

class _ParkingHistoryState extends State<ParkingHistory> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Parking History"),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        size: 32,
                      )),
                ],
              ),
            ),
          ),
          ...List<Widget>.generate(1, (index) => const ParkTile()).toList()
        ],
      ),
    );
  }
}
