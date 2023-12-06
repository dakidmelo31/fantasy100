import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParkTile extends StatelessWidget {
  const ParkTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      elevation: 10,
      shadowColor: Colors.white.withOpacity(.25),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                elevation: 0,
                shape: CircleBorder(),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Text(
                      "\$2",
                      style: TextStyle(fontSize: 22, fontFamily: "Lato"),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Plan to Work past",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Started",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      " - 12/12 2:35 PM",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chevron_right_rounded,
                    size: 40,
                    color: Colors.grey,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
